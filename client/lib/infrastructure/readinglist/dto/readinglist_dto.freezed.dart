// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'readinglist_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ReadingListDto _$ReadinglistDtoFromJson(Map<String, dynamic> json) {
  return _ReadinglistDto.fromJson(json);
}

/// @nodoc
mixin _$ReadinglistDto {
  int get id => throw _privateConstructorUsedError;
  BookDto get book => throw _privateConstructorUsedError;
  GroupDto get group => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReadinglistDtoCopyWith<ReadingListDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReadinglistDtoCopyWith<$Res> {
  factory $ReadinglistDtoCopyWith(
          ReadingListDto value, $Res Function(ReadingListDto) then) =
      _$ReadinglistDtoCopyWithImpl<$Res, ReadingListDto>;
  @useResult
  $Res call({int id, BookDto book, GroupDto group});

  $BookDtoCopyWith<$Res> get book;
  $GroupDtoCopyWith<$Res> get group;
}

/// @nodoc
class _$ReadinglistDtoCopyWithImpl<$Res, $Val extends ReadingListDto>
    implements $ReadinglistDtoCopyWith<$Res> {
  _$ReadinglistDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? book = null,
    Object? group = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      book: null == book
          ? _value.book
          : book // ignore: cast_nullable_to_non_nullable
              as BookDto,
      group: null == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as GroupDto,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $BookDtoCopyWith<$Res> get book {
    return $BookDtoCopyWith<$Res>(_value.book, (value) {
      return _then(_value.copyWith(book: value) as $Val);
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
abstract class _$$_ReadinglistDtoCopyWith<$Res>
    implements $ReadinglistDtoCopyWith<$Res> {
  factory _$$_ReadinglistDtoCopyWith(
          _$_ReadinglistDto value, $Res Function(_$_ReadinglistDto) then) =
      __$$_ReadinglistDtoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, BookDto book, GroupDto group});

  @override
  $BookDtoCopyWith<$Res> get book;
  @override
  $GroupDtoCopyWith<$Res> get group;
}

/// @nodoc
class __$$_ReadinglistDtoCopyWithImpl<$Res>
    extends _$ReadinglistDtoCopyWithImpl<$Res, _$_ReadinglistDto>
    implements _$$_ReadinglistDtoCopyWith<$Res> {
  __$$_ReadinglistDtoCopyWithImpl(
      _$_ReadinglistDto _value, $Res Function(_$_ReadinglistDto) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? book = null,
    Object? group = null,
  }) {
    return _then(_$_ReadinglistDto(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      book: null == book
          ? _value.book
          : book // ignore: cast_nullable_to_non_nullable
              as BookDto,
      group: null == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as GroupDto,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ReadinglistDto extends _ReadinglistDto {
  const _$_ReadinglistDto(
      {required this.id, required this.book, required this.group})
      : super._();

  factory _$_ReadinglistDto.fromJson(Map<String, dynamic> json) =>
      _$$_ReadinglistDtoFromJson(json);

  @override
  final int id;
  @override
  final BookDto book;
  @override
  final GroupDto group;

  @override
  String toString() {
    return 'ReadinglistDto(id: $id, book: $book, group: $group)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ReadinglistDto &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.book, book) || other.book == book) &&
            (identical(other.group, group) || other.group == group));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, book, group);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ReadinglistDtoCopyWith<_$_ReadinglistDto> get copyWith =>
      __$$_ReadinglistDtoCopyWithImpl<_$_ReadinglistDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ReadinglistDtoToJson(
      this,
    );
  }
}

abstract class _ReadinglistDto extends ReadingListDto {
  const factory _ReadinglistDto(
      {required final int id,
      required final BookDto book,
      required final GroupDto group}) = _$_ReadinglistDto;
  const _ReadinglistDto._() : super._();

  factory _ReadinglistDto.fromJson(Map<String, dynamic> json) =
      _$_ReadinglistDto.fromJson;

  @override
  int get id;
  @override
  BookDto get book;
  @override
  GroupDto get group;
  @override
  @JsonKey(ignore: true)
  _$$_ReadinglistDtoCopyWith<_$_ReadinglistDto> get copyWith =>
      throw _privateConstructorUsedError;
}
