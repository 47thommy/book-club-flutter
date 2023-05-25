// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_form.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$LoginForm {
  Email get email => throw _privateConstructorUsedError;
  Password get password => throw _privateConstructorUsedError;
  String get firstName => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LoginFormCopyWith<LoginForm> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginFormCopyWith<$Res> {
  factory $LoginFormCopyWith(LoginForm value, $Res Function(LoginForm) then) =
      _$LoginFormCopyWithImpl<$Res, LoginForm>;
  @useResult
  $Res call(
      {Email email, Password password, String firstName, String lastName});
}

/// @nodoc
class _$LoginFormCopyWithImpl<$Res, $Val extends LoginForm>
    implements $LoginFormCopyWith<$Res> {
  _$LoginFormCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
    Object? firstName = null,
    Object? lastName = null,
  }) {
    return _then(_value.copyWith(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as Email,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as Password,
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
abstract class _$$_LoginFormCopyWith<$Res> implements $LoginFormCopyWith<$Res> {
  factory _$$_LoginFormCopyWith(
          _$_LoginForm value, $Res Function(_$_LoginForm) then) =
      __$$_LoginFormCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Email email, Password password, String firstName, String lastName});
}

/// @nodoc
class __$$_LoginFormCopyWithImpl<$Res>
    extends _$LoginFormCopyWithImpl<$Res, _$_LoginForm>
    implements _$$_LoginFormCopyWith<$Res> {
  __$$_LoginFormCopyWithImpl(
      _$_LoginForm _value, $Res Function(_$_LoginForm) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
    Object? firstName = null,
    Object? lastName = null,
  }) {
    return _then(_$_LoginForm(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as Email,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as Password,
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

class _$_LoginForm implements _LoginForm {
  const _$_LoginForm(
      {required this.email,
      required this.password,
      required this.firstName,
      required this.lastName});

  @override
  final Email email;
  @override
  final Password password;
  @override
  final String firstName;
  @override
  final String lastName;

  @override
  String toString() {
    return 'LoginForm(email: $email, password: $password, firstName: $firstName, lastName: $lastName)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LoginForm &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, email, password, firstName, lastName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LoginFormCopyWith<_$_LoginForm> get copyWith =>
      __$$_LoginFormCopyWithImpl<_$_LoginForm>(this, _$identity);
}

abstract class _LoginForm implements LoginForm {
  const factory _LoginForm(
      {required final Email email,
      required final Password password,
      required final String firstName,
      required final String lastName}) = _$_LoginForm;

  @override
  Email get email;
  @override
  Password get password;
  @override
  String get firstName;
  @override
  String get lastName;
  @override
  @JsonKey(ignore: true)
  _$$_LoginFormCopyWith<_$_LoginForm> get copyWith =>
      throw _privateConstructorUsedError;
}
