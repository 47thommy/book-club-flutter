import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:client/common/constants.dart';
import 'package:client/infrastructure/auth/exceptions.dart';
import 'package:client/infrastructure/common/exception.dart';
import 'package:client/infrastructure/readinglist/dto/readinglist_dto.dart';
import 'package:http/http.dart' as http;

import 'package:client/common/constants.dart' as consts;

class ReadingListApi {
  late http.Client _client;

  final baseUrl = '${consts.apiUrl}/readinglist';

  ReadingListApi({http.Client? client}) {
    _client = client ?? http.Client();
  }

  Future<ReadingListDto> getReadingList(int id, String token) async {
    final readingListUri = Uri.parse('$baseUrl?id=$id');

    final http.Response response = await _client.get(
      readingListUri,
      headers: <String, String>{
        "Content-Type": "application/json",
        "token": token
      },
    ).timeout(connectionTimeoutLimit);

    if (response.statusCode == HttpStatus.ok) {
      final json = jsonDecode(response.body);

      return ReadingListDto.fromJson(json);
    } else if (response.statusCode == HttpStatus.notFound) {
      throw BCHttpException.notFound();
    } else if (response.statusCode == HttpStatus.unauthorized) {
      throw Exception("Unauthorized");
    }
    throw const BCHttpException();
  }

  Future<ReadingListDto> createReadingList(
      {required ReadingListDto readingList, required String token}) async {
    final readingListUri = Uri.parse(baseUrl);

    final http.Response response = await _client
        .post(readingListUri,
            headers: <String, String>{
              "Content-Type": "application/json",
              'token': token
            },
            body: jsonEncode(readingList.toJson()))
        .timeout(connectionTimeoutLimit);
    if (response.statusCode == HttpStatus.created) {
      final json = jsonDecode(response.body);

      return ReadingListDto.fromJson(json);
    } else if (response.statusCode == HttpStatus.unauthorized) {
      throw AuthenticationFailure.sessionExpired();
    }
    throw const BCHttpException();
  }

  Future<ReadingListDto> updateReadingList(
      {required ReadingListDto readingList, required String token}) async {
    final readingListUri = Uri.parse('$baseUrl/${readingList.id}');

    final http.Response response = await _client
        .put(readingListUri,
            headers: <String, String>{
              "Content-Type": "application/json",
              'token': token
            },
            body: jsonEncode(readingList.toJson()))
        .timeout(connectionTimeoutLimit);

    if (response.statusCode == HttpStatus.ok) {
      final json = jsonDecode(response.body);

      return ReadingListDto.fromJson(json);
    } else if (response.statusCode == HttpStatus.unauthorized) {
      throw AuthenticationFailure.sessionExpired();
    }
    throw const BCHttpException();
  }

  Future<ReadingListDto> deleteReadingList(
      {required ReadingListDto readingList, required String token}) async {
    final readingListUri = Uri.parse('$baseUrl/${readingList.id}');
    final http.Response response = await _client.delete(readingListUri,
        headers: <String, String>{
          "Content-Type": "application/json",
          'token': token
        },
        body: jsonEncode(readingList.toJson()));
    if (response.statusCode == HttpStatus.ok) {
      final json = jsonDecode(response.body);
      return ReadingListDto.fromJson(json);
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
