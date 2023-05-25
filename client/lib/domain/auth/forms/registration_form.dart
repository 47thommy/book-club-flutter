import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:client/domain/auth/email.dart';
import 'package:client/domain/auth/password.dart';

part 'registration_form.freezed.dart';

@freezed
class RegistrationForm with _$RegistrationForm {
  const factory RegistrationForm({
    required Email email,
    required Password password,
    required String firstName,
    required String lastName,
  }) = _RegisterForm;
}
