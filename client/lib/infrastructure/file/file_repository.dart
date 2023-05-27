import 'dart:io';

import 'package:client/infrastructure/common/exception.dart';
import 'package:client/infrastructure/file/data_providers/file_api.dart';
import 'package:client/infrastructure/file/data_providers/file_local.dart';
import 'package:client/utils/either.dart';
import 'package:client/utils/failure.dart';

class FileRepository {
  final FileApi _fileApi;

  FileRepository({FileCache? cache, FileApi? api})
      : _fileApi = api ?? FileApi();

  Future<Either<String>> uploadFile(File file) async {
    try {
      final url = await _fileApi.upload(file);
      return Either(value: url);
    } on BCHttpException catch (error) {
      return Either(failure: Failure(error.message));
    } catch (error) {
      return Either(failure: Failure(error.toString()));
    }
  }

  String getFullUrl(String url) {
    return _fileApi.absoluteUrl(url);
  }
}
