import 'package:client/infrastructure/role/dto/role_dto.dart';
import 'package:equatable/equatable.dart';

abstract class RoleEvent extends Equatable {
  const RoleEvent();

  @override
  List<Object?> get props => [];
}

class RoleCreate extends RoleEvent {
  final RoleDto role;
  final int groupId;

  const RoleCreate(this.role, this.groupId);

  @override
  List<Object?> get props => [role];

  @override
  String toString() => 'role create { role: $role }';
}

class RoleUpdate extends RoleEvent {
  final RoleDto role;
  final int groupId;

  const RoleUpdate(this.role, this.groupId);

  @override
  List<Object?> get props => [role];

  @override
  String toString() => 'role update { role: $role }';
}

class RoleDelete extends RoleEvent {
  final int id;

  const RoleDelete(this.id);

  @override
  List<Object?> get props => [id];

  @override
  String toString() => 'role delete { role_id: $id }';
}
