import 'package:client/domain/group/group.dart';
import 'package:client/domain/user/user.dart';
import 'package:client/infrastructure/role/role.dart';

import 'user_dto.dart';

extension UserMapper on User {
  UserDto toUserDto() {
    return UserDto(
      id: id,
      email: email,
      firstName: firstName,
      lastName: lastName,
      role: role.toRoleDto(),
    );
  }
}

extension UserDtoMapper on UserDto {
  User toUser() {
    return User(
      id: id,
      email: email,
      firstName: firstName,
      lastName: lastName,
      role: role.toRole(),
    );
  }
}
