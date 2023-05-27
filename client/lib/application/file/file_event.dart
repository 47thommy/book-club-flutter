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

  const UploadFile(this.file);

  @override
  List<Object?> get props => [file];

  @override
  String toString() => 'Upload file { email: ${file.path} }';
}
