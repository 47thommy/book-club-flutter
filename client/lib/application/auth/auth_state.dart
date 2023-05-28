import 'package:client/infrastructure/user/dto/dto.dart';
import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object?> get props => [];
}

class AuthenticationUninitialized extends AuthenticationState {}

class Authenticated extends AuthenticationState {
  final UserDto user;

  const Authenticated(this.user);

  @override
  List<Object?> get props => [user];
}

class Unauthenticated extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class LoginPageLoad extends AuthenticationState {}

class SignupPageLoad extends AuthenticationState {}
