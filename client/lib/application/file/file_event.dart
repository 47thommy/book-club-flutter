import 'dart:io';
import 'package:equatable/equatable.dart';

abstract class FileEvent extends Equatable {
  const FileEvent();

  @override
  List<Object?> get props => [];
}

class LoadFile extends FileEvent {
  final String url;

  const LoadFile(this.url);

  @override
  String toString() => 'Load file { url: $url }';
}

class UploadFile extends FileEvent {
  final File file;
  final String reason;

  const UploadFile({required this.file, required this.reason});

  @override
  List<Object?> get props => [file, reason];

  @override
  String toString() => 'Upload file { path: ${file.path} }';
}
