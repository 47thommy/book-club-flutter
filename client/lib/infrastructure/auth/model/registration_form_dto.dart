import 'package:equatable/equatable.dart';

class RegistrationFormDto extends Equatable {
  final String email;
  final String password;
  final String username;

  const RegistrationFormDto({
    required this.email,
    required this.password,
    required this.username,
  });

  factory RegistrationFormDto.fromJson(Map<String, dynamic> json) {
    return RegistrationFormDto(
        email: json['email'],
        password: json['password'],
        username: json['username']);
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'email': email,
      'password': password,
      'username': username
    };
  }

  @override
  List<Object?> get props => [email, password, username];
}
