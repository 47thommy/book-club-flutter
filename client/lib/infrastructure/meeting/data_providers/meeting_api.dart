import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:client/infrastructure/auth/exceptions.dart';
import 'package:client/infrastructure/common/exception.dart';
import 'package:client/infrastructure/meeting/dto/meeting_dto.dart';
import 'package:http/http.dart' as http;

import 'package:client/infrastructure/group/dto/group_dto.dart';
import 'package:client/common/constants.dart' as consts;

class MeetingApi {
  late http.Client _client;

  final baseUrl = '${consts.apiUrl}/meeting';

  MeetingApi({http.Client? client}) {
    _client = client ?? http.Client();
  }

  Future<MeetingDto> getMeeting(int id, String token) async {
    final meetingUri = Uri.parse('baseUri?id=$id');

    final http.Response response = await _client.get(
      meetingUri,
      headers: <String, String>{
        "Content-Type": "application/json",
        'token': token
      },
    );

    if (response.statusCode == HttpStatus.ok) {
      final json = jsonDecode(response.body);

      return MeetingDto.fromJson(json);
    } else if (response.statusCode == HttpStatus.notFound) {
      throw BCHttpException.notFound();
    } else if (response.statusCode == HttpStatus.unauthorized) {
      throw Exception("Unauthorized");
    }
    throw const BCHttpException();
  }

  Future<MeetingDto> createMeeting(
      {required MeetingDto meeting, required String token}) async {
    final meetingUri = Uri.parse(baseUrl);

    final http.Response response = await _client.post(meetingUri,
        headers: <String, String>{
          "Content-Type": "application/json",
          'token': token
        },
        body: jsonEncode(meeting.toJson()));

    if (response.statusCode == HttpStatus.created) {
      final json = jsonDecode(response.body);

      return MeetingDto.fromJson(json);
    } else if (response.statusCode == HttpStatus.unauthorized) {
      throw AuthenticationFailure.sessionExpired();
    }
    throw const BCHttpException();
  }

  Future<MeetingDto> updateMeeting(
      {required MeetingDto meeting, required String token}) async {
    final meetingUri = Uri.parse('$baseUrl/${meeting.id}');

    final http.Response response = await _client.put(meetingUri,
        headers: <String, String>{
          "Content-Type": "application/json",
          'token': token
        },
        body: jsonEncode(meeting.toJson()));

    if (response.statusCode == HttpStatus.ok) {
      final json = jsonDecode(response.body);

      return MeetingDto.fromJson(json);
    } else if (response.statusCode == HttpStatus.unauthorized) {
      throw AuthenticationFailure.sessionExpired();
    }
    throw const BCHttpException();
  }

  Future<MeetingDto> deleteMeeting(
      {required MeetingDto meeting, required String token}) async {
    final meetingUri = Uri.parse('$baseUrl/${meeting.id}');
    final http.Response response = await _client.delete(meetingUri,
        headers: <String, String>{
          "Content-Type": "application/json",
          'token': token
        },
        body: jsonEncode(meeting.toJson()));
    if (response.statusCode == HttpStatus.ok) {
      final json = jsonDecode(response.body);
      return MeetingDto.fromJson(json);
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
