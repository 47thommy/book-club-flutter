import 'package:equatable/equatable.dart';

class PollForm extends Equatable {
  final int? id;
  final String question;
  final List<String> options;

  const PollForm({this.id, required this.question, required this.options});

  @override
  List<Object?> get props => [id, question, options];
}
