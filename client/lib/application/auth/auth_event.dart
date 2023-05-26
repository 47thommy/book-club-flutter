import 'package:client/domain/user/user_dto.dart';
import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object?> get props => [];
}

class AppStarted extends AuthenticationEvent {
  @override
  String toString() => 'Application started';
}

class UserLoggedIn extends AuthenticationEvent {
  final UserDto user;
  final String token;

  const UserLoggedIn({required this.user, required this.token});

  @override
  List<Object?> get props => [user, token];

  @override
  String toString() => 'Logged in { email: ${user.email} }';
}

class UserLoggedOut extends AuthenticationEvent {
  @override
  String toString() => 'Logged out';
}

class LoginPageRequested extends AuthenticationEvent {}

class SignupPageRequested extends AuthenticationEvent {}
