import 'package:freezed_annotation/freezed_annotation.dart';

part 'group_dto.freezed.dart';
part 'group_dto.g.dart';

@freezed
class GroupDto with _$GroupDto {
  const GroupDto._();

  const factory GroupDto({
    required int id,
    required String name,
    required String description,
    required String imageUrl,
  }) = _GroupDto;

  factory GroupDto.fromJson(Map<String, dynamic> json) =>
      _$GroupDtoFromJson(json);
}
