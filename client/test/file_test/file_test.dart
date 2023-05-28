import 'dart:io';
import 'package:client/application/file/file_event.dart';
import 'package:client/application/file/file_state.dart';
import 'package:client/utils/failure.dart';
import 'package:test/test.dart';

void main() {
  group('UploadFile', () {
    test('toString() returns the correct value', () {
      final file = File('/path/to/file.txt');
      final event = UploadFile(file);
      expect(event.toString(), 'Upload file { email: /path/to/file.txt }');
    });

    test('props returns a list with the file', () {
      final file = File('/path/to/file.txt');
      final event = UploadFile(file);
      expect(event.props, [file]);
    });
  });

  group('FileLoaded', () {
    test('props returns a list with the file', () {
      final file = File('/path/to/file.txt');
      final state = FileLoaded(file);
      expect(state.props, [file]);
    });
  });

  group('FileUploaded', () {
    test('props returns a list with the URL', () {
      final url = 'https://example.com/file.txt';
      final state = FileUploaded(url);
      expect(state.props, [url]);
    });
  });

  group('FileOperationFailure', () {
    test('props returns a list with the error', () {
      final failure = Failure('File operation failed');
      final state = FileOperationFailure(failure);
      expect(state.props, [failure]);
    });

    test('toString() returns the correct value', () {
      final failure = Failure('File operation failed');
      final state = FileOperationFailure(failure);
      expect(state.toString(), 'FileOperationFailure { error: $failure }');
    });
  });
}
