import 'dart:convert';
import 'dart:io';

import 'package:client/group/models/group.dart';
import 'package:http/http.dart' as http;
import 'package:client/utils/constants.dart' as consts;

class RemoteGroupProvider {
  late http.Client _client;

  final _baseUrl = Uri.parse('${consts.apiUrl}/group');

  RemoteGroupProvider({http.Client? client}) {
    _client = client ?? http.Client();
  }

  Future<Group> create(Group group, String authToken) async {
    print(authToken);
    final http.Response response = await _client.post(_baseUrl,
        headers: <String, String>{
          "Content-Type": "application/json",
          "token": authToken
        },
        body:
            jsonEncode({"name": group.name, "description": group.description}));

    if (response.statusCode == HttpStatus.created) {
      return Group.fromJson(jsonDecode(response.body));
    }

    if (response.statusCode == HttpStatus.badRequest) {
      throw Exception(response.body);
    }
    throw Exception(response.body);
  }

  Future<List<Group>> fetchAll(String authToken) async {
    final response = await _client.get(
      _baseUrl,
      headers: <String, String>{
        "Content-Type": "application/json",
        "token": authToken
      },
    );

    if (response.statusCode == HttpStatus.ok) {
      final groups = <Group>[];

      for (var groupJson in jsonDecode(response.body)) {
        groups.add(Group.fromJson(groupJson));
      }

      return groups;
    }

    throw Exception("Could not fetch groups");
  }

  Future<List<Group>> fetchJoinedGroups(String authToken) async {
    final response = await _client.get(
      _baseUrl,
      headers: <String, String>{
        "Content-Type": "application/json",
        "token": authToken
      },
    );

    if (response.statusCode == HttpStatus.ok) {
      final groups = <Group>[];

      for (var groupJson in jsonDecode(response.body)) {
        groups.add(Group.fromJson(groupJson));
      }

      return groups;
    }

    throw Exception("Could not fetch groups");
  }

  Future<Group> getGroup(
      {String? name, int? id, required String authToken}) async {
    if (name == null && id == null) {
      throw Exception("Group name or id is required");
    }

    Uri url;
    if (id != null) {
      url = _baseUrl.replace(queryParameters: {
        "id": id,
      });
    } else {
      url = _baseUrl.replace(queryParameters: {
        "name": name,
      });
    }

    final response = await _client.get(url,
        headers: {"Content-Type": "application/json", "token": authToken});

    if (response.statusCode == HttpStatus.ok) {
      final group = Group.fromJson(jsonDecode(response.body));

      return group;
    }

    throw Exception("Could not get group");
  }
}
