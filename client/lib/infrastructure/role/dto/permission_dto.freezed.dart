// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'permission_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PermissionDto _$PermissionDtoFromJson(Map<String, dynamic> json) {
  return _PermissionDto.fromJson(json);
}

/// @nodoc
mixin _$PermissionDto {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PermissionDtoCopyWith<PermissionDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PermissionDtoCopyWith<$Res> {
  factory $PermissionDtoCopyWith(
          PermissionDto value, $Res Function(PermissionDto) then) =
      _$PermissionDtoCopyWithImpl<$Res, PermissionDto>;
  @useResult
  $Res call({int id, String name});
}

/// @nodoc
class _$PermissionDtoCopyWithImpl<$Res, $Val extends PermissionDto>
    implements $PermissionDtoCopyWith<$Res> {
  _$PermissionDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PermissionDtoCopyWith<$Res>
    implements $PermissionDtoCopyWith<$Res> {
  factory _$$_PermissionDtoCopyWith(
          _$_PermissionDto value, $Res Function(_$_PermissionDto) then) =
      __$$_PermissionDtoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name});
}

/// @nodoc
class __$$_PermissionDtoCopyWithImpl<$Res>
    extends _$PermissionDtoCopyWithImpl<$Res, _$_PermissionDto>
    implements _$$_PermissionDtoCopyWith<$Res> {
  __$$_PermissionDtoCopyWithImpl(
      _$_PermissionDto _value, $Res Function(_$_PermissionDto) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
  }) {
    return _then(_$_PermissionDto(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PermissionDto extends _PermissionDto {
  const _$_PermissionDto({required this.id, required this.name}) : super._();

  factory _$_PermissionDto.fromJson(Map<String, dynamic> json) =>
      _$$_PermissionDtoFromJson(json);

  @override
  final int id;
  @override
  final String name;

  @override
  String toString() {
    return 'PermissionDto(id: $id, name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PermissionDto &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PermissionDtoCopyWith<_$_PermissionDto> get copyWith =>
      __$$_PermissionDtoCopyWithImpl<_$_PermissionDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PermissionDtoToJson(
      this,
    );
  }
}

abstract class _PermissionDto extends PermissionDto {
  const factory _PermissionDto(
      {required final int id, required final String name}) = _$_PermissionDto;
  const _PermissionDto._() : super._();

  factory _PermissionDto.fromJson(Map<String, dynamic> json) =
      _$_PermissionDto.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$_PermissionDtoCopyWith<_$_PermissionDto> get copyWith =>
      throw _privateConstructorUsedError;
}
