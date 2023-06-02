import 'package:client/infrastructure/group/dto/group_dto.dart';
import 'package:client/utils/failure.dart';
import 'package:equatable/equatable.dart';

abstract class GroupState extends Equatable {
  const GroupState();

  @override
  List<Object?> get props => [];
}

class GroupsLoading extends GroupState {}

class GroupDetailLoaded extends GroupState {
  final GroupDto group;

  const GroupDetailLoaded(this.group);

  @override
  List<Object?> get props => [group];
}

class GroupCreated extends GroupState {
  final GroupDto group;

  const GroupCreated(this.group);

  @override
  List<Object?> get props => [group];
}

class GroupUpdated extends GroupState {
  final GroupDto group;

  const GroupUpdated(this.group);

  @override
  List<Object?> get props => [group];
}

class GroupJoined extends GroupState {
  final GroupDto group;

  const GroupJoined(this.group);

  @override
  List<Object?> get props => [group];
}

class GroupLeaved extends GroupState {
  final GroupDto group;

  const GroupLeaved(this.group);

  @override
  List<Object?> get props => [group];
}

class GroupsFetchSuccess extends GroupState {
  final List<GroupDto> trendingGroups;
  final List<GroupDto> joinedGroups;

  const GroupsFetchSuccess(
      {required this.trendingGroups, required this.joinedGroups});

  @override
  List<Object?> get props => [trendingGroups, joinedGroups];
}

class GroupMemberRemoved extends GroupState {
  final GroupDto group;

  const GroupMemberRemoved(this.group);

  @override
  List<Object?> get props => [group];
}

class GroupMemeberAdded extends GroupState {
  final GroupDto group;

  const GroupMemeberAdded(this.group);

  @override
  List<Object?> get props => [group];
}

class GroupOperationFailure extends GroupState {
  final Failure error;

  const GroupOperationFailure(this.error);

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'GroupOperationFailure { error: $error }';
}
