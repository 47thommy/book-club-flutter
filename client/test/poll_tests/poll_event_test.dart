import 'package:client/application/poll/poll.dart';
import 'package:test/test.dart';
import 'package:client/domain/poll/poll_form.dart';

void main() {
  group('poll', () {
    test('PollCreate should properly override props and toString()', () {
      const pollForm = PollForm(options: [], question: '');
      const groupId = 1;
      const event1 = PollCreate(pollForm, groupId);
      const event2 = PollCreate(pollForm, groupId);

      expect(event1.props, [pollForm]);

      expect(event1.props, event2.props);

      expect(
        event1.toString(),
        'Poll create { poll: $pollForm }',
      );
    });

    test('PollDelete should properly override props and toString()', () {
      const pollId = 1;
      const groupId = 1;
      const event1 = PollDelete(pollId, groupId);
      const event2 = PollDelete(pollId, groupId);

      expect(event1.props, [pollId, groupId]);

      expect(event1.props, event2.props);

      expect(
        event1.toString(),
        'poll delete { poll_id: $pollId }',
      );
    });
  });
}
