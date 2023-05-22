import 'dart:convert';

import 'package:client/user/data_providers/data_providers.dart';
import 'package:http/http.dart' as http;
import 'package:http_status_code/http_status_code.dart';

import '../models/user.dart';
import '../../utils/constants.dart' as consts;

class RemoteUserDataProvider {
  late http.Client _client;

  RemoteUserDataProvider({http.Client? client}) {
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

    if (response.statusCode == StatusCode.CREATED) {
      return User.fromJson(jsonDecode(response.body));
    }

    throw Exception("Failed to register user");
  }

  Future<User> login(User user) async {
    final loginUrl = Uri.parse('${consts.apiUrl}/auth/login');

    final http.Response response = await _client.post(loginUrl,
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode({"email": user.email, "password": user.password}));

    print("<<<<!!!!{$user, ${response.statusCode}}");
    if (response.statusCode == StatusCode.OK) {
      print("<<<<");
      final user = User.fromJson(jsonDecode(response.body));
      print(user);
      return await getUser(user);
    }

    throw Exception("Authentication failed");
  }

  Future<User> getUser(User user) async {
    if (user.token == null) {
      throw Exception("Authentication token required");
    }

    final url = Uri.parse('${consts.apiUrl}/user/');

    print(url);

    final response = await _client.get(url,
        headers: {"Content-Type": "application/json", "token": user.token!});

    if (response.statusCode == StatusCode.OK) {
      final _user = User.fromJson(jsonDecode(response.body));
      _user.token = user.token;
      return _user;
    }

    throw Exception("");
  }
}
