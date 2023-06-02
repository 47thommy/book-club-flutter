import 'package:client/infrastructure/user/dto/dto.dart';
import 'package:client/infrastructure/group/dto/group_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'meeting_dto.freezed.dart';
part 'meeting_dto.g.dart';

@freezed
class MeetingDto with _$MeetingDto {
  const MeetingDto._();

  const factory MeetingDto({
    required int id,
    required String description,
    required String time,
    required String date,
    required String location,
  }) = _MeetingDto;

  factory MeetingDto.fromJson(Map<String, dynamic> json) =>
      _$MeetingDtoFromJson(json);
}
