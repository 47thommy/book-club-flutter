import 'package:freezed_annotation/freezed_annotation.dart';

part 'registration_form_dto.freezed.dart';
part 'registration_form_dto.g.dart';

@freezed
class RegisterFormDto with _$RegisterFormDto {
  const factory RegisterFormDto({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) = _RegisterFormDto;

  factory RegisterFormDto.fromJson(Map<String, dynamic> json) =>
      _$RegisterFormDtoFromJson(json);
}
