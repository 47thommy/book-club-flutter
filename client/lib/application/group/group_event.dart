import 'package:client/infrastructure/group/dto/group_dto.dart';
import 'package:equatable/equatable.dart';

abstract class GroupEvent extends Equatable {
  const GroupEvent();

  @override
  List<Object?> get props => [];
}

class LoadGroups extends GroupEvent {
  @override
  String toString() => 'Load groups';
}

class LoadGroupDetail extends GroupEvent {
  final int groupId;

  const LoadGroupDetail(this.groupId);

  @override
  List<Object?> get props => [groupId];

  @override
  String toString() => 'Group load { group: $groupId }';
}

class GroupCreate extends GroupEvent {
  final GroupDto group;

  const GroupCreate(this.group);

  @override
  List<Object?> get props => [group];

  @override
  String toString() => 'Group create { group: $group }';
}

class GroupDelete extends GroupEvent {
  final int id;

  const GroupDelete(this.id);

  @override
  List<Object?> get props => [id];

  @override
  String toString() => 'Group delete { group_id: $id }';
}

class GroupJoin extends GroupEvent {
  final GroupDto group;

  const GroupJoin(this.group);

  @override
  List<Object?> get props => [group];

  @override
  String toString() => 'Group join { group: $group }';
}

class GroupLeave extends GroupEvent {
  final GroupDto group;

  const GroupLeave(this.group);

  @override
  List<Object?> get props => [group];

  @override
  String toString() => 'Group leave { group: $group }';
}
