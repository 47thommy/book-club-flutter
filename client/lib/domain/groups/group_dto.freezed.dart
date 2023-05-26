// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GroupDto _$GroupDtoFromJson(Map<String, dynamic> json) {
  return _GroupDto.fromJson(json);
}

/// @nodoc
mixin _$GroupDto {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GroupDtoCopyWith<GroupDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupDtoCopyWith<$Res> {
  factory $GroupDtoCopyWith(GroupDto value, $Res Function(GroupDto) then) =
      _$GroupDtoCopyWithImpl<$Res, GroupDto>;
  @useResult
  $Res call({int id, String name, String description, String imageUrl});
}

/// @nodoc
class _$GroupDtoCopyWithImpl<$Res, $Val extends GroupDto>
    implements $GroupDtoCopyWith<$Res> {
  _$GroupDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? imageUrl = null,
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
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GroupDtoCopyWith<$Res> implements $GroupDtoCopyWith<$Res> {
  factory _$$_GroupDtoCopyWith(
          _$_GroupDto value, $Res Function(_$_GroupDto) then) =
      __$$_GroupDtoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name, String description, String imageUrl});
}

/// @nodoc
class __$$_GroupDtoCopyWithImpl<$Res>
    extends _$GroupDtoCopyWithImpl<$Res, _$_GroupDto>
    implements _$$_GroupDtoCopyWith<$Res> {
  __$$_GroupDtoCopyWithImpl(
      _$_GroupDto _value, $Res Function(_$_GroupDto) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? imageUrl = null,
  }) {
    return _then(_$_GroupDto(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GroupDto extends _GroupDto {
  const _$_GroupDto(
      {required this.id,
      required this.name,
      required this.description,
      required this.imageUrl})
      : super._();

  factory _$_GroupDto.fromJson(Map<String, dynamic> json) =>
      _$$_GroupDtoFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String description;
  @override
  final String imageUrl;

  @override
  String toString() {
    return 'GroupDto(id: $id, name: $name, description: $description, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GroupDto &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, description, imageUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GroupDtoCopyWith<_$_GroupDto> get copyWith =>
      __$$_GroupDtoCopyWithImpl<_$_GroupDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GroupDtoToJson(
      this,
    );
  }
}

abstract class _GroupDto extends GroupDto {
  const factory _GroupDto(
      {required final int id,
      required final String name,
      required final String description,
      required final String imageUrl}) = _$_GroupDto;
  const _GroupDto._() : super._();

  factory _GroupDto.fromJson(Map<String, dynamic> json) = _$_GroupDto.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get description;
  @override
  String get imageUrl;
  @override
  @JsonKey(ignore: true)
  _$$_GroupDtoCopyWith<_$_GroupDto> get copyWith =>
      throw _privateConstructorUsedError;
}
