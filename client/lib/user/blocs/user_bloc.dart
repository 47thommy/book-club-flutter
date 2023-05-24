import 'package:client/user/repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc(this.userRepository) : super(UserLoading()) {
    on<UserLoad>((event, emit) async {
      try {
        final user = await userRepository.getCurrentUser();
        emit(UserAuthenticated(user));
      } catch (error) {
        emit(UserUnauthenticated());
      }
    });

    on<UserAuthenticate>((event, emit) async {
      try {
        final user = await userRepository.login(event.user);
        emit(UserAuthenticated(user));
      } catch (error) {
        emit(const UserOperationFailure({'message': 'Authentication failed.'}));
        emit(UserLoading());
      }
    });

    on<UserCreate>((event, emit) async {
      try {
        final user = await userRepository.register(event.user);
        emit(UserCreated(user));
      } catch (error) {
        emit(UserOperationFailure(error));
      }
    });
  }
}
