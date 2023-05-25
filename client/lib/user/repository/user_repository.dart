import 'package:client/user/data_providers/api_client.dart';
import 'package:client/user/data_providers/cache_client.dart';
import 'package:client/infrastructure/user/models/user_dto.dart';

class UserRepository {
  final CacheClient _cache;
  final AuthApiClient _authApi;

  UserRepository({CacheClient? cache, AuthApiClient? api})
      : _cache = cache ?? CacheClient(),
        _authApi = api ?? AuthApiClient();

  Future<String> login(String email, String password) async {
    final token = await _authApi.login(email, password);

    return token;
  }

  Future<UserDto> register(
      String firstName, String lastName, String email, String password) async {
    return await _authApi.register(firstName, lastName, email, password);
  }

  Future<bool> hasToken() async {
    return await _cache.getToken() != null;
  }

  Future<UserDto> getLoggedInUser() async {
    if (await hasToken()) return await _cache.loadUser();

    return UserDto.empty;
  }

  Future<UserDto> getUserByToken(String token) async {
    return await _authApi.getUser(token);
  }

  Future<void> save(UserDto user, String token) async {
    await _cache.save(user, token);
  }

  Future<void> delete() async {
    await _cache.deleteAll();
  }
}
