import 'package:equatable/equatable.dart';

class Meeting extends Equatable {
  final int id;
  final String description;
  final DateTime time;
  final String location;

  const Meeting(
      {required this.id,
      required this.description,
      required this.time,
      required this.location});

  @override
  List<Object?> get props => [id, description, time, location];
}
