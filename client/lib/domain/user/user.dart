import 'package:client/domain/role/role.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String username;
  final String bio;
  final Role role;

  const User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.bio,
    required this.role,
  });

  static const empty = User(
      id: -1,
      email: "",
      firstName: "",
      lastName: "",
      username: "",
      bio: "",
      role: Role.empty);

  bool get isEmpty => this == User.empty;

  @override
  List<Object?> get props => [id, email, firstName, lastName, role];
}
