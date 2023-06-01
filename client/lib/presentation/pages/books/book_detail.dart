import 'dart:developer';

import 'package:client/infrastructure/book/dto/book_dto.dart';
import 'package:client/presentation/pages/common/page_mode.dart';
import 'package:flutter/material.dart';

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
  final genreController = TextEditingController();
  final pageCountController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ),

                      const SizedBox(height: 16.0),
                      // title
                      TextFormField(
                        controller: titleController,
                        decoration: const InputDecoration(labelText: 'Title'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter book title';
                          }
                          return null;
                        },
                        onSaved: (value) {},
                      ),

                      // genre
                      const SizedBox(height: 16.0),
                      TextFormField(
                        controller: genreController,
                        decoration: const InputDecoration(labelText: 'Author'),
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
                          decoration: const InputDecoration(labelText: 'Pages'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter number of pages';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number),

                      // description
                      const SizedBox(height: 16.0),
                      TextFormField(
                        controller: descriptionController,
                        maxLines: 5,
                        maxLength: 400,
                        decoration:
                            const InputDecoration(labelText: 'Description'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Description must not be empty';
                          }
                        },
                        onSaved: (value) {},
                      ),

                      const SizedBox(height: 16.0),

                      Center(
                        child: ElevatedButton(
                            onPressed: () {},
                            child: const Text(
                              'Add to group reading list',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
