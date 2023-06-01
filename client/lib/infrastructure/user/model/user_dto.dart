import 'package:client/domain/user/user.dart';
import 'package:equatable/equatable.dart';
import 'package:client/infrastructure/role/dto/role_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

// part 'user_dto.freezed.dart';
// part 'user_dto.g.dart';

class UserDto extends Equatable {
  final int id;
  final String email;
  final String username;
  final String bio;
  final String imageUrl;

  const UserDto({
    required this.id,
    required this.email,
    required this.username,
    required this.bio,
    required this.imageUrl,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
        id: json['id'],
        email: json['email'],
        username: json['username'],
        bio: json['bio'],
        imageUrl: json['imageUrl']);
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'username': username,
      'bio': bio,
      'imageUrl': imageUrl
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