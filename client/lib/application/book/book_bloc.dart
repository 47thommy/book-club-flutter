import 'package:client/domain/book/book_repository_interface.dart';
import 'package:client/infrastructure/group/group_repository.dart';
import 'package:client/infrastructure/user/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer';

import 'book_event.dart';
import 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  final IBookRepository bookRepository;

  final UserRepository userRepository;

  BookBloc({
    required this.bookRepository,
    required this.userRepository,
  }) : super(BookInit()) {
    //
    // Book create
    on<BookCreate>((event, emit) async {
      final token = await userRepository.getToken();

      final result =
          await bookRepository.createBook(event.book, event.groupId, token);

      if (result.hasError) {
        emit(BookOperationFailure(result.failure!));
      } else {
        emit(BookCreated(result.value!, event.groupId));
      }
    });

    //
    // Book update
    on<BookUpdate>((event, emit) async {
      final token = await userRepository.getToken();

      final result =
          await bookRepository.updateBook(event.book, event.groupId, token);

      if (result.hasError) {
        emit(BookOperationFailure(result.failure!));
      } else {
        emit(BookUpdated(result.value!));
      }
    });

    //
    // Book delete
    on<BookDelete>((event, emit) async {
      final token = await userRepository.getToken();

      final result =
          await bookRepository.deleteBook(event.bookId, event.groupId, token);

      if (result.hasError) {
        emit(BookOperationFailure(result.failure!));
      } else {
        emit(BookDeleted(event.bookId));
      }
    });
  }
}
