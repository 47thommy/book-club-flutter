import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:client/infrastructure/user/user_repository.dart';
import 'package:client/application/auth/auth_bloc.dart';
import 'package:client/application/auth/auth_event.dart';
import 'package:client/application/auth/auth_state.dart';
import 'package:client/infrastructure/user/dto/user_dto.dart';
import 'package:client/infrastructure/role/dto/role_dto.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  group('AuthenticationBloc', () {
    late AuthenticationBloc authenticationBloc;
    late MockUserRepository userRepository;

    setUp(() {
      userRepository = MockUserRepository();
      authenticationBloc = AuthenticationBloc(userRepository: userRepository);
    });

    tearDown(() {
      authenticationBloc.close();
    });

    test('emits Authenticated when user is logged in', () async {
      final expectedStates = [
        AuthenticationUninitialized(),
        const Authenticated(UserDto.empty),
      ];

      when(userRepository.hasToken()).thenAnswer((_) async => true);
      when(userRepository.getLoggedInUser())
          .thenAnswer((_) async => const UserDto(
                id: 1,
                email: "test@gmail.com",
                firstName: "John",
                lastName: "Doe",
                role: RoleDto.empty,
                username: 'john',
                bio: 'testbio',
              ));

      expectLater(
        authenticationBloc.stream,
        emitsInOrder(expectedStates),
      );

      authenticationBloc.add(AppStarted());
    });
  });
}
