class HttpException implements Exception {
  final String message;

  const HttpException([this.message = 'An unknown exception occured.']);

  factory HttpException.notFound() =>
      const HttpException('Resource not found.');

  factory HttpException.unauthorized() =>
      const HttpException('Requested action requires authorization.');
}
