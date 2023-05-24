import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../models/user.dart';
import '../../utils/constants.dart' as consts;

class RemoteUserProvider {
  late http.Client _client;

  RemoteUserProvider({http.Client? client}) {
    _client = client ?? http.Client();
  }

  Future<User> register(User user) async {
    final registerUrl = Uri.parse('${consts.apiUrl}/auth/register');

    final http.Response response = await _client.post(registerUrl,
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode({
          "first_name": user.firstName,
          "last_name": user.lastName,
          "email": user.email,
          "password": user.password
        }));

    if (response.statusCode == HttpStatus.created) {
      return User.fromJson(jsonDecode(response.body));
    }

    if (response.statusCode == HttpStatus.badRequest) {
      throw Exception(response.body);
    }
    throw Exception(response.body);
  }

  Future<User> login(User user) async {
    final loginUrl = Uri.parse('${consts.apiUrl}/auth/login');

    final http.Response response = await _client.post(loginUrl,
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode({"email": user.email, "password": user.password}));

    if (response.statusCode == HttpStatus.ok) {
      final user = User.fromJson(jsonDecode(response.body));

      return await getUser(user);
    }

    throw Exception("Authentication failed");
  }

  Future<User> getUser(User user) async {
    if (user.token == null) {
      throw Exception("Authentication token required");
    }

    final url = Uri.parse('${consts.apiUrl}/user/');

    final response = await _client.get(url,
        headers: {"Content-Type": "application/json", "token": user.token!});

    if (response.statusCode == HttpStatus.ok) {
      final _user = User.fromJson(jsonDecode(response.body));
      _user.token = user.token;
      return _user;
    }

    throw Exception("Could not get user");
  }
}
