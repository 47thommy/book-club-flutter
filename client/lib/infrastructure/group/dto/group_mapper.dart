import 'package:client/domain/book/book.dart';
import 'package:client/domain/group/group.dart';
import 'package:client/domain/poll/poll.dart';
import 'package:client/domain/role/role.dart';
import 'package:client/infrastructure/book/dto/book_dto.dart';
import 'package:client/infrastructure/book/dto/book_mapper.dart';
import 'package:client/infrastructure/group/dto/group_dto.dart';
import 'package:client/infrastructure/poll/poll.dart';
import 'package:client/infrastructure/role/role.dart';
import 'package:client/infrastructure/user/dto/user_mapper.dart';

extension GroupMapper on Group {
  GroupDto toGroupDto() {
    return GroupDto(
      id: id,
      name: name,
      description: description,
      imageUrl: imageUrl,
      creator: creator.toUserDto(),
      members: members.map((user) => user.toUserDto()).toList(),
      roles: roles.map<RoleDto>((role) => role.toRoleDto()).toList(),
      polls: polls.map<PollDto>((poll) => poll.toPollDto()).toList(),
      books: books.map<BookDto>((book) => book.toBookDto()).toList(),
    );
  }
}

extension GroupDtoMapper on GroupDto {
  Group toGroup() {
    return Group(
      id: id,
      name: name,
      description: description,
      imageUrl: imageUrl,
      creator: creator.toUser(),
      members: members.map((userDto) => userDto.toUser()).toList(),
      roles: roles.map<Role>((roleDto) => roleDto.toRole()).toList(),
      polls: polls.map<Poll>((pollDto) => pollDto.toPoll()).toList(),
      books: books.map<Book>((bookDto) => bookDto.toBook()).toList(),
    );
  }
}
