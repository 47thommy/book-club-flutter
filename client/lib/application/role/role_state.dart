import 'package:client/infrastructure/role/dto/role_dto.dart';
import 'package:client/utils/failure.dart';
import 'package:equatable/equatable.dart';

abstract class RoleState extends Equatable {
  const RoleState();

  @override
  List<Object?> get props => [];
}

class RoleInit extends RoleState {}

class RoleCreated extends RoleState {
  final RoleDto role;
  final int groupId;

  const RoleCreated(this.role, this.groupId);

  @override
  List<Object?> get props => [role];
}

class RoleUpdated extends RoleState {
  final RoleDto role;

  const RoleUpdated(this.role);

  @override
  List<Object?> get props => [role];
}

class RoleOperationFailure extends RoleState {
  final Failure error;

  const RoleOperationFailure(this.error);

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'RoleOperationFailure { error: $error }';
}
