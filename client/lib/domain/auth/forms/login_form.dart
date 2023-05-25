import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:client/domain/auth/email.dart';
import 'package:client/domain/auth/password.dart';

part 'login_form.freezed.dart';

@freezed
class LoginForm with _$LoginForm {
  const factory LoginForm({
    required Email email,
    required Password password,
    required String firstName,
    required String lastName,
  }) = _LoginForm;
}
