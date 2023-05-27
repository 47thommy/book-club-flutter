import 'package:flutter_test/flutter_test.dart';
import 'package:client/application/group/group_state.dart';
import 'package:client/domain/groups/group_dto.dart';
import 'package:client/application/group/group_event.dart';
import 'package:client/utils/failure.dart';

void main() {
  group('GroupState', () {
    test('GroupsLoading state should not have any props', () {
      expect(GroupsLoading().props, isEmpty);
    });

    test('GroupDetailLoaded state should have correct props', () {
      final group = GroupDto(
          id: 1,
          name: 'Group 1',
          description: 'Description 1',
          imageUrl: 'image1.png');
      expect(GroupDetailLoaded(group).props, [group]);
    });

    test('GroupCreated state should have correct props', () {
      final group = GroupDto(
          id: 2,
          name: 'Group 2',
          description: 'Description 2',
          imageUrl: 'image2.png');
      expect(GroupCreated(group).props, [group]);
    });

    test('GroupsFetchSuccess state should have correct props', () {
      final groups = [
        GroupDto(
            id: 3,
            name: 'Group 3',
            description: 'Description 3',
            imageUrl: 'image3.png'),
        GroupDto(
            id: 4,
            name: 'Group 4',
            description: 'Description 4',
            imageUrl: 'image4.png'),
      ];
      expect(GroupsFetchSuccess(groups).props, [groups]);
    });

    test('GroupOperationFailure state should have correct props', () {
      final error = Failure('Failed to perform operation');
      expect(GroupOperationFailure(error).props, [error]);
    });

    test(
        'GroupOperationFailure state should have correct string representation',
        () {
      final error = Failure('Failed to perform operation');
      expect(GroupOperationFailure(error).toString(),
          'GroupOperationFailure { error: $error }');
    });
  });

  group('GroupEvent', () {
    test('GroupDelete event should have correct string representation', () {
      expect(GroupDelete(1).toString(), 'Group delete { group_id: 1 }');
    });
  });
}
