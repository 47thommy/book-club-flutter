import 'package:flutter_test/flutter_test.dart';
import 'package:client/application/login/login_event.dart';
import 'package:client/infrastructure/auth/dto/dto.dart';

void main() {
  group('LoginRequested', () {
    test('toString() returns correct string representation', () {
      const email = 'test@example.com';
      const password = 'password';
      const form = LoginFormDto(email: email, password: password);
      const event = LoginRequested(form);

      expect(event.toString(), 'Login requested { email: $form }');
    });

    test('props contains correct form', () {
      const email = 'test@example.com';
      const password = 'password';
      const form = LoginFormDto(email: email, password: password);
      const event = LoginRequested(form);

      expect(event.props, [form]);
    });
  });
}
