import 'dart:io';
import 'dart:convert';

import 'package:client/common/constants.dart';
import 'package:client/infrastructure/auth/exceptions.dart';
import 'package:client/infrastructure/common/exception.dart';
import 'package:http/http.dart' as http;

import 'package:client/infrastructure/group/dto/group_dto.dart';
import 'package:client/common/constants.dart' as consts;
import 'dart:developer';

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
    ).timeout(connectionTimeoutLimit);

    if (response.statusCode == HttpStatus.ok) {
      final json = jsonDecode(response.body);

      return GroupDto.fromJson(json);
    } else if (response.statusCode == HttpStatus.notFound) {
      throw BCHttpException.notFound();
    } else if (response.statusCode == HttpStatus.unauthorized) {
      throw AuthenticationFailure.sessionExpired();
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
    ).timeout(connectionTimeoutLimit);

    if (response.statusCode == HttpStatus.ok) {
      final data = jsonDecode(response.body);

      log(data[0]['meetings'].toString());

      return data.map<GroupDto>((json) => GroupDto.fromJson(json)).toList();
    } else if (response.statusCode == HttpStatus.notFound) {
      throw BCHttpException.notFound();
    } else if (response.statusCode == HttpStatus.unauthorized) {
      throw AuthenticationFailure.sessionExpired();
    }
    throw const BCHttpException();
  }

  Future<List<GroupDto>> getJoinedGroups(String token) async {
    var url = Uri.parse('${consts.apiUrl}/user/');

    final response = await _client.get(url, headers: {
      "Content-Type": "application/json",
      "token": token
    }).timeout(connectionTimeoutLimit);

    log(response.statusCode.toString());
    log(response.body);

    if (response.statusCode == HttpStatus.ok) {
      final memberships = jsonDecode(response.body)['memberships'];

      final groups = memberships.map((json) => json['group']).toList();

      groups.retainWhere((json) => json != null);

      return groups.map<GroupDto>((json) => GroupDto.fromJson(json)).toList();
    } else if (response.statusCode == HttpStatus.notFound) {
      throw BCHttpException.notFound();
    } else if (response.statusCode == HttpStatus.unauthorized) {
      throw AuthenticationFailure.sessionExpired();
    }
    throw const BCHttpException();
  }

  Future<GroupDto> createGroup(
      {required GroupDto group, required String token}) async {
    final groupUri = Uri.parse(baseUrl);

    final http.Response response = await _client
        .post(groupUri,
            headers: <String, String>{
              "Content-Type": "application/json",
              'token': token
            },
            body: jsonEncode(group.toJson()))
        .timeout(connectionTimeoutLimit);

    if (response.statusCode == HttpStatus.created) {
      final json = jsonDecode(response.body);

      return GroupDto.fromJson(json);
    } else if (response.statusCode == HttpStatus.unauthorized) {
      throw AuthenticationFailure.sessionExpired();
    }
    throw const BCHttpException();
  }

  Future<GroupDto> updateGroup(
      {required GroupDto group, required String token}) async {
    final groupUri = Uri.parse('$baseUrl/${group.id}');

    final http.Response response = await _client.patch(groupUri,
        headers: <String, String>{
          "Content-Type": "application/json",
          'token': token
        },
        body: jsonEncode(group.toJson()));

    if (response.statusCode == HttpStatus.ok) {
      final json = jsonDecode(response.body);

      return GroupDto.fromJson(json);
    } else if (response.statusCode == HttpStatus.unauthorized) {
      throw AuthenticationFailure.sessionExpired();
    }
    throw const BCHttpException();
  }

  Future<void> deleteGroup(
      {required GroupDto group, required String token}) async {
    final groupUri = Uri.parse(baseUrl);

    final http.Response response = await _client
        .post(groupUri,
            headers: <String, String>{
              "Content-Type": "application/json",
              'token': token
            },
            body: jsonEncode(group.toJson()))
        .timeout(connectionTimeoutLimit);

    if (response.statusCode == HttpStatus.notFound) {
      throw BCHttpException.notFound();
    } else if (response.statusCode == HttpStatus.forbidden) {
      throw BCHttpException.unauthorized();
    } else if (response.statusCode == HttpStatus.unauthorized) {
      throw AuthenticationFailure.sessionExpired();
    }
    throw const BCHttpException();
  }

  Future<void> join({required GroupDto group, required String token}) async {
    final groupUri = Uri.parse('$baseUrl/${group.id}/join');

    final http.Response response = await _client.post(
      groupUri,
      headers: <String, String>{
        "Content-Type": "application/json",
        'token': token
      },
    );

    if (response.statusCode == HttpStatus.ok) {
      return;
    } else if (response.statusCode == HttpStatus.notFound) {
      throw BCHttpException.notFound();
    } else if (response.statusCode == HttpStatus.forbidden) {
      throw BCHttpException.unauthorized();
    } else if (response.statusCode == HttpStatus.unauthorized) {
      throw AuthenticationFailure.sessionExpired();
    }
    throw const BCHttpException();
  }

  Future<void> leave({required GroupDto group, required String token}) async {
    final groupUri = Uri.parse('$baseUrl/${group.id}/leave');

    final http.Response response = await _client.post(
      groupUri,
      headers: <String, String>{
        "Content-Type": "application/json",
        'token': token
      },
    ).timeout(connectionTimeoutLimit);

    if (response.statusCode == HttpStatus.ok) {
      return;
    } else if (response.statusCode == HttpStatus.notFound) {
      throw BCHttpException.notFound();
    } else if (response.statusCode == HttpStatus.forbidden) {
      throw BCHttpException.unauthorized();
    } else if (response.statusCode == HttpStatus.unauthorized) {
      throw AuthenticationFailure.sessionExpired();
    }
    throw const BCHttpException();
  }

  Future<void> addMember(GroupDto group, int userId, String token) async {
    final groupUri = Uri.parse('$baseUrl/${group.id}');

    final http.Response response = await _client
        .post(groupUri,
            headers: <String, String>{
              "Content-Type": "application/json",
              'token': token
            },
            body: jsonEncode({'memberId': userId}))
        .timeout(connectionTimeoutLimit);

    if (response.statusCode == HttpStatus.ok) {
      return;
    } else if (response.statusCode == HttpStatus.notFound) {
      throw BCHttpException.notFound();
    } else if (response.statusCode == HttpStatus.forbidden) {
      throw BCHttpException.unauthorized();
    } else if (response.statusCode == HttpStatus.unauthorized) {
      throw AuthenticationFailure.sessionExpired();
    }
    throw const BCHttpException();
  }

  Future<void> removeMember(GroupDto group, int userId, String token) async {
    final groupUri = Uri.parse('$baseUrl/${group.id}/members/$userId');

    final http.Response response = await _client.delete(
      groupUri,
      headers: <String, String>{
        "Content-Type": "application/json",
        'token': token
      },
    ).timeout(connectionTimeoutLimit);

    if (response.statusCode == HttpStatus.ok) {
      return;
    } else if (response.statusCode == HttpStatus.notFound) {
      throw BCHttpException.notFound();
    } else if (response.statusCode == HttpStatus.forbidden) {
      throw BCHttpException.unauthorized();
    } else if (response.statusCode == HttpStatus.unauthorized) {
      throw AuthenticationFailure.sessionExpired();
    }
    throw const BCHttpException();
  }
}
