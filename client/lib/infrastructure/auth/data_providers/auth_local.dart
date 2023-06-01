import 'package:client/infrastructure/user/dto/dto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CacheClient {
  final _storage = const FlutterSecureStorage();

  static const _emailKey = 'email';
  static const _tokenKey = 'token';
  static const _firstNameKey = 'firstName';
  static const _lastNameKey = 'lastName';
  static const _usernameKey = 'username';
  static const _bioKey = 'bio';
  static const _imageUrlKey = 'iamgeUrl';
  static const _idKey = 'id';

  Future<void> save(UserDto user, String token) async {
    await _storage.write(key: _idKey, value: user.id.toString());
    await _storage.write(key: _emailKey, value: user.email);
    await _storage.write(key: _firstNameKey, value: user.firstName);
    await _storage.write(key: _lastNameKey, value: user.lastName);
    await _storage.write(key: _usernameKey, value: user.username);
    await _storage.write(key: _bioKey, value: user.bio);
    await _storage.write(key: _imageUrlKey, value: user.imageUrl);
    await _storage.write(key: _tokenKey, value: token);
  }

  Future<UserDto> loadUser() async {
    var id = await _storage.read(key: _idKey);
    var email = await _storage.read(key: _emailKey);
    var firstName = await _storage.read(key: _firstNameKey);
    var lastName = await _storage.read(key: _lastNameKey);
    var username = await _storage.read(key: _usernameKey);
    var bio = await _storage.read(key: _bioKey);
    var imageUrl = await _storage.read(key: _imageUrlKey);

    if (id == null ||
        email == null ||
        firstName == null ||
        lastName == null ||
        username == null ||
        bio == null ||
        imageUrl == null) {
      throw Exception("No user");
    }

    return UserDto(
        id: int.parse(id),
        email: email,
        firstName: firstName,
        lastName: lastName,
        username: username,
        bio: bio,
        imageUrl: imageUrl);
  }

  Future<String?> getToken() async {
    var token = await _storage.read(key: _tokenKey);

    return token;
  }

  Future<void> deleteAll() async {
    await _storage.deleteAll();
  }
}
