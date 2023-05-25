import 'package:client/application/login/login_bloc.dart';
import 'package:client/application/login/login_event.dart';
import 'package:client/user/repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:client/application/signup/signup_event.dart';
import 'package:client/application/signup/signup_state.dart';

import 'exceptions.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final UserRepository userRepository;
  final LoginBloc loginBloc;

  SignupBloc({required this.userRepository, required this.loginBloc})
      : super(SignupInitial()) {
    // User requested signup
    on<SignupRequested>((event, emit) async {
      emit(SignupLoading());

      try {
        await userRepository.register(
            event.firstName, event.lastName, event.email, event.password);

        loginBloc
            .add(LoginRequested(email: event.email, password: event.password));

        emit(SignupInitial());
      } on AuthenticationFailure catch (error) {
        emit(SignupFailure(error.message));
      } catch (error) {
        emit(SignupFailure(error.toString()));
      }
    });
  }
}
