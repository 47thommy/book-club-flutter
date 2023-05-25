class AuthenticationFailure implements Exception {
  static const sessionExpired = 'session-expired';
  static const emailConflict = 'email-already-in-use';
  static const weakPassword = 'weak-password';
  static const invalidCredentials = 'invalid-credentails';

  final String message;

  const AuthenticationFailure([this.message = 'An unknown exception occured.']);

  factory AuthenticationFailure.fromCode(String code) {
    switch (code) {
      case sessionExpired:
        return const AuthenticationFailure('User session expired.');

      case emailConflict:
        return const AuthenticationFailure(
            'An account already exists for that email.');

      case weakPassword:
        return const AuthenticationFailure('Please enter a stronger password.');

      case invalidCredentials:
        return const AuthenticationFailure(
            'An account with provided credentials does not exists.');

      default:
        return const AuthenticationFailure();
    }
  }
}
