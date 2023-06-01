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

    test('PollCreated should  override props', () {
      const poll = Poll(id: 1, options: [], question: '');
      const groupId = 1;
      const state = PollCreated(poll, groupId);

      expect(state.props, [poll]);
    });

    test('PollDeleted should  override props', () {
      const pollId = 1;
      const state = PollDeleted(pollId);

      expect(state.props, [pollId]);
    });
  });
}
