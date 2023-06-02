import 'package:client/application/auth/auth.dart';
import 'package:client/application/login/login.dart';
import 'package:client/infrastructure/auth/dto/login_form_dto.dart';
import 'package:client/infrastructure/auth/dto/registration_form_dto.dart';

import 'package:client/infrastructure/user/dto/dto.dart';
import 'package:client/utils/either.dart';
import 'package:client/utils/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:client/application/signup/signup_bloc.dart';
import 'package:client/application/signup/signup_event.dart';
import 'package:client/application/signup/signup_state.dart';
import 'package:client/infrastructure/user/user_repository.dart';

import 'package:mockito/annotations.dart';
import 'signup_bloc_test.mocks.dart';

@GenerateMocks([UserRepository, LoginBloc, AuthenticationBloc])
void main() {
  late SignupBloc signupBloc;
  late UserRepository userRepository;
  late LoginBloc loginBloc;
  late AuthenticationBloc authenticationBloc;

  setUp(() {
    userRepository = MockUserRepository();
    authenticationBloc = MockAuthenticationBloc();
    loginBloc = MockLoginBloc();
    signupBloc =
        SignupBloc(userRepository: userRepository, loginBloc: loginBloc);
  });

  test('Initial state should be SignupInitial', () {
    expect(signupBloc.state, equals(SignupInitial()));
  });

  test('Emits SignupLoading and SignupFailure when registration fails', () {
    const failure = Failure('Registration failed');

    when(userRepository.register(const RegisterFormDto(
            email: "email",
            password: "password",
            username: "username",
            firstName: 'firstname',
            lastName: 'firstname')))
        .thenAnswer((_) async => Either<UserDto>(failure: failure));

    const form = RegisterFormDto(
        email: "email",
        password: "password",
        username: "username",
        firstName: 'firstname',
        lastName: 'firstname');
    const event = SignupRequested(form);

    expectLater(
      signupBloc.stream,
      emitsInOrder([
        SignupLoading(),
        const SignupFailure(failure),
      ]),
    ).then((_) {
      expectLater(signupBloc.stream, emitsDone);
    });

    signupBloc.add(event);
  });

  test(
    'Emits SignupLoading and triggers LoginRequested when registration succeeds',
    () async {
      final mockResult = Either(
        value: const UserDto(
          id: 1,
          email: "email",
          username: "username",
          bio: "bio",
          imageUrl: "imageUrl",
          firstName: "firstName",
          lastName: "lastName",
        ),
      );

      when(userRepository.register(const RegisterFormDto(
        email: "email",
        password: "password",
        username: "username",
        firstName: 'firstname',
        lastName: 'firstname',
      ))).thenAnswer((_) async => mockResult);

      const form = RegisterFormDto(
        email: "email",
        password: "password",
        username: "username",
        firstName: 'firstname',
        lastName: 'firstname',
      );
      const event = SignupRequested(form);

      final loginFormDto =
          LoginFormDto(email: form.email, password: form.password);
      when(loginBloc.add(LoginRequested(loginFormDto))).thenAnswer((_) {
        authenticationBloc
            .add(UserLoggedIn(user: mockResult.value!, token: "null"));
      });

      expectLater(
        signupBloc.stream,
        emitsInOrder([
          SignupLoading(),
          SignupInitial(),
        ]),
      );

      signupBloc.add(event);
    },
  );
}
