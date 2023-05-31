import 'package:client/application/role/role_state.dart';
import 'package:client/domain/role/permission.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:client/domain/role/role.dart';
import 'package:client/utils/failure.dart';

void main() {
  group('RoleState', () {
    test('RoleInit state should have the correct props', () {
      final state = RoleInit();

      expect(state.props, equals([]));
    });

    test('RoleCreated state should have the correct props', () {
      const role = Role(id: 1, name: 'test', permissions: []);
      const groupId = 1;

      final state = RoleCreated(role, groupId);

      expect(state.role, equals(role));
      expect(state.groupId, equals(groupId));
      expect(state.props, equals([role]));
    });

    test('RoleUpdated state should have the correct props', () {
      const role = Role(id: 1, name: '', permissions: []);

      const state = RoleUpdated(role);

      expect(state.role, equals(role));
      expect(state.props, equals([role]));
    });

    test('RoleDeleted state should have the correct props', () {
      const roleId = 1;

      final state = RoleDeleted(roleId);

      expect(state.roleId, equals(roleId));
      expect(state.props, equals([roleId]));
    });

    test('RoleOperationFailure state should have the correct props', () {
      final failure = Failure('Something went wrong');

      final state = RoleOperationFailure(failure);

      expect(state.error, equals(failure));
      expect(state.props, equals([failure]));
      expect(
          state.toString(), equals('RoleOperationFailure { error: $failure }'));
    });
  });
}
