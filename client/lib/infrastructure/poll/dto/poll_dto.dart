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
      _$PollDtoFromJson(json);
}
