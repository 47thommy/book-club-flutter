import 'dart:convert';
import 'dart:developer';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'poll_dto.freezed.dart';
part 'poll_dto.g.dart';

@freezed
class PollDto with _$PollDto {
  const PollDto._();

  const factory PollDto(
      {required int id,
      required String question,
      required List<String> options}) = _PollDto;

  factory PollDto.fromJson(Map<String, dynamic> json) =>
      _customPollDtoFromJson(json);
}

PollDto _customPollDtoFromJson(Map<String, dynamic> json) {
  try {
    json['options'] = jsonDecode(json['options']);
  } catch (_) {}

  return _$PollDtoFromJson(json);
}
