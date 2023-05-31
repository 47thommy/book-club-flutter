import 'package:client/application/auth/auth_state.dart';
import 'package:client/infrastructure/user/dto/user_dto.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AuthenticationState', () {
    test('AuthenticationUninitialized should have empty props', () {
      final state = AuthenticationUninitialized();
      expect(state.props, isEmpty);
    });

    test('Authenticated should have correct props', () {
      const user = UserDto(
          id: 1,
          email: 'test@example.com',
          firstName: 'John',
          lastName: 'Doe',
          bio: 'testbio',
          username: 'john');
      const state = Authenticated(user);

      expect(state.props, equals([user]));
    });

    test('Unauthenticated should have empty props', () {
      final state = Unauthenticated();
      expect(state.props, isEmpty);
    });

    test('AuthenticationLoading should have empty props', () {
      final state = AuthenticationLoading();
      expect(state.props, isEmpty);
    });

    test('LoginPageLoad should have empty props', () {
      final state = LoginPageLoad();
      expect(state.props, isEmpty);
    });

    test('SignupPageLoad should have empty props', () {
      final state = SignupPageLoad();
      expect(state.props, isEmpty);
    });
  });
}
