import 'package:client/domain/meeting/meeting.dart';
import 'package:client/infrastructure/group/dto/group_mapper.dart';
import 'package:client/infrastructure/meeting/meeting.dart';
import 'package:client/infrastructure/user/dto/dto.dart';

extension MeetingMapper on Meeting {
  MeetingDto toMeetingDto() {
    return MeetingDto(
        id: id,
        location: location,
        description: description,
        time: time,
        date: date);
  }
}

extension MeetingDtoMapper on MeetingDto {
  Meeting toMeeting() {
    return Meeting(
        id: id,
        location: location,
        description: description,
        time: time,
        date: date);
  }
}
