import 'dart:io';
import 'dart:convert';

import 'package:client/common/constants.dart';
import 'package:client/domain/vote/vote.dart';
import 'package:client/infrastructure/auth/exceptions.dart';
import 'package:client/infrastructure/common/exception.dart';
import 'package:client/infrastructure/vote/dto/vote_dto.dart';
import 'package:client/infrastructure/vote/dto/vote_mapper.dart';

import 'package:http/http.dart' as http;

import 'package:client/common/constants.dart' as consts;
import 'dart:developer';

class VoteApi {
  late http.Client _client;

  final baseUrl = '${consts.apiUrl}/vote';

  VoteApi({http.Client? client}) {
    _client = client ?? http.Client();
  }

  Future<Vote> getVote(int groupId, int voteId, String token) async {
    final url = Uri.parse('$baseUrl/$voteId');

    final http.Response response = await _client.get(
      url,
      headers: <String, String>{
        "Content-Type": "application/json",
        'token': token
      },
    ).timeout(connectionTimeoutLimit);

    if (response.statusCode == HttpStatus.ok) {
      final json = jsonDecode(response.body);

      return VoteDto.fromJson(json).toVote();
    } else if (response.statusCode == HttpStatus.notFound) {
      throw BCHttpException.notFound();
    } else if (response.statusCode == HttpStatus.unauthorized) {
      throw AuthenticationFailure.sessionExpired();
    }
    throw const BCHttpException();
  }

  Future<Vote> createVote(int pollId, VoteDto vote, String token) async {
    final url = Uri.parse(baseUrl);

    final http.Response response = await _client
        .post(url,
            headers: <String, String>{
              "Content-Type": "application/json",
              'token': token
            },
            body: jsonEncode({'choice': vote.choice, 'pollId': pollId}))
        .timeout(connectionTimeoutLimit);

    if (response.statusCode == HttpStatus.created) {
      final json = jsonDecode(response.body);

      return VoteDto.fromJson(json).toVote();
    } else if (response.statusCode == HttpStatus.unauthorized) {
      throw AuthenticationFailure.sessionExpired();
    }
    throw const BCHttpException();
  }

  Future<void> deleteVote(int voteId, String token) async {
    final url = Uri.parse('$baseUrl/$voteId');

    final http.Response response = await _client.delete(
      url,
      headers: <String, String>{
        "Content-Type": "application/json",
        'token': token
      },
    ).timeout(connectionTimeoutLimit);

    if (response.statusCode == HttpStatus.ok) return;

    throw BCHttpException(jsonDecode(response.body)['error']);
  }
}
