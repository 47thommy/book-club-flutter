import 'package:freezed_annotation/freezed_annotation.dart';
part 'user_dto.freezed.dart';
part 'user_dto.g.dart';

@freezed
class UserDto with _$UserDto {
  const UserDto._();

  const factory UserDto(
      {required int id,
      required String email,
      @JsonKey(name: 'first_name') required String firstName,
      @JsonKey(name: 'last_name') required String lastName}) = _User;

  static const empty = UserDto(id: -1, email: "", firstName: "", lastName: "");
  bool get isEmpty => this == UserDto.empty;

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);
}
