import 'package:equatable/equatable.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object?> get props => [];
}

class SignupRequested extends SignupEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  const SignupRequested(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.password});

  @override
  List<Object?> get props => [firstName, lastName, email, password];

  @override
  String toString() => 'Login requested { email: $email }';
}
