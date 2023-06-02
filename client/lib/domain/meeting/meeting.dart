import 'package:client/domain/group/group.dart';
import 'package:client/domain/user/user.dart';
import 'package:equatable/equatable.dart';

class Meeting extends Equatable {
  final int id;
  final String description;
  final String time;
  final String location;
  final String date;

  const Meeting({
    required this.id,
    required this.description,
    required this.time,
    required this.location,
    required this.date,
  });

  @override
  List<Object?> get props => [id, description, time, location];
}
