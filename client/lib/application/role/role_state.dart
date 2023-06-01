import 'package:client/domain/role/role.dart';
import 'package:client/utils/failure.dart';
import 'package:equatable/equatable.dart';

abstract class RoleState extends Equatable {
  const RoleState();

  @override
  List<Object?> get props => [];
}

class RoleInit extends RoleState {}

class RoleCreated extends RoleState {
  final Role role;
  final int groupId;

  const RoleCreated(this.role, this.groupId);

  @override
  List<Object?> get props => [role];
}

class RoleUpdated extends RoleState {
  final Role role;

  const RoleUpdated(this.role);

  @override
  List<Object?> get props => [role];
}

class RoleDeleted extends RoleState {
  final int roleId;

  const RoleDeleted(this.roleId);

  @override
  List<Object?> get props => [roleId];
}

class RoleOperationFailure extends RoleState {
  final Failure error;

  const RoleOperationFailure(this.error);

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'RoleOperationFailure { error: $error }';
}
