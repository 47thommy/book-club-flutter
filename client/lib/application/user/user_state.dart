import 'package:client/domain/user/user.dart';
import 'package:client/utils/failure.dart';
import 'package:equatable/equatable.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

class ProfileInit extends UserState {
  @override
  List<Object?> get props => [];
}

class ProfileUpdated extends UserState {
  final User user;

  const ProfileUpdated(this.user);

  @override
  List<Object?> get props => [user];
}

class UserDeleted extends UserState {
  final int userId;

  const UserDeleted(this.userId);

  @override
  List<Object?> get props => [userId];
}

class UserOperationFailure extends UserState {
  final Failure error;

  const UserOperationFailure(this.error);

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'UserOperationFailure { error: $error }';
}
