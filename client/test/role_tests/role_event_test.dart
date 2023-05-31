import 'package:client/application/role/role_event.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:client/domain/role/role_form.dart';

void main() {
  group('RoleEvent', () {
    test('RoleCreate event should have the correct props', () {
      const role = RoleForm(name: 'creator', permissionIds: []);
      const groupId = 1;

      const event = RoleCreate(role, groupId);

      expect(event.role, equals(role));
      expect(event.groupId, equals(groupId));
      expect(event.props, equals([role]));
      expect(event.toString(), equals('role create { role: $role }'));
    });

    test('RoleUpdate event should have the correct props', () {
      const role = RoleForm(name: 'creator', permissionIds: []);
      const groupId = 1;

      const event = RoleUpdate(role, groupId);

      expect(event.role, equals(role));
      expect(event.groupId, equals(groupId));
      expect(event.props, equals([role, groupId]));
      expect(event.toString(), equals('role update { role: ${role.id} }'));
    });

    test('RoleDelete event should have the correct props', () {
      const roleId = 1;
      const groupId = 1;

      const event = RoleDelete(roleId, groupId);

      expect(event.roleId, equals(roleId));
      expect(event.groupId, equals(groupId));
      expect(event.props, equals([roleId, groupId]));
      expect(event.toString(), equals('role delete { role_id: $roleId }'));
    });
  });
}
