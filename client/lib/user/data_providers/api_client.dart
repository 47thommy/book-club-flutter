import 'dart:io';
import 'dart:convert';
import 'package:client/application/auth/blocs/exceptions.dart';
import 'package:client/infrastructure/user/models/user_dto.dart';
import 'package:client/common/constants.dart' as consts;
import 'package:http/http.dart' as http;

class AuthApiClient {
  late http.Client _client;

  AuthApiClient({http.Client? client}) {
    _client = client ?? http.Client();
  }

  Future<UserDto> register(
      String firstName, String lastName, String email, String password) async {
    final registerUrl = Uri.parse('${consts.apiUrl}/auth/register');

    final http.Response response = await _client.post(registerUrl,
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode({
          "first_name": firstName,
          "last_name": lastName,
          "email": email,
          "password": password
        }));

    if (response.statusCode == HttpStatus.created) {
      return UserDto.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == HttpStatus.conflict) {
      throw AuthenticationFailure.fromCode(AuthenticationFailure.emailConflict);
    }
    throw const AuthenticationFailure();
  }

  Future<String> login(String email, String password) async {
    final loginUrl = Uri.parse('${consts.apiUrl}/auth/login');

    final http.Response response = await _client.post(loginUrl,
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}));

    if (response.statusCode == HttpStatus.ok) {
      final token = jsonDecode(response.body)['token'];

      return token;
    }

    throw AuthenticationFailure.fromCode(
        AuthenticationFailure.invalidCredentials);
  }

  Future<UserDto> getUser(String token, {int? id, String? email}) async {
    var url = Uri.parse('${consts.apiUrl}/user/');

    url = url.replace(queryParameters: {"id": id, "email": email});

    final response = await _client.get(url,
        headers: {"Content-Type": "application/json", "token": token});

    if (response.statusCode == HttpStatus.ok) {
      final user = UserDto.fromJson(jsonDecode(response.body));

      return user;
    }

    throw AuthenticationFailure.fromCode(
        AuthenticationFailure.invalidCredentials);
  }
}
