import 'package:client/infrastructure/group/data_providers/group_api.dart';
import 'package:client/infrastructure/group/data_providers/group_local.dart';
import 'package:client/infrastructure/group/dto/group_dto.dart';
import 'package:client/infrastructure/group/group_repository.dart';
import 'package:client/infrastructure/user/dto/dto.dart';
import 'package:client/utils/either.dart';
import 'package:client/utils/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'dart:async';

import 'package:mockito/mockito.dart';

import 'group_repository_test.mocks.dart';

@GenerateMocks([GroupCacheClient, GroupApi])
void main() {
  late GroupRepository groupRepository;
  late MockGroupCacheClient mockCacheClient;
  late MockGroupApi mockGroupApi;

  setUp(() {
    mockCacheClient = MockGroupCacheClient();
    mockGroupApi = MockGroupApi();
    groupRepository =
        GroupRepository(cache: mockCacheClient, api: mockGroupApi);
  });

  group('getGroup', () {
    test('returns group when API call succeeds', () async {
      const groupId = 1;
      const token = 'token';
      const group = GroupDto(
          id: 1,
          name: "name",
          description: "description",
          imageUrl: "imageUrl",
          creator: UserDto(
              id: 1,
              email: "email",
              username: "username",
              bio: "bio",
              imageUrl: "imageUrl",
              firstName: "firstName",
              lastName: "lastName"),
          members: [],
          roles: [],
          polls: [],
          books: []);

      when(mockGroupApi.getGroup(groupId, token))
          .thenAnswer((_) async => group);

      final result = await groupRepository.getGroup(groupId, token);
      expect(result, equals(Either(value: group)));
    });

    test('returns group from cache when API call times out', () async {
      // Test data
      const groupId = 1;
      const token = 'token';
      const group = GroupDto(
          id: 1,
          name: "name",
          description: "description",
          imageUrl: "imageUrl",
          creator: UserDto(
              id: 1,
              email: "email",
              username: "username",
              bio: "bio",
              imageUrl: "imageUrl",
              firstName: "firstName",
              lastName: "lastName"),
          members: [],
          roles: [],
          polls: [],
          books: []);

      when(mockGroupApi.getGroup(groupId, token))
          .thenThrow(TimeoutException('Connection timed out'));

      when(mockCacheClient.get(groupId))
          .thenAnswer((_) async => Either(value: group));

      final result = await groupRepository.getGroup(groupId, token);
      expect(result, equals(Either(value: group)));
    });

    test('returns failure when API call throws BCHttpException', () async {
      // Test data
      const groupId = 1;
      const token = 'token';
      const errorMessage = Failure('Error message');

      when(mockGroupApi.getGroup(groupId, token))
          .thenThrow(Either(failure: errorMessage));

      final result = await groupRepository.getGroup(groupId, token);
      expect(result, equals(Either(failure: Failure(errorMessage))));
    });
  });
}
