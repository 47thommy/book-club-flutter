import 'package:client/domain/book/book.dart';
import 'package:client/infrastructure/book/book_repository.dart';
import 'package:client/infrastructure/book/data_providers/book_api.dart';
import 'package:client/infrastructure/book/dto/book_dto.dart';
import 'package:client/infrastructure/book/dto/book_mapper.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'book_repository_test.mocks.dart';

@GenerateMocks([BookApi])
void main() {
  group('BookRepository', () {
    late BookRepository bookRepository;
    late MockBookApi mockBookApi;

    setUp(() {
      mockBookApi = MockBookApi();
      bookRepository = BookRepository(api: mockBookApi);
    });

    test('createBook returns Either with value when book creation succeeds',
        () async {
      const book = Book(
          id: 1,
          title: "title",
          author: "author",
          description: "description",
          pageCount: 3,
          genre: "genre");
      const groupId = 1;
      const token = 'token';

      when(mockBookApi.createBook(book.toBookDto(), groupId, token)).thenAnswer(
          (_) async => const BookDto(
              id: 1,
              title: "title",
              author: "author",
              description: "description",
              pageCount: 3,
              genre: "genre"));

      final result = await bookRepository.createBook(book, groupId, token);

      if (result.hasError) {
        fail(
            'Expected a value, but received an error: ${result.failure!.toString()}');
      } else {
        expect(result.value, isA<Book>());
      }
    });

    test('updateBook returns Either with value when book update succeeds',
        () async {
      const book = Book(
          id: 1,
          title: "title",
          author: "author",
          description: "description",
          pageCount: 3,
          genre: "genre");
      const groupId = 1;
      const token = 'token';

      // Stub the mockBookApi.updateBook method to return the updated book
      when(mockBookApi.updateBook(book.toBookDto(), groupId, token)).thenAnswer(
          (_) async => const BookDto(
              id: 1,
              title: "title",
              author: "author",
              description: "description",
              pageCount: 3,
              genre: "genre"));

      final result = await bookRepository.updateBook(book, groupId, token);

      if (result.hasError) {
        fail(
            'Expected a value, but received an error: ${result.failure!.toString()}');
      } else {
        expect(result.value, isA<Book>());
      }
    });

    test(
        'deleteBook returns Either with value true when book deletion succeeds',
        () async {
      const bookId = 1;
      const groupId = 1;
      const token = 'token';

      when(mockBookApi.deleteBook(groupId, bookId, token))
          .thenAnswer((_) async => Future(() => true));

      final result = await bookRepository.deleteBook(bookId, groupId, token);

      if (result.hasError) {
        fail(
            'Expected a value, but received an error: ${result.failure!.toString()}');
      } else {
        expect(result.value, true);
      }
    });

    tearDown(() {
      bookRepository = BookRepository(api: mockBookApi);
    });
  });
}
