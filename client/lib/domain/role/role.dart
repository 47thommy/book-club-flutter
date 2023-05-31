import 'package:client/domain/role/permission.dart';
import 'package:equatable/equatable.dart';

class Role extends Equatable {
  final int id;
  final String name;
  final List<Permission> permissions;

  static const empty = Role(id: -1, name: '', permissions: []);
  static const owner = 'Owner';
  static const member = 'Reader';
  static const defaults = [owner, member];

  const Role({required this.id, required this.name, required this.permissions});

  @override
  List<Object?> get props => [id, name, permissions];
}
