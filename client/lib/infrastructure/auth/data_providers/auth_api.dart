import 'dart:developer';
import 'dart:io';
import 'dart:convert';
import 'package:client/common/constants.dart';
import 'package:client/domain/user/profile_form.dart';
import 'package:client/infrastructure/auth/dto/dto.dart';
import 'package:client/infrastructure/auth/exceptions.dart';
import 'package:client/infrastructure/common/exception.dart';
import 'package:client/infrastructure/user/dto/dto.dart';
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

  Future<UserDto> getUser(String token,
      {int? id, String? email, String? username}) async {
    var url = Uri.parse('${consts.apiUrl}/user/');

    url = url.replace(
        queryParameters: {"id": id, "email": email, "username": username});

    final response = await _client.get(url, headers: {
      "Content-Type": "application/json",
      "token": token
    }).timeout(connectionTimeoutLimit);

    if (response.statusCode == HttpStatus.ok) {
      final user = UserDto.fromJson(jsonDecode(response.body));

      return user;
    }

    throw AuthenticationFailure.sessionExpired();
  }

  Future<UserDto> updateUser(
      {required ProfileForm form, required String token}) async {
    final userUrl = Uri.parse('${consts.apiUrl}/user');

    final http.Response response = await _client.patch(userUrl,
        headers: <String, String>{
          "Content-Type": "application/json",
          'token': token
        },
        body: jsonEncode(form.toJson()));

    if (response.statusCode == HttpStatus.ok) {
      final json = jsonDecode(response.body);

      return UserDto.fromJson(json);
    } else if (response.statusCode == HttpStatus.unauthorized) {
      throw AuthenticationFailure.sessionExpired();
    }
    throw const BCHttpException();
  }
}
