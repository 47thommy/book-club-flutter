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
  UserDto get creator => throw _privateConstructorUsedError;
  List<UserDto> get members => throw _privateConstructorUsedError;
  List<RoleDto> get roles => throw _privateConstructorUsedError;
  List<PollDto> get polls => throw _privateConstructorUsedError;
  List<BookDto> get books => throw _privateConstructorUsedError;
  List<MeetingDto> get meetings => throw _privateConstructorUsedError;

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
  $Res call(
      {int id,
      String name,
      String description,
      String imageUrl,
      UserDto creator,
      List<UserDto> members,
      List<RoleDto> roles,
      List<PollDto> polls,
      List<BookDto> books,
      List<MeetingDto> meetings});

  $UserDtoCopyWith<$Res> get creator;
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
    Object? creator = null,
    Object? members = null,
    Object? roles = null,
    Object? polls = null,
    Object? books = null,
    Object? meetings = null,
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
      creator: null == creator
          ? _value.creator
          : creator // ignore: cast_nullable_to_non_nullable
              as UserDto,
      members: null == members
          ? _value.members
          : members // ignore: cast_nullable_to_non_nullable
              as List<UserDto>,
      roles: null == roles
          ? _value.roles
          : roles // ignore: cast_nullable_to_non_nullable
              as List<RoleDto>,
      polls: null == polls
          ? _value.polls
          : polls // ignore: cast_nullable_to_non_nullable
              as List<PollDto>,
      books: null == books
          ? _value.books
          : books // ignore: cast_nullable_to_non_nullable
              as List<BookDto>,
      meetings: null == meetings
          ? _value.meetings
          : meetings // ignore: cast_nullable_to_non_nullable
              as List<MeetingDto>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserDtoCopyWith<$Res> get creator {
    return $UserDtoCopyWith<$Res>(_value.creator, (value) {
      return _then(_value.copyWith(creator: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_GroupDtoCopyWith<$Res> implements $GroupDtoCopyWith<$Res> {
  factory _$$_GroupDtoCopyWith(
          _$_GroupDto value, $Res Function(_$_GroupDto) then) =
      __$$_GroupDtoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      String description,
      String imageUrl,
      UserDto creator,
      List<UserDto> members,
      List<RoleDto> roles,
      List<PollDto> polls,
      List<BookDto> books,
      List<MeetingDto> meetings});

  @override
  $UserDtoCopyWith<$Res> get creator;
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
    Object? creator = null,
    Object? members = null,
    Object? roles = null,
    Object? polls = null,
    Object? books = null,
    Object? meetings = null,
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
      creator: null == creator
          ? _value.creator
          : creator // ignore: cast_nullable_to_non_nullable
              as UserDto,
      members: null == members
          ? _value._members
          : members // ignore: cast_nullable_to_non_nullable
              as List<UserDto>,
      roles: null == roles
          ? _value._roles
          : roles // ignore: cast_nullable_to_non_nullable
              as List<RoleDto>,
      polls: null == polls
          ? _value._polls
          : polls // ignore: cast_nullable_to_non_nullable
              as List<PollDto>,
      books: null == books
          ? _value._books
          : books // ignore: cast_nullable_to_non_nullable
              as List<BookDto>,
      meetings: null == meetings
          ? _value._meetings
          : meetings // ignore: cast_nullable_to_non_nullable
              as List<MeetingDto>,
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
      required this.imageUrl,
      required this.creator,
      required final List<UserDto> members,
      required final List<RoleDto> roles,
      required final List<PollDto> polls,
      required final List<BookDto> books,
      required final List<MeetingDto> meetings})
      : _members = members,
        _roles = roles,
        _polls = polls,
        _books = books,
        _meetings = meetings,
        super._();

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
  final UserDto creator;
  final List<UserDto> _members;
  @override
  List<UserDto> get members {
    if (_members is EqualUnmodifiableListView) return _members;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_members);
  }

  final List<RoleDto> _roles;
  @override
  List<RoleDto> get roles {
    if (_roles is EqualUnmodifiableListView) return _roles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_roles);
  }

  final List<PollDto> _polls;
  @override
  List<PollDto> get polls {
    if (_polls is EqualUnmodifiableListView) return _polls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_polls);
  }

  final List<BookDto> _books;
  @override
  List<BookDto> get books {
    if (_books is EqualUnmodifiableListView) return _books;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_books);
  }

  final List<MeetingDto> _meetings;
  @override
  List<MeetingDto> get meetings {
    if (_meetings is EqualUnmodifiableListView) return _meetings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_meetings);
  }

  @override
  String toString() {
    return 'GroupDto(id: $id, name: $name, description: $description, imageUrl: $imageUrl, creator: $creator, members: $members, roles: $roles, polls: $polls, books: $books, meetings: $meetings)';
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
                other.imageUrl == imageUrl) &&
            (identical(other.creator, creator) || other.creator == creator) &&
            const DeepCollectionEquality().equals(other._members, _members) &&
            const DeepCollectionEquality().equals(other._roles, _roles) &&
            const DeepCollectionEquality().equals(other._polls, _polls) &&
            const DeepCollectionEquality().equals(other._books, _books) &&
            const DeepCollectionEquality().equals(other._meetings, _meetings));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      description,
      imageUrl,
      creator,
      const DeepCollectionEquality().hash(_members),
      const DeepCollectionEquality().hash(_roles),
      const DeepCollectionEquality().hash(_polls),
      const DeepCollectionEquality().hash(_books),
      const DeepCollectionEquality().hash(_meetings));

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
      required final String imageUrl,
      required final UserDto creator,
      required final List<UserDto> members,
      required final List<RoleDto> roles,
      required final List<PollDto> polls,
      required final List<BookDto> books,
      required final List<MeetingDto> meetings}) = _$_GroupDto;
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
  UserDto get creator;
  @override
  List<UserDto> get members;
  @override
  List<RoleDto> get roles;
  @override
  List<PollDto> get polls;
  @override
  List<BookDto> get books;
  @override
  List<MeetingDto> get meetings;
  @override
  @JsonKey(ignore: true)
  _$$_GroupDtoCopyWith<_$_GroupDto> get copyWith =>
      throw _privateConstructorUsedError;
}
