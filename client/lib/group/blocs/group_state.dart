import 'package:client/group/models/group.dart';
import 'package:equatable/equatable.dart';

abstract class GroupState extends Equatable {
  const GroupState();
}

class GroupLoading extends GroupState {
  @override
  List<Object?> get props => [];
}

class GroupCreateInitiated extends GroupState {
  @override
  List<Object?> get props => [];
}

class GroupCreated extends GroupState {
  final Group group;

  const GroupCreated(this.group);

  @override
  List<Object?> get props => [group];
}

class GroupSearchSuccess extends GroupState {
  final Iterable<Group> groups;

  const GroupSearchSuccess(this.groups);

  @override
  List<Object?> get props => [groups];
}

class GroupsLoaded extends GroupState {
  final Iterable<Group> groups;
  final Iterable<Group> joinedGroups;

  const GroupsLoaded(this.groups, this.joinedGroups);

  @override
  List<Object?> get props => [groups];
}

class JoinedGroupsLoaded extends GroupState {
  final Iterable<Group> groups;

  const JoinedGroupsLoaded(this.groups);

  @override
  List<Object?> get props => [groups];
}

class GroupOperationFailure extends GroupState {
  final Object error;

  const GroupOperationFailure(this.error);

  @override
  List<Object?> get props => [error];
}
