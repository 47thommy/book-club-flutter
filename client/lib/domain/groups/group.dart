import 'package:client/domain/auth/user_role.dart';
import 'package:client/infrastructure/user/models/user_dto.dart';

class Group {
  final int id;
  final String name;
  final String description;
  final String imageUrl;
  final UserDto creator;
  final List<UserDto> members;
  final List<Role> roles;

  Group(
      {required this.id,
      required this.name,
      required this.description,
      required this.imageUrl,
      required this.creator,
      required this.members,
      required this.roles});
}
