import 'package:client/user/repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:client/application/auth/auth_bloc.dart';
import 'package:client/application/auth/auth_event.dart';
import 'package:client/application/login/login_event.dart';
import 'package:client/application/login/login_state.dart';

import 'exceptions.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({required this.userRepository, required this.authenticationBloc})
      : super(LoginInitial()) {
    // User requested login
    on<LoginRequested>((event, emit) async {
      emit(LoginLoading());

      try {
        final token = await userRepository.login(event.email, event.password);
        final user = await userRepository.getUserByToken(token);
        authenticationBloc.add(UserLoggedIn(user: user, token: token));
        emit(LoginInitial());
      } on AuthenticationFailure catch (error) {
        emit(LoginFailure(error.message));
      } catch (error) {
        emit(LoginFailure(error.toString()));
      }
    });
  }
}
