import 'package:client/application/role/role_bloc.dart';
import 'package:client/application/role/role_event.dart';
import 'package:client/application/role/role_state.dart';

import 'package:client/domain/role/role.dart';
import 'package:client/domain/role/role_form.dart';
import 'package:client/domain/role/role_repository_interface.dart';
import 'package:client/infrastructure/user/user_repository.dart';
import 'package:client/utils/either.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'role_bloc_test.mocks.dart';

// Generate mocks for dependencies

@GenerateMocks([IRoleRepository, UserRepository])
void main() {
  group('RoleBloc', () {
    late RoleBloc roleBloc;
    late IRoleRepository mockRoleRepository;
    late UserRepository mockUserRepository;

    setUp(() {
      mockRoleRepository = MockIRoleRepository();
      mockUserRepository = MockUserRepository();
      roleBloc = RoleBloc(
        roleRepository: mockRoleRepository,
        userRepository: mockUserRepository,
      );
    });

    test('Emits RoleCreated when role creation succeeds', () async {
      final role = Role(id: 1, name: 'test', permissions: []);
      final groupId = 1;

      when(mockUserRepository.getToken()).thenAnswer((_) async => 'token');

      when(mockRoleRepository.createRole(
              RoleForm(name: "name", permissionIds: []), groupId, 'token'))
          .thenAnswer(
        (_) async => Either(value: role),
      );

      final event =
          RoleCreate(RoleForm(name: "name", permissionIds: []), groupId);

      expectLater(
        roleBloc.stream,
        emitsInOrder([
          RoleCreated(Role(id: 1, name: 'test', permissions: []), 1),
        ]),
      );

      roleBloc.add(event);
    });

    test('Emits RoleUpdated when role update succeeds', () async {
      final role = Role(id: 1, name: 'test', permissions: []);
      final groupId = 1;

      when(mockUserRepository.getToken()).thenAnswer((_) async => 'token');

      when(mockRoleRepository.updateRole(
              RoleForm(name: "name", permissionIds: []), groupId, 'token'))
          .thenAnswer((_) async => Either(value: role));

      final event =
          RoleUpdate(RoleForm(name: "name", permissionIds: []), groupId);

      expectLater(
        roleBloc.stream,
        emitsInOrder([
          RoleUpdated(Role(id: 1, name: 'test', permissions: [])),
        ]),
      );

      roleBloc.add(event);
    });

    test('Emits RoleDeleted when role deletion succeeds', () async {
      final roleId = 1;
      final groupId = 1;

      when(mockUserRepository.getToken()).thenAnswer((_) async => 'token');

      when(mockRoleRepository.deleteRole(roleId, groupId, 'token'))
          .thenAnswer((_) async => Either(value: true));

      // Create a RoleDelete event
      final event = RoleDelete(roleId, groupId);

      expectLater(
        roleBloc.stream,
        emitsInOrder([
          RoleDeleted(roleId),
        ]),
      );

      roleBloc.add(event);
    });

    tearDown(() {
      roleBloc.close();
    });
  });
}
