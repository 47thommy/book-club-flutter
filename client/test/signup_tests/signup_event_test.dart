import 'package:flutter_test/flutter_test.dart';
import 'package:client/infrastructure/auth/dto/dto.dart';
import 'package:client/application/signup/signup_event.dart';

void main() {
  group('SignupEvent', () {
    test('props of SignupRequested should contain form', () {
      const form = RegisterFormDto(
        email: 'test@example.com',
        password: 'password123',
        firstName: 'john',
        lastName: 'doe',
      );
      const event = SignupRequested(form);
      expect(event.props, [form]);
    });

    test('SignupRequested toString() should contain form', () {
      const form = RegisterFormDto(
        email: 'test@example.com',
        password: 'password123',
        firstName: 'john',
        lastName: 'doe',
      );
      const event = SignupRequested(form);
      expect(
        event.toString(),
        'Login requested { form: $form }',
      );
    });
  });
}
