import 'package:client/application/login/login.dart';
import 'package:client/domain/auth/login_form.dart';
import 'package:client/infrastructure/auth/dto/dto.dart';
import 'package:client/utils/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:client/application/auth/auth_bloc.dart';
import 'package:client/application/login/login_bloc.dart';
import 'package:client/application/login/login_state.dart';
import 'package:client/infrastructure/user/user_repository.dart';

class MockUserRepository extends Mock implements UserRepository {}

class MockAuthenticationBloc extends Mock implements AuthenticationBloc {}

void main() {
  late LoginBloc loginBloc;
  late MockUserRepository mockUserRepository;
  late MockAuthenticationBloc mockAuthenticationBloc;

  setUp(() {
    mockUserRepository = MockUserRepository();
    mockAuthenticationBloc = MockAuthenticationBloc();
    loginBloc = LoginBloc(
      userRepository: mockUserRepository,
      authenticationBloc: mockAuthenticationBloc,
    );
  });

  tearDown(() {
    loginBloc.close();
  });

  test('Initial state is LoginInitial', () {
    expect(loginBloc.state, LoginInitial());
  });
}
