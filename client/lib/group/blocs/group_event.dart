import 'package:client/group/models/group.dart';
import 'package:equatable/equatable.dart';

abstract class GroupEvent extends Equatable {
  const GroupEvent();
}

class GroupLoad extends GroupEvent {
  final String authToken;

  const GroupLoad(this.authToken);

  @override
  List<Object?> get props => [authToken];
}

class GroupCreate extends GroupEvent {
  final Group group;
  final String authToken;

  const GroupCreate(this.group, this.authToken);

  @override
  List<Object?> get props => [group, authToken];

  @override
  String toString() => 'Group created {id: ${group.id}, email: ${group.name}}';
}
