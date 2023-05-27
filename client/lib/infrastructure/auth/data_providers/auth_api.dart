import 'dart:io';
import 'dart:convert';
import 'package:client/domain/auth/dto/login_form_dto.dart';
import 'package:client/infrastructure/auth/exceptions.dart';
import 'package:client/domain/auth/dto/registration_form_dto.dart';
import 'package:client/domain/user/user_dto.dart';
import 'package:client/common/constants.dart' as consts;
import 'package:http/http.dart' as http;

class AuthApi {
  late http.Client _client;

  AuthApi({http.Client? client}) {
    _client = client ?? http.Client();
  }

  Future<UserDto> register(RegisterFormDto registrationForm) async {
    final registerUrl = Uri.parse('${consts.apiUrl}/auth/register');

    final http.Response response = await _client
        .post(registerUrl,
            headers: <String, String>{"Content-Type": "application/json"},
            body: jsonEncode(registrationForm.toJson()))
        .timeout(const Duration(seconds: 3));

    if (response.statusCode == HttpStatus.created) {
      final data = jsonDecode(response.body);
      return UserDto.fromJson(data);
    } else if (response.statusCode == HttpStatus.conflict) {
      throw AuthenticationFailure.emailConflict();
    }
    throw const AuthenticationFailure();
  }

  Future<String> login(LoginFormDto loginForm) async {
    final loginUrl = Uri.parse('${consts.apiUrl}/auth/login');

    final http.Response response = await _client
        .post(loginUrl,
            headers: <String, String>{"Content-Type": "application/json"},
            body: jsonEncode(
                {"email": loginForm.email, "password": loginForm.password}))
        .timeout(const Duration(seconds: 3));

    if (response.statusCode == HttpStatus.ok) {
      final token = jsonDecode(response.body)['token'];

      return token;
    }

    throw AuthenticationFailure.invalidCredentials();
  }

  Future<UserDto> getUser(String token, {int? id, String? email}) async {
    var url = Uri.parse('${consts.apiUrl}/user/');

    url = url.replace(queryParameters: {"id": id, "email": email});

    final response = await _client.get(url, headers: {
      "Content-Type": "application/json",
      "token": token
    }).timeout(const Duration(seconds: 3));

    if (response.statusCode == HttpStatus.ok) {
      final user = UserDto.fromJson(jsonDecode(response.body));

      return user;
    }

    throw AuthenticationFailure.sessionExpired();
  }
}
