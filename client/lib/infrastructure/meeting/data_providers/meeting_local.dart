import 'package:client/infrastructure/meeting/dto/meeting_dto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MeetingChacheClient {
  final _storage = const FlutterSecureStorage();

  static const _idKey = 'id';
  static const _descriptionKey = 'description';
  static const _time = 'time';
  static const _location = 'location';

  Future<void> save(MeetingDto meeting) async {
    await _storage.write(key: _idKey, value: meeting.id.toString());
    await _storage.write(key: _descriptionKey, value: meeting.description);
    await _storage.write(key: _time, value: meeting.time);
    await _storage.write(key: _location, value: meeting.location);
  }

  Future<MeetingDto> loadMeeting() async {
    var id = await _storage.read(key: _idKey);
    var description = await _storage.read(key: _descriptionKey);
    var time = await _storage.read(key: _time);
    var location = await _storage.read(key: _location);

    if (id == null || description == null || time == null || location == null) {
      throw Exception("No Meeting");
    }

    return MeetingDto(
      id: int.parse(id),
      description: description,
      time: time,
      location: location);
  }

  Future<void>  deleteAll() async {
    await _storage.deleteAll();
  }
}