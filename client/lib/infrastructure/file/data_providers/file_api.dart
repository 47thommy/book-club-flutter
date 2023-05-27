import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'package:client/common/constants.dart' as consts;
import 'package:http/http.dart' as http;
import 'package:client/infrastructure/common/exception.dart';

enum PlaceHolder { user, group }

class FileApi {
  final uploadUrl = Uri.parse('${consts.apiUrl}/uploads');

  late http.Client _client;

  FileApi({http.Client? client}) {
    _client = client ?? http.Client();
  }

  Future<String> upload(File file) async {
    final request = http.MultipartRequest('POST', uploadUrl);

    final uploadfile =
        await http.MultipartFile.fromPath('image', file.absolute.path);

    request.files.add(uploadfile);

    final streamedResponse = await request.send();

    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == HttpStatus.ok) {
      return jsonDecode(response.body);
    }

    throw const BCHttpException();
  }

  String absoluteUrl(
    String relativeUrl,
  ) {
    return '${consts.apiUrl}/$relativeUrl';
  }
}
