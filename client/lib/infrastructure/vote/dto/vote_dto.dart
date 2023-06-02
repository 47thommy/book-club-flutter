import 'dart:convert';
import 'dart:developer';

import 'package:equatable/equatable.dart';

class VoteDto extends Equatable {
  final int id;
  final String choice;

  const VoteDto({required this.id, required this.choice});

  factory VoteDto.fromJson(Map<String, dynamic> json) {
    return VoteDto(id: json['id'], choice: json['choice']);
  }

  @override
  List<Object?> get props => [id, choice];
}
