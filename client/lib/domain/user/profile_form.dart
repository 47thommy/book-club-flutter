import 'package:equatable/equatable.dart';

class ProfileForm extends Equatable {
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String username;
  final String bio;
  final String imageUrl;

  ProfileForm({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.bio,
    required this.imageUrl,
  });

  Map<String, String> toJson() {
    return {
      'email': email,
      'password': password,
      'first_name': firstName,
      'last_name': lastName,
      'username': username,
      'bio': bio,
      'imageUrl': imageUrl
    };
  }

  @override
  List<Object?> get props =>
      [email, password, firstName, lastName, username, imageUrl];
}
