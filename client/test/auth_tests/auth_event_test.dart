import 'package:client/application/auth/auth_event.dart';
import 'package:client/infrastructure/user/dto/dto.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AuthenticationEvent', () {
    test('AppStarted event should have correct string representation', () {
      final event = AppStarted();
      expect(event.toString(), equals('Application started'));
    });

    test('UserLoggedIn event should have correct string representation', () {
      const user = UserDto(
          id: 1,
          email: 'test@example.com',
          firstName: 'John',
          lastName: 'Doe',
          bio: 'testbio',
          username: 'john');
      const token = 'abc123';
      const event = UserLoggedIn(user: user, token: token);

      final expectedString = 'Logged in { email: ${user.email} }';
      expect(event.toString(), equals(expectedString));
    });

    test('UserLoggedOut event should have correct string representation', () {
      final event = UserLoggedOut();
      expect(event.toString(), equals('Logged out'));
    });

    test('LoginPageRequested event should have correct string representation',
        () {
      final event = LoginPageRequested();
      expect(event.toString(), equals('LoginPageRequested()'));
    });

    test('SignupPageRequested event should have correct string representation',
        () {
      final event = SignupPageRequested();
      expect(event.toString(), equals('SignupPageRequested()'));
    });
  });
}
