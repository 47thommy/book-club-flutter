import 'package:equatable/equatable.dart';

class Email extends Equatable {
  final String value;
  final RegExp regex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  Email(this.value) {
    if (value.isEmpty) {
      throw Exception('Email can not be empty');
    }
    if (!regex.hasMatch(value)) {
      throw Exception('Email format is not valid');
    }
  }

  @override
  List<Object?> get props => [value];
}
