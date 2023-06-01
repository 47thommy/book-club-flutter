import 'dart:developer';

import 'package:client/application/book/book_bloc.dart';
import 'package:client/application/book/book_event.dart';
import 'package:client/application/book/book_state.dart';
import 'package:client/application/group/group.dart';
import 'package:client/domain/book/book.dart';
import 'package:client/infrastructure/book/book_repository.dart';
import 'package:client/infrastructure/book/dto/book_dto.dart';
import 'package:client/infrastructure/user/user_repository.dart';
import 'package:client/presentation/pages/common/page_mode.dart';
import 'package:client/presentation/pages/common/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class BookDescription extends StatefulWidget {
  static const routeName = 'book';

  final BookDto book;
  final int groupId;
  final PageMode mode;

  const BookDescription(
      {Key? key,
      required this.book,
      required this.groupId,
      this.mode = PageMode.view})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _BookDescriptionState();
}

class _BookDescriptionState extends State<BookDescription> {
  final _formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final authorController = TextEditingController();
  final genreController = TextEditingController();
  final pageCountController = TextEditingController();
  final descriptionController = TextEditingController();

  void _createBook(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }

    final book = Book(
        id: -1,
        author: authorController.text,
        title: titleController.text,
        pageCount: int.parse(pageCountController.text),
        description: descriptionController.text,
        genre: genreController.text);

    context.read<BookBloc>().add(BookCreate(book, widget.groupId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => BookBloc(
            bookRepository: context.read<BookRepository>(),
            userRepository: context.read<UserRepository>()),

        // listener
        child: BlocListener<BookBloc, BookState>(
            listener: (context, state) {
              // on book create
              if (state is BookCreated) {
                showSuccess(context, 'Book created');
                context.read<GroupBloc>().add(LoadGroupDetail(widget.groupId));
                context.pop();
              }

              // on book delete
              else if (state is BookUpdated) {
                showSuccess(context, 'Book deleted');
                context.read<GroupBloc>().add(LoadGroupDetail(widget.groupId));
                context.pop();
              }

              // on error
              else if (state is BookOperationFailure) {
                showFailure(context, state.error.failure.toString());
              }
            },

            //
            // screen
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  widget.mode == PageMode.create ? '' : widget.book.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      child: Form(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Center(
                                child: Text(
                                  "Add book to reading list",
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),

                              const SizedBox(height: 16.0),
                              // title
                              TextFormField(
                                controller: titleController,
                                decoration:
                                    const InputDecoration(labelText: 'Title'),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter book title';
                                  }
                                  return null;
                                },
                                onSaved: (value) {},
                              ),

                              // author
                              const SizedBox(height: 16.0),
                              TextFormField(
                                controller: authorController,
                                decoration:
                                    const InputDecoration(labelText: 'Author'),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter book author';
                                  }
                                  return null;
                                },
                              ),

                              // page count
                              const SizedBox(height: 16.0),
                              TextFormField(
                                  controller: pageCountController,
                                  decoration:
                                      const InputDecoration(labelText: 'Pages'),
                                  validator: (value) {
                                    if (value!.isEmpty ||
                                        int.tryParse(value) == null) {
                                      return 'Please enter number of pages';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.number),

                              // genre
                              const SizedBox(height: 16.0),
                              TextFormField(
                                controller: genreController,
                                decoration:
                                    const InputDecoration(labelText: 'Genre'),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter genre of page book';
                                  }
                                  return null;
                                },
                              ),

                              // description
                              const SizedBox(height: 16.0),
                              TextFormField(
                                controller: descriptionController,
                                maxLines: 5,
                                maxLength: 400,
                                decoration: const InputDecoration(
                                    labelText: 'Description'),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Description must not be empty';
                                  }
                                },
                                onSaved: (value) {},
                              ),

                              const SizedBox(height: 16.0),

                              Center(
                                child: BlocBuilder<BookBloc, BookState>(
                                    builder: (context, state) {
                                  return ElevatedButton(
                                      onPressed: () {
                                        _createBook(context);
                                      },
                                      child: const Text(
                                        'Add to group reading list',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ));
                                }),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }
}
