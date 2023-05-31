import 'package:client/infrastructure/user/dto/dto.dart';
import 'package:test/test.dart';
import 'package:client/infrastructure/group/dto/group_dto.dart';
import 'package:client/utils/failure.dart';
import 'package:client/application/group/group_state.dart';

void main() {
  group('GroupState', () {
    test('GroupsLoading state should not have any props', () {
      expect(GroupsLoading().props, isEmpty);
    });

    test('GroupDetailLoaded state should have correct props', () {
      const group = GroupDto(
        id: 1,
        name: 'Group 1',
        description: 'Description 1',
        imageUrl: 'image1.png',
        creator: UserDto(
          id: 1,
          email: "test@gmail.com",
          firstName: "john",
          lastName: "doe",
          bio: 'test bio',
          username: 'john',
        ),
        members: [],
        roles: [],
      );
      expect(const GroupDetailLoaded(group).props, [group]);
    });

    test('GroupCreated state should have correct props', () {
      const group = GroupDto(
        id: 2,
        name: 'Group 2',
        description: 'Description 2',
        imageUrl: 'image2.png',
        creator: UserDto(
          id: 1,
          email: "test@gmail.com",
          firstName: "john",
          lastName: "doe",
          bio: 'test bio',
          username: 'john',
        ),
        members: [],
        roles: [],
      );
      expect(const GroupCreated(group).props, [group]);
    });

    test('GroupUpdated state should have correct props', () {
      const group = GroupDto(
        id: 3,
        name: 'Group 3',
        description: 'Description 3',
        imageUrl: 'image3.png',
        creator: UserDto(
          id: 1,
          email: "test@gmail.com",
          firstName: "john",
          lastName: "doe",
          bio: 'test bio',
          username: 'john',
        ),
        members: [],
        roles: [],
      );
      expect(const GroupUpdated(group).props, [group]);
    });

    test('GroupJoined state should have correct props', () {
      const group = GroupDto(
        id: 4,
        name: 'Group 4',
        description: 'Description 4',
        imageUrl: 'image4.png',
        creator: UserDto(
          id: 1,
          email: "test@gmail.com",
          firstName: "john",
          lastName: "doe",
          bio: 'test bio',
          username: 'john',
        ),
        members: [],
        roles: [],
      );
      expect(const GroupJoined(group).props, [group]);
    });

    test('GroupLeaved state should have correct props', () {
      const group = GroupDto(
        id: 5,
        name: 'Group 5',
        description: 'Description 5',
        imageUrl: 'image5.png',
        creator: UserDto(
          id: 1,
          email: "test@gmail.com",
          firstName: "john",
          lastName: "doe",
          bio: 'test bio',
          username: 'john',
        ),
        members: [],
        roles: [],
      );
      expect(const GroupLeaved(group).props, [group]);
    });

    test('GroupsFetchSuccess state should have correct props', () {
      final groups = [
        const GroupDto(
          id: 6,
          name: 'Group 6',
          description: 'Description 6',
          imageUrl: 'image6.png',
          creator: UserDto(
            id: 1,
            email: "test@gmail.com",
            firstName: "john",
            lastName: "doe",
            bio: 'test bio',
            username: 'john',
          ),
          members: [],
          roles: [],
        ),
        const GroupDto(
          id: 7,
          name: 'Group 7',
          description: 'Description 7',
          imageUrl: 'image7.png',
          creator: UserDto(
            id: 1,
            email: "test@gmail.com",
            firstName: "john",
            lastName: "doe",
            bio: 'test bio',
            username: 'john',
          ),
          members: [],
          roles: [],
        ),
      ];
      expect(
        GroupsFetchSuccess(
          trendingGroups: groups,
          joinedGroups: groups,
        ).props,
        [
          [...groups],
          [...groups]
        ],
      );
    });

    test('GroupOperationFailure state should have correct props', () {
      const error = Failure('Failed to perform operation');
      expect(const GroupOperationFailure(error).props, [error]);
    });

    test(
      'GroupOperationFailure state should have correct string representation',
      () {
        const error = Failure('Failed to perform operation');
        expect(
          const GroupOperationFailure(error).toString(),
          'GroupOperationFailure { error: $error }',
        );
      },
    );
  });
}
