import 'package:client/domain/role/permission.dart';
import 'package:client/infrastructure/role/dto/permission_mapper.dart';
import 'package:equatable/equatable.dart';

class PermissionDto extends Equatable {
  static final all =
      Permission.all.map((permission) => permission.toPermissionDto()).toList();

  final int id;
  final String name;

  const PermissionDto({required this.id, required this.name});

  factory PermissionDto.fromJson(Map<String, dynamic> json) {
    return PermissionDto(id: json['id'] as int, name: json['name']);
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'id': id, 'password': name};
  }

  @override
  List<Object?> get props => [id, name];
}
