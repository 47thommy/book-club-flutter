// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meeting_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MeetingDto _$MeetingDtoFromJson(Map<String, dynamic> json) {
  return _MeetingDto.fromJson(json);
}

/// @nodoc
mixin _$MeetingDto {
  int get id => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get time => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;
  UserDto get creator => throw _privateConstructorUsedError;
  GroupDto get group => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MeetingDtoCopyWith<MeetingDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MeetingDtoCopyWith<$Res> {
  factory $MeetingDtoCopyWith(
          MeetingDto value, $Res Function(MeetingDto) then) =
      _$MeetingDtoCopyWithImpl<$Res, MeetingDto>;
  @useResult
  $Res call(
      {int id,
      String description,
      String time,
      String location,
      UserDto creator,
      GroupDto group});

  $UserDtoCopyWith<$Res> get creator;
  $GroupDtoCopyWith<$Res> get group;
}

/// @nodoc
class _$MeetingDtoCopyWithImpl<$Res, $Val extends MeetingDto>
    implements $MeetingDtoCopyWith<$Res> {
  _$MeetingDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? description = null,
    Object? time = null,
    Object? location = null,
    Object? creator = null,
    Object? group = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      creator: null == creator
          ? _value.creator
          : creator // ignore: cast_nullable_to_non_nullable
              as UserDto,
      group: null == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as GroupDto,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserDtoCopyWith<$Res> get creator {
    return $UserDtoCopyWith<$Res>(_value.creator, (value) {
      return _then(_value.copyWith(creator: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $GroupDtoCopyWith<$Res> get group {
    return $GroupDtoCopyWith<$Res>(_value.group, (value) {
      return _then(_value.copyWith(group: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_MeetingDtoCopyWith<$Res>
    implements $MeetingDtoCopyWith<$Res> {
  factory _$$_MeetingDtoCopyWith(
          _$_MeetingDto value, $Res Function(_$_MeetingDto) then) =
      __$$_MeetingDtoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String description,
      String time,
      String location,
      UserDto creator,
      GroupDto group});

  @override
  $UserDtoCopyWith<$Res> get creator;
  @override
  $GroupDtoCopyWith<$Res> get group;
}

/// @nodoc
class __$$_MeetingDtoCopyWithImpl<$Res>
    extends _$MeetingDtoCopyWithImpl<$Res, _$_MeetingDto>
    implements _$$_MeetingDtoCopyWith<$Res> {
  __$$_MeetingDtoCopyWithImpl(
      _$_MeetingDto _value, $Res Function(_$_MeetingDto) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? description = null,
    Object? time = null,
    Object? location = null,
    Object? creator = null,
    Object? group = null,
  }) {
    return _then(_$_MeetingDto(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      creator: null == creator
          ? _value.creator
          : creator // ignore: cast_nullable_to_non_nullable
              as UserDto,
      group: null == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as GroupDto,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MeetingDto extends _MeetingDto {
  const _$_MeetingDto(
      {required this.id,
      required this.description,
      required this.time,
      required this.location,
      required this.creator,
      required this.group})
      : super._();

  factory _$_MeetingDto.fromJson(Map<String, dynamic> json) =>
      _$$_MeetingDtoFromJson(json);

  @override
  final int id;
  @override
  final String description;
  @override
  final String time;
  @override
  final String location;
  @override
  final UserDto creator;
  @override
  final GroupDto group;

  @override
  String toString() {
    return 'MeetingDto(id: $id, description: $description, time: $time, location: $location, creator: $creator, group: $group)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MeetingDto &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.creator, creator) || other.creator == creator) &&
            (identical(other.group, group) || other.group == group));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, description, time, location, creator, group);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MeetingDtoCopyWith<_$_MeetingDto> get copyWith =>
      __$$_MeetingDtoCopyWithImpl<_$_MeetingDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MeetingDtoToJson(
      this,
    );
  }
}

abstract class _MeetingDto extends MeetingDto {
  const factory _MeetingDto(
      {required final int id,
      required final String description,
      required final String time,
      required final String location,
      required final UserDto creator,
      required final GroupDto group}) = _$_MeetingDto;
  const _MeetingDto._() : super._();

  factory _MeetingDto.fromJson(Map<String, dynamic> json) =
      _$_MeetingDto.fromJson;

  @override
  int get id;
  @override
  String get description;
  @override
  String get time;
  @override
  String get location;
  @override
  UserDto get creator;
  @override
  GroupDto get group;
  @override
  @JsonKey(ignore: true)
  _$$_MeetingDtoCopyWith<_$_MeetingDto> get copyWith =>
      throw _privateConstructorUsedError;
}
