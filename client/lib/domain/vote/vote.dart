import 'package:equatable/equatable.dart';

class Vote extends Equatable {
  final int id;
  final String choice;

  const Vote({required this.id, required this.choice});

  @override
  List<Object?> get props => [id, choice];
}
