import 'package:client/domain/poll/poll.dart';
import 'package:client/domain/poll/poll_form.dart';
import 'package:client/domain/poll/poll_repository_interface.dart';
import 'package:client/infrastructure/group/group_repository.dart';

import 'package:client/infrastructure/user/user_repository.dart';
import 'package:client/utils/either.dart';
import 'package:client/utils/failure.dart';

import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:client/application/poll/poll_bloc.dart';
import 'package:client/application/poll/poll_event.dart';
import 'package:client/application/poll/poll_state.dart';

import 'package:mockito/annotations.dart';
import 'poll_bloc_test.mocks.dart';

@GenerateMocks([IPollRepository, GroupRepository, UserRepository])
void main() {
  late PollBloc pollBloc;
  late IPollRepository pollRepository;
  late GroupRepository groupRepository;
  late UserRepository userRepository;

  setUp(() {
    pollRepository = MockIPollRepository();
    groupRepository = MockGroupRepository();
    userRepository = MockUserRepository();
    const pollForm = PollForm(question: "test", options: []);
    when(pollRepository.createPoll(pollForm, 2, 'test')).thenAnswer((_) async =>
        Either<Poll>(
            value:
                const Poll(id: 1, question: "question", options: ["options"])));

    when(userRepository.getToken()).thenAnswer((_) => Future.value('test'));

    when(pollRepository.deletePoll(1, 1, 'test'))
        .thenAnswer((_) async => Either(value: true));

    when(pollRepository.deletePoll(1, 2, 'test'))
        .thenAnswer((_) async => Either(value: true));

    pollBloc = PollBloc(
      pollRepository: pollRepository,
      userRepository: userRepository,
      groupRepository: groupRepository,
    );
  });

  test('Emits PollCreated when creating a poll succeeds', () {
    final mockResult = Either<Poll>(
        value: const Poll(id: 1, question: "question", options: ["options"]));

    when(pollRepository.createPoll(
            const PollForm(question: "question", options: []), 1, "test"))
        .thenAnswer(
      (_) async => mockResult,
    );

    const event = PollCreate(PollForm(options: [], question: "test"), 2);

    expectLater(
      pollBloc.stream,
      emitsInOrder([
        const PollCreated(
            Poll(id: 1, question: "question", options: ["options"]), 2),
      ]),
    );

    pollBloc.add(event);
  });
  test('Emits PollOperationFailure when creating a poll fails', () {
    final mockResult =
        Either<Poll>(failure: const Failure('Poll creation failed'));

    when(pollRepository.createPoll(
            const PollForm(question: "question", options: []), 2, "test"))
        .thenAnswer(
      (_) async => mockResult,
    );

    const event = PollCreate(PollForm(question: "question", options: []), 2);

    expectLater(
      pollBloc.stream,
      emitsInOrder([
        const PollOperationFailure(Failure('Poll creation failed')),
      ]),
    );

    pollBloc.add(event);
  });

  test('Emits PollDeleted when deleting a poll succeeds', () {
    final mockResult = Either(value: true);

    when(pollRepository.deletePoll(1, 2, "test")).thenAnswer(
      (_) async => mockResult,
    );

    const event = PollDelete(1, 1);

    expectLater(
      pollBloc.stream,
      emitsInOrder([
        const PollDeleted(1),
      ]),
    );

    pollBloc.add(event);
  });
}
