import 'package:client/domain/user/profile_form.dart';
import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class ProfileUpdate extends UserEvent {
  final ProfileForm profile;

  const ProfileUpdate(this.profile);

  @override
  List<Object?> get props => [profile];

  @override
  String toString() => 'Profile update { profile: $profile }';
}


class UserDelete extends UserEvent {
  final int userId;


  const UserDelete(this.userId);

  @override
  List<Object?> get props => [userId];

  @override
  String toString() => 'User delete { user_id: $userId }';
}
