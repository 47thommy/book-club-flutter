import 'package:client/application/meeting/meeting_state.dart';
import 'package:client/domain/meeting/meeting.dart';
import 'package:client/utils/failure.dart';
import 'package:test/test.dart';

void main() {
  group('MeetingState', () {
    test('MeetingInit should override props correctly', () {
      final state = MeetingInit();

      expect(state.props, []);
    });

    test('MeetingCreated should override props correctly', () {
      final meeting = Meeting(
          description: "description",
          id: 1,
          location: 'location',
          time: DateTime.now());
      const groupId = 2;
      final state = MeetingCreated(meeting, groupId);

      expect(state.props, [meeting]);
    });

    test('MeetingUpdated should override props correctly', () {
      final meeting = Meeting(
          description: "description",
          id: 1,
          location: 'location',
          time: DateTime.now());
      final state = MeetingUpdated(meeting);

      expect(state.props, [meeting]);
    });

    test('MeetingDeleted should override props correctly', () {
      const meetingId = 1;
      const state = MeetingDeleted(meetingId);

      expect(state.props, [meetingId]);
    });

    test('MeetingOperationFailure should override props correctly', () {
      const error = Failure('Meeting operation failed');
      const state = MeetingOperationFailure(error);

      expect(state.props, [error]);
      expect(state.toString(), 'MeetingOperationFailure { error: $error }');
    });
  });
}
