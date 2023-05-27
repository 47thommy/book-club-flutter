import 'package:flutter_test/flutter_test.dart';
import 'package:client/application/group/group_event.dart';
import 'package:client/domain/groups/group_dto.dart';

void main() {
  group('GroupEvent', () {
    test('LoadGroups event should have correct string representation', () {
      expect(LoadGroups().toString(), 'Load groups');
    });

    test('LoadGroupDetail event should have correct string representation', () {
      expect(LoadGroupDetail(1).toString(), 'Group load { group: 1 }');
    });

    test('GroupCreate event should have correct string representation', () {
      final group = GroupDto(
        id: 2,
        name: 'Group 2',
        description: 'Description 2',
        imageUrl: 'image2.png',
      );
      expect(
        GroupCreate(group).toString(),
        'Group create { group: $group }',
      );
    });

    test('GroupDelete event should have correct string representation', () {
      expect(GroupDelete(1).toString(), 'Group delete { group_id: 1 }');
    });
  });
}
