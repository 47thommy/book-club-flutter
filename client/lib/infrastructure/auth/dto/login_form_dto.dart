import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_form_dto.freezed.dart';
part 'login_form_dto.g.dart';

@freezed
class LoginFormDto with _$LoginFormDto {
  const factory LoginFormDto({
    required String email,
    required String password,
  }) = _LoginFormDto;

  factory LoginFormDto.fromJson(Map<String, dynamic> json) =>
      _$LoginFormDtoFromJson(json);
}
