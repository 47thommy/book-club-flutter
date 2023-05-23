import 'package:client/user/models/user.dart';
import 'package:equatable/equatable.dart';

abstract class UserState extends Equatable {
  const UserState();
}

class UserLoading extends UserState {
  @override
  List<Object?> get props => [];
}

class UserCreated extends UserState {
  final User user;

  const UserCreated(this.user);

  @override
  List<Object?> get props => [user];
}

class UserAuthenticated extends UserState {
  final User user;

  const UserAuthenticated(this.user);

  @override
  List<Object?> get props => [user];
}

class UserUnauthenticated extends UserState {
  @override
  List<Object?> get props => [];
}

class UserOperationFailure extends UserState {
  final Object error;

  const UserOperationFailure(this.error);

  @override
  List<Object?> get props => [error];
}
