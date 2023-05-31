import 'package:equatable/equatable.dart';

class RoleForm extends Equatable {
  final int? id;
  final String name;
  final List<int> permissionIds;

  const RoleForm({this.id, required this.name, required this.permissionIds});

  @override
  List<Object?> get props => [id, name, permissionIds];
}
