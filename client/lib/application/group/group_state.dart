import 'package:client/domain/groups/group_dto.dart';
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

class GroupsFetchSuccess extends GroupState {
  final List<GroupDto> groups;

  const GroupsFetchSuccess(this.groups);

  @override
  List<Object?> get props => [groups];
}

class GroupOperationFailure extends GroupState {
  final Failure error;

  const GroupOperationFailure(this.error);

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'GroupOperationFailure { error: $error }';
}
