import 'dart:convert';

import 'package:client/infrastructure/group/dto/group_dto.dart';
import 'package:client/infrastructure/meeting/dto/meeting_dto.dart';
import 'package:client/infrastructure/user/dto/dto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MeetingCacheClient {
  final _storage = const FlutterSecureStorage();

  static const _idKey = 'id';
  static const _descriptionKey = 'description';
  static const _timeKey = 'time';
  static const _locationKey = 'location';
  static const _creatorKey = 'creator';
  static const _groupKey = 'group';

  Future<void> save(MeetingDto meeting) async {
    await _storage.write(key: _idKey, value: meeting.id.toString());
    await _storage.write(key: _descriptionKey, value: meeting.description);
    await _storage.write(key: _timeKey, value: meeting.time);
    await _storage.write(key: _locationKey, value: meeting.location);
    await _storage.write(key: _creatorKey, value: meeting.creator.toString());
    await _storage.write(key: _groupKey, value: meeting.group.toString());
  }

  Future<MeetingDto> loadMeeting() async {
    var id = await _storage.read(key: _idKey);
    var description = await _storage.read(key: _descriptionKey);
    var time = await _storage.read(key: _timeKey);
    var location = await _storage.read(key: _locationKey);
    var creator = await _storage.read(key: _creatorKey);
    var group = await _storage.read(key: _groupKey);

    if (id == null || description == null || time == null || location == null) {
      throw Exception("No Meeting");
    }

    return MeetingDto(
        id: int.parse(id),
        description: description,
        time: time,
        location: location,
        creator: UserDto.fromJson(jsonDecode(creator!)),
        group: GroupDto.fromJson((jsonDecode(group!))));
  }

  Future<void> deleteAll() async {
    await _storage.deleteAll();
  }
}
