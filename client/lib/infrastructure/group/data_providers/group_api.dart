import 'dart:io';
import 'dart:convert';
import 'package:client/infrastructure/auth/data_providers/auth_api.dart';

import 'package:client/infrastructure/common/exception.dart';
import 'package:http/http.dart' as http;

import 'package:client/domain/groups/group_dto.dart';
import 'package:client/common/constants.dart' as consts;

class GroupApi {
  late http.Client _client;

  final baseUrl = '${consts.apiUrl}/group';

  GroupApi({http.Client? client}) {
    _client = client ?? http.Client();
  }

  Future<GroupDto> getGroup(int id, String token) async {
    final groupUri = Uri.parse('$baseUrl?id=$id');

    final http.Response response = await _client.get(
      groupUri,
      headers: <String, String>{
        "Content-Type": "application/json",
        'token': token
      },
    );

    if (response.statusCode == HttpStatus.ok) {
      final json = jsonDecode(response.body);

      return GroupDto.fromJson(json);
    } else if (response.statusCode == HttpStatus.notFound) {
      throw BCHttpException.notFound();
    }
    throw const BCHttpException();
  }

  Future<List<GroupDto>> getGroups(String token) async {
    final groupUri = Uri.parse(baseUrl);

    final http.Response response = await _client.get(
      groupUri,
      headers: <String, String>{
        "Content-Type": "application/json",
        'token': token
      },
    );

    if (response.statusCode == HttpStatus.ok) {
      final data = jsonDecode(response.body);

      return data.map<GroupDto>((json) => GroupDto.fromJson(json)).toList();
    } else if (response.statusCode == HttpStatus.notFound) {
      throw BCHttpException.notFound();
    }
    throw const BCHttpException();
  }

  Future<List<GroupDto>> getJoinedGroups(String token) async {
    var url = Uri.parse('${consts.apiUrl}/user/');

    final response = await _client.get(url,
        headers: {"Content-Type": "application/json", "token": token});

    if (response.statusCode == HttpStatus.ok) {
      final memberships = jsonDecode(response.body)['memberships'];

      final groups = memberships.map((json) => json['group']).toList();

      groups.retainWhere((json) => json != null);

      return groups.map<GroupDto>((json) => GroupDto.fromJson(json)).toList();
    } else if (response.statusCode == HttpStatus.notFound) {
      throw BCHttpException.notFound();
    }
    throw const BCHttpException();
  }

  Future<GroupDto> createGroup(
      {required GroupDto group, required String token}) async {
    final groupUri = Uri.parse(baseUrl);

    final http.Response response = await _client.post(groupUri,
        headers: <String, String>{
          "Content-Type": "application/json",
          'token': token
        },
        body: jsonEncode(group.toJson()));

    if (response.statusCode == HttpStatus.created) {
      final json = jsonDecode(response.body);

      return GroupDto.fromJson(json);
    }
    throw const BCHttpException();
  }

  Future<void> deleteGroup(
      {required GroupDto group, required String token}) async {
    final groupUri = Uri.parse(baseUrl);

    final http.Response response = await _client.post(groupUri,
        headers: <String, String>{
          "Content-Type": "application/json",
          'token': token
        },
        body: jsonEncode(group.toJson()));

    if (response.statusCode == HttpStatus.notFound) {
      throw BCHttpException.notFound();
    } else if (response.statusCode == HttpStatus.forbidden) {
      throw BCHttpException.unauthorized();
    }
    throw const BCHttpException();
  }
}
