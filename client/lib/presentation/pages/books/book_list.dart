import 'package:client/application/book/book_bloc.dart';
import 'package:client/application/book/book_state.dart';
import 'package:client/application/group/group.dart';
import 'package:client/domain/book/book.dart';

import 'package:client/domain/group/group.dart';
import 'package:client/infrastructure/book/book_repository.dart';
import 'package:client/infrastructure/book/dto/book_mapper.dart';
import 'package:client/infrastructure/group/group_repository.dart';
import 'package:client/infrastructure/user/user_repository.dart';
import 'package:client/presentation/pages/common/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReadingListScreen extends StatefulWidget {
  static const routeName = 'readinglist';

  final int groupId;

  const ReadingListScreen(this.groupId, {super.key});

  @override
  State<ReadingListScreen> createState() => _ReadingListState();
}

class _ReadingListState extends State<ReadingListScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => BookBloc(
              bookRepository: context.read<BookRepository>(),
              userRepository: context.read<UserRepository>(),
            ),

        //
        child: BlocConsumer<BookBloc, BookState>(
          listener: (context, state) {
            // on book create
            if (state is BookCreated) {
              showSuccess(context, 'Book created');
              context.read<GroupBloc>().add(LoadGroupDetail(widget.groupId));
            }

            // on book delete
            else if (state is BookUpdated) {
              showSuccess(context, 'Book deleted');
              context.read<GroupBloc>().add(LoadGroupDetail(widget.groupId));
            }

            // on error
            else if (state is BookOperationFailure) {
              showFailure(context, state.error.failure.toString());
            }
          },

          // body
          builder: (context, state) {
            return BlocProvider(
                create: (context) => GroupBloc(
                    userRepository: context.read<UserRepository>(),
                    groupRepository: context.read<GroupRepository>())
                  ..add(LoadGroupDetail(widget.groupId)),

                //
                child: Scaffold(
                    appBar: AppBar(title: const Text('Reading List')),
                    //
                    body: BlocBuilder<GroupBloc, GroupState>(
                        builder: (context, state) {
                      if (state is GroupDetailLoaded) {
                        return ListView.builder(
                            itemCount: state.group.books.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                  padding: const EdgeInsets.all(10),
                                  //
                                  child: Collapsable(
                                      state.group.books[index].toBook()));
                            });
                      }

                      return const Center(child: CircularProgressIndicator());
                    })));
          },
        ));
  }
}

class Collapsable extends StatefulWidget {
  final Book book;
  const Collapsable(
    this.book, {
    Key? key,
  }) : super(key: key);

  @override
  State<Collapsable> createState() => _CollapsableState();
}

class _CollapsableState extends State<Collapsable> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Column(
              children: [
                Card(
                  elevation: 3.0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                        //
                        children: [
                          //
                          // Title
                          ListTile(
                            onTap: () {
                              setState(() {
                                isExpanded = !isExpanded;
                              });
                            },
                            leading: Container(
                              width: 50.0,
                              height: 50.0,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black,
                              ),
                              child: const Icon(Icons.book),
                            ),
                            title: Text(widget.book.title),
                            subtitle: Text(widget.book.author),
                          ),
                        ]),
                  ),
                ),

                // Detail hidden by default
                if (isExpanded)
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(5),
                            child: Text(
                              widget.book.description,
                            )),
                      ],
                    ),
                  ),
              ],
            )),
      ],
    );
  }
}
