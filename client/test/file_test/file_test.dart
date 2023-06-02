import 'dart:io';
import 'package:client/application/file/file_event.dart';
import 'package:client/application/file/file_state.dart';
import 'package:client/utils/failure.dart';
import 'package:test/test.dart';

void main() {
  group('UploadFile', () {
    test('toString() returns the correct value', () {
      final file = File('/path/to/file.txt');
      const reason = "test reason";
      final event = UploadFile(file: file, reason: reason);
      expect(event.toString(), 'Upload file { path: /path/to/file.txt }');
    });

    test('props returns a list with the file', () {
      final file = File('/path/to/file.txt');
      const reason = "test reason";
      final event = UploadFile(file: file, reason: reason);
      expect(event.props, [file, reason]);
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
      const url = 'https://example.com/file.txt';
      const reason = "test reason";
      const state = FileUploaded(url: url, reason: reason);
      expect(state.props, [url, reason]);
    });
  });

  group('FileOperationFailure', () {
    test('props returns a list with the error', () {
      const failure = Failure('File operation failed');
      const state = FileOperationFailure(failure);
      expect(state.props, [failure]);
    });

    test('toString() returns the correct value', () {
      const failure = Failure('File operation failed');
      const state = FileOperationFailure(failure);
      expect(state.toString(), 'FileOperationFailure { error: $failure }');
    });
  });
}
