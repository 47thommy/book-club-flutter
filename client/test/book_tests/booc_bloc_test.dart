import 'package:client/application/book/book_bloc.dart';
import 'package:client/application/book/book_event.dart';
import 'package:client/application/book/book_state.dart';
import 'package:client/domain/book/book.dart';
import 'package:client/domain/book/book_repository_interface.dart';
import 'package:client/infrastructure/group/group_repository.dart';
import 'package:client/infrastructure/user/user_repository.dart';
import 'package:client/utils/either.dart';

import 'package:client/utils/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'booc_bloc_test.mocks.dart';

@GenerateMocks([IBookRepository, GroupRepository, UserRepository])
void main() {
  late MockIBookRepository mockBookRepository;
  late MockGroupRepository mockGroupRepository;
  late MockUserRepository mockUserRepository;

  setUp(() {
    // Initialize the mock repositories
    mockBookRepository = MockIBookRepository();
    mockGroupRepository = MockGroupRepository();
    mockUserRepository = MockUserRepository();
  });

  group('BookBloc', () {
    test('emits BookCreated when BookCreate event is added', () {
      const book = Book(
          author: 'test',
          description: 'test',
          genre: 'test',
          id: 1,
          pageCount: 255,
          title: 'test');

      const token = 'mock_token';

      when(mockUserRepository.getToken())
          .thenAnswer((_) => Future.value(token));
      when(mockBookRepository.createBook(book, 1, token))
          .thenAnswer((_) => Future.value(Either<Book>(value: book)));

      final bloc = BookBloc(
        bookRepository: mockBookRepository,
        groupRepository: mockGroupRepository,
        userRepository: mockUserRepository,
      );

      expect(bloc.state, equals(BookInit()));

      bloc.add(const BookCreate(book, 1));

      expect(
        bloc.stream,
        emitsInOrder([const BookCreated(book, 1)]),
      );
    });

    test('emits BookOperationFailure when BookCreate fails', () {
      const book = Book(
          author: 'test',
          description: 'test',
          genre: 'test',
          id: 1,
          pageCount: 255,
          title: 'test');

      const token = 'mock_token';
      const failure = Failure('Failed to create book');

      when(mockUserRepository.getToken())
          .thenAnswer((_) => Future.value(token));
      when(mockBookRepository.createBook(book, 1, token))
          .thenAnswer((_) => Future.value(Either<Book>(failure: failure)));

      final bloc = BookBloc(
        bookRepository: mockBookRepository,
        groupRepository: mockGroupRepository,
        userRepository: mockUserRepository,
      );

      expect(bloc.state, equals(BookInit()));

      bloc.add(const BookCreate(book, 1));

      expect(
        bloc.stream,
        emitsInOrder([const BookOperationFailure(failure)]),
      );
    });
  });
}
