import 'package:equatable/equatable.dart';
import 'package:client/infrastructure/user/dto/dto.dart';
import 'package:client/infrastructure/group/dto/group_dto.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';

// part 'meeting_dto.freezed.dart';
// part 'meeting_dto.g.dart';

class MeetingDto extends Equatable {
  final int id;
  final String description;
  final String time;
  final String location;
  final UserDto creator;
  final GroupDto group;

  const MeetingDto({
    required this.id,
    required this.description,
    required this.time,
    required this.location,
    required this.creator,
    required this.group,
  });

  factory MeetingDto.fromJson(Map<String, dynamic> json) {
    return MeetingDto(
        id: json['id'],
        description: json['description'],
        time: json['time'],
        location: json['location'],
        creator: UserDto.fromJson(json['creator'] as Map<String, dynamic>),
        group: GroupDto.fromJson(json['group'] as Map<String, dynamic>),);
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'description': description,
      'time': time,
      'location': location,
      'creator': creator,
      'group': group
    };
  }

  @override
  List<Object?> get props => [id, description, time, location, creator, group];
}


// @freezed
// class MeetingDto with _$MeetingDto {
//   const MeetingDto._();

//   const factory MeetingDto(
//       {required int id,
//       required String description,
//       required String time,
//       required String location,
//       required UserDto creator,
//       required GroupDto group}) = _MeetingDto;

//   factory MeetingDto.fromJson(Map<String, dynamic> json) =>
//       _$MeetingDtoFromJson(json);
// }
