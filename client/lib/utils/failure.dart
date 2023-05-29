import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final Object failure;

  const Failure(this.failure);

  @override
  String toString() {
    return "Error: $failure";
  }

  @override
  List<Object?> get props => [failure];
}
