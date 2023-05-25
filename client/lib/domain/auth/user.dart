import 'package:client/domain/groups/group.dart';

class User {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final List<Group> joinedGroups;
  final List<Group> createdGroups;

  User(
      {required this.id,
      required this.email,
      required this.firstName,
      required this.lastName,
      required this.joinedGroups,
      required this.createdGroups});
}
