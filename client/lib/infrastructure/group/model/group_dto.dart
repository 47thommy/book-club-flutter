import 'package:client/infrastructure/book/model/book_dto.dart';
import 'package:equatable/equatable.dart';
import 'package:client/infrastructure/poll/dto/poll_dto.dart';
import 'package:client/infrastructure/role/dto/role_dto.dart';
import 'package:client/infrastructure/user/dto/dto.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';

// part 'group_dto.freezed.dart';
// part 'group_dto.g.dart';

class GroupDto extends Equatable {
  final int id;
  final String name;
  final String description;
  final String imageUrl;
  final UserDto creator;
  final List<UserDto> members;
  final List<RoleDto> roles;
  final List<PollDto> polls;
  final List<BookDto> books;

  const GroupDto({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.creator,
    required this.members,
    required this.roles,
    required this.polls,
    required this.books,
  });

  factory GroupDto.fromJson(Map<String, dynamic> json) {
    return GroupDto(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      creator: UserDto.fromJson(json['creator'] as Map<String, dynamic>),
      members: (json['members'] as List<dynamic>)
          .map((e) => UserDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      roles: (json['roles'] as List<dynamic>)
          .map((e) => RoleDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      polls: (json['polls'] as List<dynamic>)
          .map((e) => PollDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'creator': creator,
      'members': members,
      'roles': roles,
      'polls': polls
    };
  }

  @override
  List<Object?> get props =>
      [id, name, description, imageUrl, creator, members, roles, polls];
}


// @freezed
// class GroupDto with _$GroupDto {
//   const GroupDto._();

//   const factory GroupDto({
//     required int id,
//     required String name,
//     required String description,
//     required String imageUrl,
//     required UserDto creator,
//     required List<UserDto> members,
//     required List<RoleDto> roles,
//     required List<PollDto> polls,
//   }) = _GroupDto;

//   factory GroupDto.fromJson(Map<String, dynamic> json) =>
//       _customGroupDtoFromJson(json);
// }

// GroupDto _customGroupDtoFromJson(Map<String, dynamic> json) {
//   json['members'] = json['members'].map((membership) {
//     if (membership.containsKey('user')) {
//       membership['user']['role'] = membership['role'];
//       return membership['user'];
//     }
//     return membership;
//   }).toList();

//   return _$GroupDtoFromJson(json);
// }
