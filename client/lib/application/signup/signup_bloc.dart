import 'package:client/infrastructure/auth/dto/dto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:client/application/login/login_bloc.dart';
import 'package:client/application/login/login_event.dart';
import 'package:client/application/signup/signup_event.dart';
import 'package:client/application/signup/signup_state.dart';
import 'package:client/infrastructure/user/user_repository.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final UserRepository userRepository;
  final LoginBloc loginBloc;

  SignupBloc({required this.userRepository, required this.loginBloc})
      : super(SignupInitial()) {
    // User requested signup
    on<SignupRequested>((event, emit) async {
      emit(SignupLoading());

      final result = await userRepository.register(event.form);

      if (result.hasError) {
        emit(SignupFailure(result.failure!));
      } else {
        final loginForm = LoginFormDto(
            email: event.form.email, password: event.form.password);

        loginBloc.add(LoginRequested(loginForm));
      }

      emit(SignupInitial());
    });
  }
}
