import 'dart:io';
import 'dart:convert';

import 'package:client/domain/role/role.dart';
import 'package:client/domain/role/role_form.dart';
import 'package:client/infrastructure/auth/exceptions.dart';
import 'package:client/infrastructure/common/exception.dart';
import 'package:client/infrastructure/role/role.dart';
import 'package:http/http.dart' as http;

import 'package:client/common/constants.dart' as consts;
import 'dart:developer';

class RoleApi {
  late http.Client _client;

  final baseUrl = '${consts.apiUrl}/group';

  RoleApi({http.Client? client}) {
    _client = client ?? http.Client();
  }

  Future<Role> getRole(int groupId, int roleId, String token) async {
    final url = Uri.parse('$baseUrl/$groupId/role/$roleId');

    final http.Response response = await _client.get(
      url,
      headers: <String, String>{
        "Content-Type": "application/json",
        'token': token
      },
    );

    if (response.statusCode == HttpStatus.ok) {
      final json = jsonDecode(response.body);

      return RoleDto.fromJson(json).toRole();
    } else if (response.statusCode == HttpStatus.notFound) {
      throw BCHttpException.notFound();
    } else if (response.statusCode == HttpStatus.unauthorized) {
      throw AuthenticationFailure.sessionExpired();
    }
    throw const BCHttpException();
  }

  Future<Role> createRole(int groupId, RoleForm role, String token) async {
    final url = Uri.parse('$baseUrl/$groupId/role');

    final http.Response response = await _client.post(url,
        headers: <String, String>{
          "Content-Type": "application/json",
          'token': token
        },
        body:
            jsonEncode({'name': role.name, 'permissions': role.permissionIds}));

    if (response.statusCode == HttpStatus.created) {
      final json = jsonDecode(response.body);

      return RoleDto.fromJson(json).toRole();
    } else if (response.statusCode == HttpStatus.unauthorized) {
      throw AuthenticationFailure.sessionExpired();
    }
    throw const BCHttpException();
  }

  Future<Role> updateRole(int groupId, RoleForm role, String token) async {
    final url = Uri.parse('$baseUrl/$groupId/role/${role.id}');

    final http.Response response = await _client.patch(url,
        headers: <String, String>{
          "Content-Type": "application/json",
          'token': token
        },
        body:
            jsonEncode({'name': role.name, 'permissions': role.permissionIds}));

    if (response.statusCode == HttpStatus.ok) {
      final json = jsonDecode(response.body);

      return RoleDto.fromJson(json).toRole();
    } else if (response.statusCode == HttpStatus.unauthorized) {
      throw AuthenticationFailure.sessionExpired();
    }
    throw const BCHttpException();
  }

  Future<void> deleteRole(int groupId, int roleId, String token) async {
    final url = Uri.parse('$baseUrl/$groupId/role/$roleId');

    final http.Response response = await _client.delete(
      url,
      headers: <String, String>{
        "Content-Type": "application/json",
        'token': token
      },
    );

    if (response.statusCode == HttpStatus.ok) return;

    throw BCHttpException(jsonDecode(response.body)['error']);
  }
}
