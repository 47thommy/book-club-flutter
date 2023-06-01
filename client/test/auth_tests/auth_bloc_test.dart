import 'package:client/application/auth/auth_bloc.dart';
import 'package:client/application/auth/auth_event.dart';
import 'package:client/application/auth/auth_state.dart';
import 'package:client/infrastructure/user/dto/user_dto.dart';

import 'package:client/infrastructure/user/user_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockUserRepository extends Mock implements UserRepository {
  @override
  Future<void> save(UserDto user, String token) {
    return Future.delayed(const Duration(milliseconds: 100), () {});
  }

  @override
  Future<void> delete() async {
    await Future.delayed(const Duration(milliseconds: 100));
  }
}

void main() {
  group('AuthenticationBloc', () {
    late AuthenticationBloc authenticationBloc;
    late MockUserRepository mockUserRepository;

    setUpAll(() {
      mockUserRepository = MockUserRepository();
      authenticationBloc =
          AuthenticationBloc(userRepository: mockUserRepository);
    });

    tearDownAll(() {
      authenticationBloc.close();
    });

    test('Initial state should be AuthenticationUninitialized', () {
      expect(authenticationBloc.state, AuthenticationUninitialized());
    });

    group('UserLoggedOut event', () {
      test('should emit the correct states', () {
        final expectedStates = [
          AuthenticationLoading(),
          Unauthenticated(),
        ];

        expectLater(
          authenticationBloc.stream,
          emitsInOrder(expectedStates),
        );

        authenticationBloc.add(UserLoggedOut());
      });
    });

    group('LoginPageRequested event', () {
      test('should emit LoginPageLoad state', () {
        final expectedState = LoginPageLoad();

        expectLater(authenticationBloc.stream, emits(expectedState));

        authenticationBloc.add(LoginPageRequested());
      });
    });

    group('SignupPageRequested event', () {
      test('should emit SignupPageLoad state', () {
        final expectedState = SignupPageLoad();

        expectLater(authenticationBloc.stream, emits(expectedState));

        authenticationBloc.add(SignupPageRequested());
      });
    });
  });
}
