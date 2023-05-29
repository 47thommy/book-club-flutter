import 'package:client/infrastructure/auth/dto/dto.dart';
import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class LoginRequested extends LoginEvent {
  final LoginFormDto form;

  const LoginRequested(this.form);

  @override
  List<Object?> get props => [form];

  @override
  String toString() => 'Login requested { email: $form }';
}
