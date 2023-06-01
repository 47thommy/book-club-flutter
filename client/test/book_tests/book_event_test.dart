import 'package:client/application/book/book_event.dart';
import 'package:test/test.dart';
import 'package:client/domain/book/book.dart';

void main() {
  group('BookEvent', () {
    group('BookCreate', () {
      test('props are [book]', () {
        const book = Book(
            author: 'test',
            description: 'test',
            genre: 'test',
            id: 1,
            pageCount: 255,
            title: 'test');
        const groupId = 1;
        const event = BookCreate(book, groupId);

        expect(event.props, [book]);
      });

      test('toString returns correct value', () {
        const book = Book(
            author: 'test',
            description: 'test',
            genre: 'test',
            id: 1,
            pageCount: 255,
            title: 'test');
        const groupId = 1;
        const event = BookCreate(book, groupId);

        expect(event.toString(), 'book create { book: $book }');
      });
    });

    group('BookUpdate', () {
      test('props are [book, groupId]', () {
        const book = Book(
            author: 'test',
            description: 'test',
            genre: 'test',
            id: 1,
            pageCount: 255,
            title: 'test');
        const groupId = 1;
        const event = BookUpdate(book, groupId);

        expect(event.props, [book, groupId]);
      });

      test('toString returns correct value', () {
        const book = Book(
            author: 'test',
            description: 'test',
            genre: 'test',
            id: 1,
            pageCount: 255,
            title: 'test');
        const groupId = 1;
        const event = BookUpdate(book, groupId);

        expect(event.toString(), 'book update { book: ${book.id} }');
      });
    });

    group('BookDelete', () {
      test('props are [bookId, groupId]', () {
        const bookId = 1;
        const groupId = 1;
        const event = BookDelete(bookId, groupId);

        expect(event.props, [bookId, groupId]);
      });

      test('toString returns correct value', () {
        const bookId = 1;
        const groupId = 1;
        const event = BookDelete(bookId, groupId);

        expect(event.toString(), 'book delete { book_id: $bookId }');
      });
    });
  });
}
