import 'package:client/infrastructure/role/dto/role_dto.dart';
import 'package:client/infrastructure/user/dto/dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'group_dto.freezed.dart';
part 'group_dto.g.dart';

@freezed
class GroupDto with _$GroupDto {
  const GroupDto._();

  const factory GroupDto(
      {required int id,
      required String name,
      required String description,
      required String imageUrl,
      required UserDto creator,
      required List<UserDto> members,
      required List<RoleDto> roles}) = _GroupDto;

  factory GroupDto.fromJson(Map<String, dynamic> json) =>
      _customGroupDtoFromJson(json);
}

GroupDto _customGroupDtoFromJson(Map<String, dynamic> json) {
  json['members'] = json['members'].map((membership) {
    membership['user']['role'] = membership['role'];
    return membership['user'];
  }).toList();

  return _$GroupDtoFromJson(json);
}
