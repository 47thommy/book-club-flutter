import 'package:client/infrastructure/role/role_repository.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

import 'package:client/domain/role/role.dart';
import 'package:client/domain/role/role_form.dart';

import 'package:client/infrastructure/common/exception.dart';
import 'package:client/infrastructure/role/data_providers/role_api.dart';

import 'package:client/utils/failure.dart';
import 'package:mockito/annotations.dart';

import 'role_repository_test.mocks.dart';

@GenerateMocks([RoleApi])
void main() {
  late RoleRepository repository;
  late MockRoleApi mockApi;

  setUp(() {
    mockApi = MockRoleApi();
    repository = RoleRepository(api: mockApi);
  });

  group('createRole', () {
    test('should return a role when successfully creating a role', () async {
      const roleForm = RoleForm(name: "name", permissionIds: []);
      const groupId = 1;
      const token = 'sampleToken';
      const newRole = Role(id: 1, name: "name", permissions: []);

      when(mockApi.createRole(groupId, roleForm, token))
          .thenAnswer((_) async => newRole);

      final result = await repository.createRole(roleForm, groupId, token);

      expect(result.value, newRole);
      verify(mockApi.createRole(groupId, roleForm, token)).called(1);
    });

    test('should return a failure when an BCHttpException occurs', () async {
      const roleForm = RoleForm(name: "name", permissionIds: []);
      const groupId = 1;
      const token = 'sampleToken';
      const errorMessage = 'HTTP Exception occurred';

      when(mockApi.createRole(groupId, roleForm, token))
          .thenThrow(const BCHttpException(errorMessage));

      final result = await repository.createRole(roleForm, groupId, token);

      expect(result.failure, const Failure(errorMessage));
      verify(mockApi.createRole(groupId, roleForm, token)).called(1);
    });
  });

  group('updateRole', () {
    test('should return an updated role when successfully updating a role',
        () async {
      const roleForm = RoleForm(name: "name", permissionIds: []);
      const groupId = 1;
      const token = 'sampleToken';
      const updatedRole = Role(id: 1, name: "name", permissions: []);

      when(mockApi.updateRole(groupId, roleForm, token))
          .thenAnswer((_) async => updatedRole);

      final result = await repository.updateRole(roleForm, groupId, token);

      expect(result.value, updatedRole);
      verify(mockApi.updateRole(groupId, roleForm, token)).called(1);
    });

    test('should return a failure when an BCHttpException occurs', () async {
      const roleForm = RoleForm(name: "name", permissionIds: []);
      const groupId = 1;
      const token = 'sampleToken';
      const errorMessage = 'HTTP Exception occurred';

      when(mockApi.updateRole(groupId, roleForm, token))
          .thenThrow(const BCHttpException(errorMessage));

      final result = await repository.updateRole(roleForm, groupId, token);

      expect(result.failure, const Failure(errorMessage));
      verify(mockApi.updateRole(groupId, roleForm, token)).called(1);
    });
  });

  group('deleteRole', () {
    test('should return true when successfully deleting a role', () async {
      const roleId = 1;
      const groupId = 1;
      const token = 'sampleToken';

      when(mockApi.deleteRole(groupId, roleId, token))
          .thenAnswer((_) async => null);

      final result = await repository.deleteRole(roleId, groupId, token);

      expect(result.value, true);
      verify(mockApi.deleteRole(groupId, roleId, token)).called(1);
    });

    test('should return a failure when an BCHttpException occurs', () async {
      const roleId = 1;
      const groupId = 1;
      const token = 'sampleToken';
      const errorMessage = 'HTTP Exception occurred';

      when(mockApi.deleteRole(groupId, roleId, token))
          .thenThrow(const BCHttpException(errorMessage));

      final result = await repository.deleteRole(roleId, groupId, token);

      expect(result.failure, const Failure(errorMessage));
      verify(mockApi.deleteRole(groupId, roleId, token)).called(1);
    });
  });
}
