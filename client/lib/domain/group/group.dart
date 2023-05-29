import 'package:client/domain/role/role.dart';
import 'package:client/domain/user/user.dart';
import 'package:equatable/equatable.dart';

class Group extends Equatable {
  final int id;
  final String name;
  final String description;
  final String imageUrl;
  final User creator;
  final List<User> members;
  final List<Role> roles;

  const Group(
      {required this.id,
      required this.name,
      required this.description,
      required this.imageUrl,
      required this.creator,
      required this.members,
      required this.roles});

  @override
  List<Object?> get props => [id, name, description, imageUrl, creator, members, roles];
}
