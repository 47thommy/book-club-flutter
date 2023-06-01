import 'package:client/domain/user/user.dart';
import 'package:equatable/equatable.dart';
import 'package:client/infrastructure/role/model/role_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

// part 'user_dto.freezed.dart';
// part 'user_dto.g.dart';

class UserDto extends Equatable {
  final int id;
  final String email;
  final String username;
  final String firstName;
  final String lastName;
  final String bio;
  final String imageUrl;
  final RoleDto role;

  const UserDto(
      {required this.id,
      required this.email,
      required this.firstName,
      required this.lastName,
      required this.username,
      required this.bio,
      required this.imageUrl,
      required this.role});

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
        id: json['id'],
        email: json['email'],
        username: json['username'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        bio: json['bio'],
        imageUrl: json['imageUrl'],
        role: RoleDto.fromJson(json['role']));
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'username': username,
      'bio': bio,
      'imageUrl': imageUrl,
      'role': role.toJson()
    };
  }

  @override
  List<Object?> get props => [id, email, username, bio, imageUrl];
}

// @freezed
// class UserDto with _$UserDto {
//   const UserDto._();

//   const factory UserDto({
//     required int id,
//     required String email,
//     required String username,
//     required String bio,
//     required String imageUrl,
//     @JsonKey(name: 'first_name') required String firstName,
//     @JsonKey(name: 'last_name') required String lastName,
//     @Default(RoleDto.empty) RoleDto role,
//   }) = _UserDto;

//   static const empty = UserDto(
//       id: -1,
//       email: "",
//       firstName: "",
//       lastName: "",
//       username: "",
//       bio: "",
//       imageUrl: "");
//   bool get isEmpty => this == UserDto.empty;

//   factory UserDto.fromJson(Map<String, dynamic> json) =>
//       _$UserDtoFromJson(json);
// }