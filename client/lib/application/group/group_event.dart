import 'package:client/domain/groups/group_dto.dart';
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
  final int group;

  const LoadGroupDetail(this.group);

  @override
  List<Object?> get props => [group];

  @override
  String toString() => 'Group load { group: $group }';
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
