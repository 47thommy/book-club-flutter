import '../models/user.dart';

import '../data_providers/data_providers.dart';

class UserRepository {
  final remoteProvider = RemoteUserProvider();

  final localProvider = LocalUserProvider();

  Future<User> login(User user) async {
    final userData = await remoteProvider.login(user);

    await localProvider.saveUser(userData);

    return userData;
  }

  Future<User> register(User user) async {
    return remoteProvider.register(user);
  }

  Future<User> getCurrentUser() async {
    return localProvider.getLoggedInUser();
  }
}
