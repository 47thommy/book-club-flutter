class AuthenticationFailure implements Exception {
  final String message;

  const AuthenticationFailure([this.message = 'An unknown exception occured.']);

  factory AuthenticationFailure.sessionExpired() =>
      const AuthenticationFailure('User session expired.');

  factory AuthenticationFailure.emailConflict() =>
      const AuthenticationFailure('An account already exists for that email.');

  factory AuthenticationFailure.invalidCredentials() =>
      const AuthenticationFailure(
          'An account with provided credentials does not exists.');
}
