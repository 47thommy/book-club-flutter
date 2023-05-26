import 'package:client/utils/failure.dart';
import 'package:equatable/equatable.dart';

abstract class SignupState extends Equatable {
  const SignupState();

  @override
  List<Object?> get props => [];
}

class SignupInitial extends SignupState {}

class SignupLoading extends SignupState {}

class SignupFailure extends SignupState {
  final Failure error;

  const SignupFailure(this.error);

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'SignupFailure { error: $error }';
}
