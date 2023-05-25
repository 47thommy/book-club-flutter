import 'package:client/domain/auth/forms/login_form.dart';
import 'package:client/infrastructure/auth/forms/login_form_dto.dart';

extension LoginFormMapper on LoginForm {
  LoginFormDto toDto() => LoginFormDto(
        email: email.value,
        password: password.value,
      );
}
