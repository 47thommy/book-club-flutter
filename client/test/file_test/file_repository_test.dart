import 'dart:io';

import 'package:client/infrastructure/file/data_providers/file_api.dart';
import 'package:client/infrastructure/file/file_repository.dart';

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'file_repository_test.mocks.dart';

@GenerateMocks([FileApi])
void main() {
  group('FileRepository', () {
    late FileRepository fileRepository;
    late MockFileApi mockFileApi;

    setUp(() {
      mockFileApi = MockFileApi();
      fileRepository = FileRepository(api: mockFileApi);
    });

    test('uploadFile returns Either with value when file upload succeeds',
        () async {
      final file = File('/path/to/file.jpg');

      when(mockFileApi.upload(file))
          .thenAnswer((_) async => 'http://example.com/file.jpg');

      final result = await fileRepository.uploadFile(file);

      if (result.hasError) {
        fail(
            'Expected a value, but received an error: ${result.failure!.toString()}');
      } else {
        expect(result.value, 'http://example.com/file.jpg');
      }
    });

    tearDown(() {
      fileRepository = FileRepository(api: mockFileApi);
    });
  });
}
