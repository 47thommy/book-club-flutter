import 'package:equatable/equatable.dart';

class LoginFormDto extends Equatable {
  final String email;
  final String password;

  const LoginFormDto({
    required this.email,
    required this.password,
  });

  factory LoginFormDto.fromJson(Map<String, dynamic> json) {
    return LoginFormDto(email: json['email'], password: json['password']);
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'email': email, 'password': password};
  }

  @override
  List<Object?> get props => [email, password];
}
