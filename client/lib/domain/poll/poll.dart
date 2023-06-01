import 'package:equatable/equatable.dart';

class Poll extends Equatable {
  final int id;
  final String question;
  final List<String> options;

  const Poll({required this.id, required this.question, required this.options});

  @override
  List<Object?> get props => [id, question, options];
}
