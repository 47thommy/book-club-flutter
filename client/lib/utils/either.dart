import 'package:client/utils/failure.dart';

class Either<T> {
  final T? value;
  final Failure? failure;

  Either({this.value, this.failure});

  bool get hasError => failure != null;
}
