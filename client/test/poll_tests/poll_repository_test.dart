import 'package:client/domain/poll/poll.dart';
import 'package:client/domain/poll/poll_form.dart';

import 'package:client/infrastructure/auth/exceptions.dart';
import 'package:client/infrastructure/common/exception.dart';
import 'package:client/infrastructure/poll/data_providers/poll_api.dart';
import 'package:client/infrastructure/poll/poll_repository.dart';
import 'package:client/utils/either.dart';
import 'package:client/utils/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'poll_repository_test.mocks.dart';

@GenerateMocks([PollApi])
void main() {
  late PollRepository pollRepository;
  late MockPollApi mockPollApi;

  setUp(() {
    mockPollApi = MockPollApi();
    pollRepository = PollRepository(api: mockPollApi);
  });

  test('createPoll should return Poll on success', () async {
    const pollForm = PollForm(options: [], question: 'question');
    const groupId = 1;
    const token = 'sample-token';
    const createdPoll = Poll(id: 1, options: [], question: 'question');

    when(mockPollApi.createPoll(groupId, pollForm, token))
        .thenAnswer((_) async => createdPoll);

    final result = await pollRepository.createPoll(pollForm, groupId, token);

    expect(result, isA<Either<Poll>>());
    expect(result.value, createdPoll);
    verify(mockPollApi.createPoll(groupId, pollForm, token)).called(1);
  });

  test('createPoll should return Failure on API error', () async {
    const pollForm = PollForm(options: [], question: 'question');
    const groupId = 1;
    const token = 'sample-token';
    const errorMessage = 'API Error Message';

    when(mockPollApi.createPoll(groupId, pollForm, token))
        .thenThrow(const BCHttpException(errorMessage));

    final result = await pollRepository.createPoll(pollForm, groupId, token);

    expect(result.failure, const Failure(errorMessage));
    verify(mockPollApi.createPoll(groupId, pollForm, token)).called(1);
  });

  test('createPoll should return Failure on authentication failure', () async {
    // Arrange
    const pollForm = PollForm(options: [], question: 'question');
    const groupId = 1;
    const token = 'sample-token';
    const errorMessage = 'Authentication Failure Message';

    when(mockPollApi.createPoll(groupId, pollForm, token))
        .thenThrow(const AuthenticationFailure(errorMessage));

    // Act
    final result = await pollRepository.createPoll(pollForm, groupId, token);

    // Assert
    expect(result.failure, const Failure(errorMessage));
    verify(mockPollApi.createPoll(groupId, pollForm, token)).called(1);
  });
}
