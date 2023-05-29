import 'package:freezed_annotation/freezed_annotation.dart';

part 'registration_form_dto.freezed.dart';
part 'registration_form_dto.g.dart';

@freezed
class RegisterFormDto with _$RegisterFormDto {
  const factory RegisterFormDto({
    required String email,
    required String password,
    @JsonKey(name: 'first_name') required String firstName,
    @JsonKey(name: 'last_name') required String lastName,
  }) = _RegisterFormDto;

  factory RegisterFormDto.fromJson(Map<String, dynamic> json) =>
      _$RegisterFormDtoFromJson(json);
}
