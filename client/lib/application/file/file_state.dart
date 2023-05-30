import 'dart:io';

import 'package:equatable/equatable.dart';

import '../../utils/failure.dart';

abstract class FileState extends Equatable {
  const FileState();

  @override
  List<Object?> get props => [];
}

class FileUninitialized extends FileState {}

class FileLoading extends FileState {}

class FileLoaded extends FileState {
  final File file;

  const FileLoaded(this.file);

  @override
  List<Object?> get props => [file];
}

class FileUploading extends FileState {}

class FileUploaded extends FileState {
  final String url;
  final String reason;

  const FileUploaded({required this.url, required this.reason});

  @override
  List<Object?> get props => [url, reason];
}

class FileOperationFailure extends FileState {
  final Failure error;

  const FileOperationFailure(this.error);

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'FileOperationFailure { error: $error }';
}
