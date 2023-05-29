// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_form_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

LoginFormDto _$LoginFormDtoFromJson(Map<String, dynamic> json) {
  return _LoginFormDto.fromJson(json);
}

/// @nodoc
mixin _$LoginFormDto {
  String get email => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LoginFormDtoCopyWith<LoginFormDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginFormDtoCopyWith<$Res> {
  factory $LoginFormDtoCopyWith(
          LoginFormDto value, $Res Function(LoginFormDto) then) =
      _$LoginFormDtoCopyWithImpl<$Res, LoginFormDto>;
  @useResult
  $Res call({String email, String password});
}

/// @nodoc
class _$LoginFormDtoCopyWithImpl<$Res, $Val extends LoginFormDto>
    implements $LoginFormDtoCopyWith<$Res> {
  _$LoginFormDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_LoginFormDtoCopyWith<$Res>
    implements $LoginFormDtoCopyWith<$Res> {
  factory _$$_LoginFormDtoCopyWith(
          _$_LoginFormDto value, $Res Function(_$_LoginFormDto) then) =
      __$$_LoginFormDtoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String email, String password});
}

/// @nodoc
class __$$_LoginFormDtoCopyWithImpl<$Res>
    extends _$LoginFormDtoCopyWithImpl<$Res, _$_LoginFormDto>
    implements _$$_LoginFormDtoCopyWith<$Res> {
  __$$_LoginFormDtoCopyWithImpl(
      _$_LoginFormDto _value, $Res Function(_$_LoginFormDto) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
  }) {
    return _then(_$_LoginFormDto(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_LoginFormDto implements _LoginFormDto {
  const _$_LoginFormDto({required this.email, required this.password});

  factory _$_LoginFormDto.fromJson(Map<String, dynamic> json) =>
      _$$_LoginFormDtoFromJson(json);

  @override
  final String email;
  @override
  final String password;

  @override
  String toString() {
    return 'LoginFormDto(email: $email, password: $password)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LoginFormDto &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, email, password);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LoginFormDtoCopyWith<_$_LoginFormDto> get copyWith =>
      __$$_LoginFormDtoCopyWithImpl<_$_LoginFormDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_LoginFormDtoToJson(
      this,
    );
  }
}

abstract class _LoginFormDto implements LoginFormDto {
  const factory _LoginFormDto(
      {required final String email,
      required final String password}) = _$_LoginFormDto;

  factory _LoginFormDto.fromJson(Map<String, dynamic> json) =
      _$_LoginFormDto.fromJson;

  @override
  String get email;
  @override
  String get password;
  @override
  @JsonKey(ignore: true)
  _$$_LoginFormDtoCopyWith<_$_LoginFormDto> get copyWith =>
      throw _privateConstructorUsedError;
}
