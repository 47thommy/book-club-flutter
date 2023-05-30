import 'package:client/domain/user/user.dart';
import 'package:client/presentation/pages/login/login_form.dart';
import 'package:client/utils/either.dart';

abstract class IUserRepository {
  Future<Either<String>> login(LoginForm loginForm);
  Future<Either<String>> register(LoginForm loginForm);
  Future<void> logout();
  Future<Either<String>> getLoggedInUser(LoginForm loginForm);
  User getLoggedInUserSync(LoginForm loginForm);
}
