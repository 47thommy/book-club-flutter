import 'package:client/application/meeting/meeting_event.dart';
import 'package:client/domain/meeting/meeting.dart';
import 'package:test/test.dart';

void main() {
  group('MeetingEvent', () {
    test('MeetingCreate should correctly override props and toString()', () {
      final meeting = Meeting(
          description: "description",
          id: 1,
          location: 'location',
          time: DateTime.now());

      final event = MeetingCreate(
          Meeting(
              description: "description",
              id: 1,
              location: 'location',
              time: DateTime.now()),
          1);

      expect(event.props, [meeting]);
      expect(event.toString(), 'meeting create { meeting: $meeting }');
    });

    test('MeetingUpdate should correctly override props and toString()', () {
      final meeting = Meeting(
          description: "description",
          id: 1,
          location: 'location',
          time: DateTime.now());
      const groupId = 2;
      final event = MeetingUpdate(meeting, groupId);

      expect(event.props, [meeting, groupId]);
      expect(event.toString(), 'meeting update { meeting: ${meeting.id} }');
    });

    test('MeetingDelete should correctly override props and toString()', () {
      const meetingId = 1;
      const groupId = 2;
      const event = MeetingDelete(meetingId, groupId);

      expect(event.props, [meetingId, groupId]);
      expect(event.toString(), 'meeting delete { meeting_id: $meetingId }');
    });
  });
}
