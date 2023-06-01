import 'package:client/application/poll/poll.dart';
import 'package:test/test.dart';
import 'package:client/domain/poll/poll.dart';
import 'package:client/utils/failure.dart';

void main() {
  group('Poll', () {
    test('PollInit should  override props', () {
      final state = PollInit();

      expect(state.props, isEmpty);
    });
  });
}
