import 'package:client/user/models/user.dart';
import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class UserLoad extends UserEvent {
  const UserLoad();

  @override
  List<Object?> get props => [];
}

class UserCreate extends UserEvent {
  final User user;

  const UserCreate(this.user);

  @override
  List<Object?> get props => [user];

  @override
  String toString() => 'User created {id: ${user.id}, email: ${user.email}}';
}

class UserAuthenticate extends UserEvent {
  final User user;

  const UserAuthenticate(this.user);

  @override
  List<Object?> get props => [user];

  @override
  String toString() => 'User authentication event {email: ${user.email}}';
}

class UserUnauthenticate extends UserEvent {
  const UserUnauthenticate();

  @override
  List<Object?> get props => [];

  @override
  String toString() => 'User logged out';
}
