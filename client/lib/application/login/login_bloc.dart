import 'package:client/infrastructure/user/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:client/application/auth/auth_bloc.dart';
import 'package:client/application/auth/auth_event.dart';
import 'package:client/application/login/login_event.dart';
import 'package:client/application/login/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({required this.userRepository, required this.authenticationBloc})
      : super(LoginInitial()) {
    // User requested login
    on<LoginRequested>((event, emit) async {
      emit(LoginLoading());

      final loginResult = await userRepository.login(event.form);

      if (loginResult.hasError) {
        emit(LoginFailure(loginResult.failure!));
      } else {
        final result = await userRepository.getUserByToken(loginResult.value!);

        if (result.hasError) {
          emit(LoginFailure(result.failure!));
        }

        authenticationBloc
            .add(UserLoggedIn(user: result.value!, token: loginResult.value!));
      }

      emit(LoginInitial());
    });
  }
}
