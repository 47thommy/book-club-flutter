import 'package:freezed_annotation/freezed_annotation.dart';

part 'permission_dto.freezed.dart';
part 'permission_dto.g.dart';

@freezed
class PermissionDto with _$PermissionDto {
  const PermissionDto._();

  // static const empty = PermissionDto(id: -1, name: '');

  const factory PermissionDto({required int id, required String name}) =
      _PermissionDto;

  factory PermissionDto.fromJson(Map<String, dynamic> json) =>
      _$PermissionDtoFromJson(json);
}
