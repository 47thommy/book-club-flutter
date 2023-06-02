import 'dart:async';
import 'dart:developer';

import 'package:client/data/local/database_helper.dart';
import 'package:client/domain/user/profile_form.dart';
import 'package:client/domain/user/user.dart';

import 'package:client/infrastructure/auth/data_providers/auth_api.dart';
import 'package:client/infrastructure/auth/data_providers/auth_local.dart';
import 'package:client/infrastructure/auth/exceptions.dart';

import 'package:client/infrastructure/auth/dto/dto.dart';
import 'package:client/infrastructure/common/exception.dart';
import 'package:client/infrastructure/user/dto/dto.dart';

import 'package:client/utils/either.dart';
import 'package:client/utils/failure.dart';

class UserRepository {
  final CacheClient _cache;
  final AuthApi _authApi;
  User _loggedInUser = User.empty;

  UserRepository({CacheClient? cache, AuthApi? api})
      : _cache = cache ?? CacheClient(),
        _authApi = api ?? AuthApi();

  Future<Either<String>> login(LoginFormDto loginForm) async {
    try {
      final token = await _authApi.login(loginForm);
      return Either(value: token);
    } on AuthenticationFailure catch (error) {
      return Either(failure: Failure(error.message));
    } on TimeoutException catch (_) {
      return Either(failure: const Failure("Connection timed out"));
    }
  }

  Future<Either<UserDto>> register(RegisterFormDto registerForm) async {
    try {
      UserDto user = await _authApi.register(registerForm);
      return Either(value: user);
    } on AuthenticationFailure catch (error) {
      return Either(failure: Failure(error.message));
    } on TimeoutException catch (_) {
      return Either(failure: const Failure("Connection timed out"));
    }
  }

  Future<Either<User>> updateUser(ProfileForm form, String token) async {
    try {
      final updatedUser = await _authApi.updateUser(form: form, token: token);

      return Either(value: updatedUser.toUser());
    } on TimeoutException catch (_) {
      return Either(failure: const Failure("Connection timed out"));
    } on BCHttpException catch (error) {
      return Either(failure: Failure(error.message));
    } on AuthenticationFailure catch (error) {
      return Either(failure: Failure(error));
    } catch (error) {
      return Either(failure: Failure(error.toString()));
    }
  }

  Future<Either<User>> deleteUser(int userId, String token) async {
    throw UnimplementedError();
  }

  Future<bool> hasToken() async {
    return await _cache.getToken() != null;
  }

  Future<String> getToken() async {
    return await _cache.getToken() ?? '';
  }

  Future<UserDto> getLoggedInUser() async {
    final token = await getToken();

    try {
      final result = await _getUserByToken(token);

      // authenticaion failure
      if (result.hasError) {
        _loggedInUser = User.empty;
        return UserDto.empty;
      }

      _loggedInUser = result.value!.toUser();
      return result.value!;
    }
    // network error: return cached user
    on TimeoutException catch (_) {
      try {
        final userDto = await _cache.loadUser();
        _loggedInUser = userDto.toUser();

        return userDto;
      } catch (error) {
        return UserDto.empty;
      }
    }
  }

  User getLoggedInUserSync() {
    return _loggedInUser;
  }

  // throws timeout exception (for internal use only)
  Future<Either<UserDto>> _getUserByToken(String token) async {
    try {
      final user = await _authApi.getUser(token);

      return Either(value: user);
    } on AuthenticationFailure catch (error) {
      return Either(failure: Failure(error.message));
    }
  }

  // returns Failure on timeout exception (safe version of _getUserByToken)
  Future<Either<UserDto>> getUserByToken(String token) async {
    try {
      final user = await _authApi.getUser(token);

      return Either(value: user);
    } on AuthenticationFailure catch (error) {
      return Either(failure: Failure(error.message));
    } on TimeoutException catch (error) {
      return Either(failure: Failure(error.toString()));
    }
  }

  Future<void> save(UserDto user, String token) async {
    await _cache.save(user, token);
  }

  Future<void> delete() async {
    await _cache.deleteAll();
    await DatabaseHelper().dropDatabase();
  }
}
