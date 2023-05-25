// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registration_form_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_RegisterFormDto _$$_RegisterFormDtoFromJson(Map<String, dynamic> json) =>
    _$_RegisterFormDto(
      email: json['email'] as String,
      password: json['password'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
    );

Map<String, dynamic> _$$_RegisterFormDtoToJson(_$_RegisterFormDto instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
    };
