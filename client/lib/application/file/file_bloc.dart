import 'package:client/infrastructure/file/file_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'file_event.dart';
import 'file_state.dart';

class FileBloc extends Bloc<FileEvent, FileState> {
  final FileRepository fileRepository;

  FileBloc({required this.fileRepository}) : super(FileUninitialized()) {
    // Upload to remote and save to cache
    on<UploadFile>((event, emit) async {
      emit(FileUploading());

      final result = await fileRepository.uploadFile(event.file);

      if (result.hasError) {
        emit(FileOperationFailure(result.failure!));
      } else {
        emit(FileUploaded(result.value!));
      }
    });
  }
}
