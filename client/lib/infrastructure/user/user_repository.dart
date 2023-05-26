import 'package:client/infrastructure/auth/data_providers/auth_api.dart';
import 'package:client/infrastructure/auth/data_providers/auth_local.dart';
import 'package:client/infrastructure/auth/exceptions.dart';
import 'package:client/domain/auth/dto/login_form_dto.dart';
import 'package:client/domain/auth/dto/registration_form_dto.dart';
import 'package:client/domain/user/user_dto.dart';
import 'package:client/utils/either.dart';
import 'package:client/utils/failure.dart';

class UserRepository {
  final CacheClient _cache;
  final AuthApi _authApi;

  UserRepository({CacheClient? cache, AuthApi? api})
      : _cache = cache ?? CacheClient(),
        _authApi = api ?? AuthApi();

  Future<Either<String>> login(LoginFormDto loginForm) async {
    try {
      final token = await _authApi.login(loginForm);
      return Either(value: token);
    } on AuthenticationFailure catch (error) {
      return Either(failure: Failure(error.message));
    } catch (error) {
      return Either(failure: Failure(error.toString()));
    }
  }

  Future<Either<UserDto>> register(RegisterFormDto registerForm) async {
    try {
      UserDto user = await _authApi.register(registerForm);
      return Either(value: user);
    } on AuthenticationFailure catch (error) {
      return Either(failure: Failure(error.message));
    }
  }

  Future<bool> hasToken() async {
    return await _cache.getToken() != null;
  }

  Future<String> getToken() async {
    return await _cache.getToken() ?? '';
  }

  Future<UserDto> getLoggedInUser() async {
    final token = await getToken();

    final result = await getUserByToken(token);

    if (result.hasError) return UserDto.empty;

    return result.value!;

    //   return await _cache.loadUser();}
    // return UserDto.empty;
  }

  Future<Either<UserDto>> getUserByToken(String token) async {
    try {
      final user = await _authApi.getUser(token);
      return Either(value: user);
    } on AuthenticationFailure catch (error) {
      return Either(failure: Failure(error.message));
    }
  }

  Future<void> save(UserDto user, String token) async {
    await _cache.save(user, token);
  }

  Future<void> delete() async {
    await _cache.deleteAll();
  }
}
