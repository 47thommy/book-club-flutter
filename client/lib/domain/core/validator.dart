import 'package:client/utils/either.dart';
import 'package:client/utils/failure.dart';

Either<String>? validateEmail(String email) {
  const emailRegex =
      r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";
  if (!RegExp(emailRegex).hasMatch(email)) {
    return Either(failure: const Failure("Invalid Email"));
  }
  if (email.isEmpty) {
    return Either(failure: const Failure("please enter your email"));
  } else {
    return null;
  }
}

Either<String>? validatePassword(String password) {
  const passwordRegex =
      r"""^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$""";

  if (password.length < 8) {
    return Either(
        failure: const Failure("Password must be aleast 8 charachters long"));
  }
  if (!RegExp(passwordRegex).hasMatch(password)) {
    return Either(
        failure: const Failure(
            "Password must contain one uppercase and one lowercase letter, \n a number and a special characte "));
  }
  if (password.isEmpty) {
    return Either(failure: const Failure("please enter your password"));
  } else {
    return null;
  }
}

Either<String>? validateUsername(String username) {
  final validCharacters = RegExp(r'^[a-zA-Z0-9]+$');

  if (username.isEmpty) {
    return Either(failure: const Failure("please enter a username"));
  } else if (validCharacters.hasMatch(username)) {
    return Either(
        failure:
            const Failure("please use only letters or numbers for username"));
  } else {
    return null;
  }
}

Either<String>? validateConfirmPassword(
    String newPassword, String oldPassword) {
  if (newPassword != oldPassword) {
    return Either(failure: const Failure("Passwords don't match"));
  } else {
    return null;
  }
}

Either<String>? validateStringLength(String input, String name, int length) {
  if (input.length < length) {
    return Either(
        failure: Failure("$name must be aleast $length characters long"));
  }
  return null;
}

Either<String>? validateNotEmpty(String input, String name) {
  if (input.isEmpty) {
    return Either(failure: Failure("$name must not be empty"));
  }
  return null;
}
