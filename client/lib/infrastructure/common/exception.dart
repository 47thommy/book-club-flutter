class BCHttpException implements Exception {
  final String message;

  const BCHttpException([this.message = 'An unknown exception occured.']);

  factory BCHttpException.notFound() =>
      const BCHttpException('Resource not found.');

  factory BCHttpException.unauthorized() =>
      const BCHttpException('Requested action requires authorization.');
}
