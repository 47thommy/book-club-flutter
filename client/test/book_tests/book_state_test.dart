import 'package:client/application/book/book_state.dart';
import 'package:test/test.dart';
import 'package:client/domain/book/book.dart';
import 'package:client/utils/failure.dart';

void main() {
  group('BookState', () {
    test('BookInit props are empty', () {
      final state = BookInit();

      expect(state.props, isEmpty);
    });

    group('BookCreated', () {
      test('props are [book]', () {
        const book = Book(
            author: 'test',
            description: 'test',
            genre: 'test',
            id: 1,
            pageCount: 255,
            title: 'test');
        const groupId = 1;
        final state = const BookCreated(book, groupId);

        expect(state.props, [book]);
      });
    });

    group('BookUpdated', () {
      test('props are [book]', () {
        const book = Book(
            author: 'test',
            description: 'test',
            genre: 'test',
            id: 1,
            pageCount: 255,
            title: 'test');
        final state = const BookUpdated(book);

        expect(state.props, [book]);
      });
    });

    group('BookDeleted', () {
      test('props are [bookId]', () {
        const bookId = 1;
        final state = const BookDeleted(bookId);

        expect(state.props, [bookId]);
      });
    });

    group('BookOperationFailure', () {
      test('props are [error]', () {
        const error = Failure("error");
        final state = const BookOperationFailure(error);

        expect(state.props, [error]);
      });

      test('toString returns correct value', () {
        const error = Failure("error");
        final state = const BookOperationFailure(error);

        expect(state.toString(), 'BookOperationFailure { error: $error }');
      });
    });
  });
}
