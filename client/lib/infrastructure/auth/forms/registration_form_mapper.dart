import 'package:client/domain/auth/forms/registration_form.dart';
import 'package:client/infrastructure/auth/forms/registration_form_dto.dart';

extension RegistrationFormMapper on RegistrationForm {
  RegisterFormDto toDto() => RegisterFormDto(
        email: email.value,
        password: password.value,
        firstName: firstName,
        lastName: lastName,
      );
}
