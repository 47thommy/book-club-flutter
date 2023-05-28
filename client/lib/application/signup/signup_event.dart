import 'package:client/infrastructure/auth/dto/dto.dart';
import 'package:equatable/equatable.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object?> get props => [];
}

class SignupRequested extends SignupEvent {
  final RegisterFormDto form;

  const SignupRequested(this.form);

  @override
  List<Object?> get props => [form];

  @override
  String toString() => 'Login requested { form: $form }';
}
