import 'package:client/infrastructure/group/dto/group_dto.dart';
import 'package:client/infrastructure/user/dto/dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:client/application/group/group_event.dart';

void main() {
  group('GroupEvent', () {
    test('LoadGroups event should have correct string representation', () {
      expect(LoadGroups().toString(), 'Load groups');
    });

    test('LoadGroupDetail event should have correct string representation', () {
      expect(const LoadGroupDetail(1).toString(), 'Group load { group: 1 }');
    });

    test('GroupCreate event should have correct string representation', () {
      const group = GroupDto(
        id: 6,
        name: 'Group 6',
        description: 'Description 6',
        imageUrl: 'image6.png',
        creator: UserDto(
          id: 1,
          email: "test@gmail.com",
          firstName: "john",
          lastName: "doe",
        ),
        members: [],
        roles: [],
      );

      expect(
        const GroupCreate(group).toString(),
        'Group create { group: $group }',
      );
    });

    test('GroupDelete event should have correct string representation', () {
      expect(const GroupDelete(1).toString(), 'Group delete { group_id: 1 }');
    });
  });
}
