import 'dart:io';
import 'dart:convert';

import 'package:client/common/constants.dart';
import 'package:client/domain/poll/poll.dart';
import 'package:client/domain/poll/poll_form.dart';
import 'package:client/infrastructure/auth/exceptions.dart';
import 'package:client/infrastructure/common/exception.dart';
import 'package:client/infrastructure/poll/poll.dart';

import 'package:http/http.dart' as http;

import 'package:client/common/constants.dart' as consts;
import 'dart:developer';

class PollApi {
  late http.Client _client;

  final baseUrl = '${consts.apiUrl}/poll';

  PollApi({http.Client? client}) {
    _client = client ?? http.Client();
  }

  Future<Poll> getPoll(int groupId, int pollId, String token) async {
    final url = Uri.parse('$baseUrl/$pollId');

    final http.Response response = await _client.get(
      url,
      headers: <String, String>{
        "Content-Type": "application/json",
        'token': token
      },
    ).timeout(connectionTimeoutLimit);

    if (response.statusCode == HttpStatus.ok) {
      final json = jsonDecode(response.body);

      return PollDto.fromJson(json).toPoll();
    } else if (response.statusCode == HttpStatus.notFound) {
      throw BCHttpException.notFound();
    } else if (response.statusCode == HttpStatus.unauthorized) {
      throw AuthenticationFailure.sessionExpired();
    }
    throw const BCHttpException();
  }

  Future<Poll> createPoll(int groupId, PollForm poll, String token) async {
    final url = Uri.parse(baseUrl);

    final http.Response response = await _client
        .post(url,
            headers: <String, String>{
              "Content-Type": "application/json",
              'token': token
            },
            body: jsonEncode({
              'question': poll.question,
              'options': poll.options,
              'groupId': groupId
            }))
        .timeout(connectionTimeoutLimit);

    if (response.statusCode == HttpStatus.created) {
      final json = jsonDecode(response.body);

      return PollDto.fromJson(json).toPoll();
    } else if (response.statusCode == HttpStatus.unauthorized) {
      throw AuthenticationFailure.sessionExpired();
    }
    throw const BCHttpException();
  }

  Future<void> deletePoll(int pollId, String token) async {
    final url = Uri.parse('$baseUrl/$pollId');

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
