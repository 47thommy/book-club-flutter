import 'package:client/application/meeting/meeting_bloc.dart';
import 'package:client/application/meeting/meeting_event.dart';
import 'package:client/application/meeting/meeting_state.dart';
import 'package:client/domain/meeting/meeting.dart';
import 'package:client/domain/meeting/meeting_repository_interface.dart';
import 'package:client/infrastructure/user/user_repository.dart';
import 'package:client/utils/either.dart';
import 'package:client/utils/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'meeting_bloc_test.mocks.dart';

@GenerateMocks([IMeetingRepository, UserRepository])
void main() {
  late MeetingBloc meetingBloc;
  late IMeetingRepository mockMeetingRepository;
  late UserRepository mockUserRepository;

  setUp(() {
    mockMeetingRepository = MockIMeetingRepository();
    mockUserRepository = MockUserRepository();
    meetingBloc = MeetingBloc(
      meetingRepository: mockMeetingRepository,
      userRepository: mockUserRepository,
    );
  });

  group('MeetingBloc', () {
    test(
        'MeetingCreate event - emits MeetingCreated when meeting creation succeeds',
        () async {
      final meeting = Meeting(
          description: "description",
          id: 1,
          location: 'location',
          time: DateTime.now());
      const groupId = 1;
      const token = 'token';

      when(mockUserRepository.getToken()).thenAnswer((_) async => token);

      when(mockMeetingRepository.createMeeting(meeting, groupId, token))
          .thenAnswer((_) async => Either(value: meeting));

      expect(
        meetingBloc.stream,
        emitsInOrder([MeetingCreated(meeting, groupId)]),
      );

      meetingBloc.add(MeetingCreate(meeting, groupId));
    });

    test(
        'MeetingCreate event - emits MeetingOperationFailure when meeting creation fails',
        () async {
      final meeting = Meeting(
          description: "description",
          id: 1,
          location: 'location',
          time: DateTime.now());
      const groupId = 1;
      const token = 'token';
      const failure = Failure('Failed to create meeting');

      when(mockUserRepository.getToken()).thenAnswer((_) async => token);

      when(mockMeetingRepository.createMeeting(meeting, groupId, token))
          .thenAnswer((_) async => Either(failure: failure));

      expect(
        meetingBloc.stream,
        emitsInOrder([const MeetingOperationFailure(failure)]),
      );

      meetingBloc.add(MeetingCreate(meeting, groupId));
    });

    test(
        'MeetingUpdate event - emits MeetingUpdated when meeting update succeeds',
        () async {
      final meeting = Meeting(
          description: "description",
          id: 1,
          location: 'location',
          time: DateTime.now());
      const groupId = 1;
      const token = 'token';

      when(mockUserRepository.getToken()).thenAnswer((_) async => token);

      when(mockMeetingRepository.updateMeeting(meeting, groupId, token))
          .thenAnswer((_) async => Either(value: meeting));

      expect(
        meetingBloc.stream,
        emitsInOrder([MeetingUpdated(meeting)]),
      );

      meetingBloc.add(MeetingUpdate(meeting, groupId));
    });

    test(
        'MeetingUpdate event - emits MeetingOperationFailure when meeting update fails',
        () async {
      final meeting = Meeting(
          description: "description",
          id: 1,
          location: 'location',
          time: DateTime.now());
      const groupId = 1;
      const token = 'token';
      const failure = Failure('Failed to update meeting');

      when(mockUserRepository.getToken()).thenAnswer((_) async => token);

      when(mockMeetingRepository.updateMeeting(meeting, groupId, token))
          .thenAnswer((_) async => Either(failure: failure));

      expect(
        meetingBloc.stream,
        emitsInOrder([const MeetingOperationFailure(failure)]),
      );

      meetingBloc.add(MeetingUpdate(meeting, groupId));
    });

    test(
        'MeetingDelete event - emits MeetingDeleted when meeting deletion succeeds',
        () async {
      const meetingId = 1;
      const groupId = 1;
      const token = 'token';

      when(mockUserRepository.getToken()).thenAnswer((_) async => token);

      when(mockMeetingRepository.deleteMeeting(meetingId, groupId, token))
          .thenAnswer((_) async => Either(value: true));

      expect(
        meetingBloc.stream,
        emitsInOrder([const MeetingDeleted(meetingId)]),
      );

      meetingBloc.add(const MeetingDelete(meetingId, groupId));
    });

    test(
        'MeetingDelete event - emits MeetingOperationFailure when meeting deletion fails',
        () async {
      const meetingId = 1;
      const groupId = 1;
      const token = 'token';
      const failure = Failure('Failed to delete meeting');

      when(mockUserRepository.getToken()).thenAnswer((_) async => token);

      when(mockMeetingRepository.deleteMeeting(meetingId, groupId, token))
          .thenAnswer((_) async => Either(failure: failure));

      expect(
        meetingBloc.stream,
        emitsInOrder([const MeetingOperationFailure(failure)]),
      );

      meetingBloc.add(const MeetingDelete(meetingId, groupId));
    });

    tearDown(() {
      meetingBloc.close();
    });
  });
}
