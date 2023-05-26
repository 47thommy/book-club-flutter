import 'package:client/infrastructure/user/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;

  AuthenticationBloc({required this.userRepository})
      : super(AuthenticationUninitialized()) {
    // Initial state
    on<AppStarted>((event, emit) async {
      final bool hasToken = await userRepository.hasToken();

      if (hasToken) {
        final user = await userRepository.getLoggedInUser();

        if (user.isEmpty) {
          emit(Unauthenticated());
        } else {
          emit(Authenticated(user));
        }
      } else {
        emit(Unauthenticated());
      }
    });

    // User logged in
    on<UserLoggedIn>((event, emit) async {
      emit(AuthenticationLoading());

      await userRepository.save(event.user, event.token);

      emit(Authenticated(event.user));
    });

    // Log out
    on<UserLoggedOut>((event, emit) async {
      emit(AuthenticationLoading());

      await userRepository.delete();

      emit(Unauthenticated());
    });

    // Login page requested
    on<LoginPageRequested>((event, emit) async {
      emit(LoginPageLoad());
    });

    // Signup page requested
    on<SignupPageRequested>((event, emit) async {
      emit(SignupPageLoad());
    });
  }
}
