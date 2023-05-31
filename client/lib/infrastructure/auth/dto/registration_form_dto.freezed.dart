// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'registration_form_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

RegisterFormDto _$RegisterFormDtoFromJson(Map<String, dynamic> json) {
  return _RegisterFormDto.fromJson(json);
}

/// @nodoc
mixin _$RegisterFormDto {
  String get email => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  @JsonKey(name: 'first_name')
  String get firstName => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_name')
  String get lastName => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RegisterFormDtoCopyWith<RegisterFormDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegisterFormDtoCopyWith<$Res> {
  factory $RegisterFormDtoCopyWith(
          RegisterFormDto value, $Res Function(RegisterFormDto) then) =
      _$RegisterFormDtoCopyWithImpl<$Res, RegisterFormDto>;
  @useResult
  $Res call(
      {String email,
      String password,
      String username,
      @JsonKey(name: 'first_name') String firstName,
      @JsonKey(name: 'last_name') String lastName});
}

/// @nodoc
class _$RegisterFormDtoCopyWithImpl<$Res, $Val extends RegisterFormDto>
    implements $RegisterFormDtoCopyWith<$Res> {
  _$RegisterFormDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
    Object? username = null,
    Object? firstName = null,
    Object? lastName = null,
  }) {
    return _then(_value.copyWith(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RegisterFormDtoCopyWith<$Res>
    implements $RegisterFormDtoCopyWith<$Res> {
  factory _$$_RegisterFormDtoCopyWith(
          _$_RegisterFormDto value, $Res Function(_$_RegisterFormDto) then) =
      __$$_RegisterFormDtoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String email,
      String password,
      String username,
      @JsonKey(name: 'first_name') String firstName,
      @JsonKey(name: 'last_name') String lastName});
}

/// @nodoc
class __$$_RegisterFormDtoCopyWithImpl<$Res>
    extends _$RegisterFormDtoCopyWithImpl<$Res, _$_RegisterFormDto>
    implements _$$_RegisterFormDtoCopyWith<$Res> {
  __$$_RegisterFormDtoCopyWithImpl(
      _$_RegisterFormDto _value, $Res Function(_$_RegisterFormDto) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
    Object? username = null,
    Object? firstName = null,
    Object? lastName = null,
  }) {
    return _then(_$_RegisterFormDto(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_RegisterFormDto implements _RegisterFormDto {
  const _$_RegisterFormDto(
      {required this.email,
      required this.password,
      required this.username,
      @JsonKey(name: 'first_name') required this.firstName,
      @JsonKey(name: 'last_name') required this.lastName});

  factory _$_RegisterFormDto.fromJson(Map<String, dynamic> json) =>
      _$$_RegisterFormDtoFromJson(json);

  @override
  final String email;
  @override
  final String password;
  @override
  final String username;
  @override
  @JsonKey(name: 'first_name')
  final String firstName;
  @override
  @JsonKey(name: 'last_name')
  final String lastName;

  @override
  String toString() {
    return 'RegisterFormDto(email: $email, password: $password, username: $username, firstName: $firstName, lastName: $lastName)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RegisterFormDto &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, email, password, username, firstName, lastName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RegisterFormDtoCopyWith<_$_RegisterFormDto> get copyWith =>
      __$$_RegisterFormDtoCopyWithImpl<_$_RegisterFormDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RegisterFormDtoToJson(
      this,
    );
  }
}

abstract class _RegisterFormDto implements RegisterFormDto {
  const factory _RegisterFormDto(
          {required final String email,
          required final String password,
          required final String username,
          @JsonKey(name: 'first_name') required final String firstName,
          @JsonKey(name: 'last_name') required final String lastName}) =
      _$_RegisterFormDto;

  factory _RegisterFormDto.fromJson(Map<String, dynamic> json) =
      _$_RegisterFormDto.fromJson;

  @override
  String get email;
  @override
  String get password;
  @override
  String get username;
  @override
  @JsonKey(name: 'first_name')
  String get firstName;
  @override
  @JsonKey(name: 'last_name')
  String get lastName;
  @override
  @JsonKey(ignore: true)
  _$$_RegisterFormDtoCopyWith<_$_RegisterFormDto> get copyWith =>
      throw _privateConstructorUsedError;
}
