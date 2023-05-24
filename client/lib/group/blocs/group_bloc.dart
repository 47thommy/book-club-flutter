import 'package:client/group/repository/group_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs.dart';

class GroupBloc extends Bloc<GroupEvent, GroupState> {
  final GroupRepository groupRepository;

  GroupBloc(this.groupRepository) : super(GroupLoading()) {
    on<GroupLoad>((event, emit) async {
      emit(GroupLoading());
      try {
        final groups = await groupRepository.fetchAll(event.authToken);
        final joinedGroups =
            await groupRepository.fetchJoinedGroups(event.authToken);
        emit(GroupsLoaded(groups, joinedGroups));
      } catch (error) {
        emit(GroupOperationFailure(error));
      }
    });

    on<GroupCreate>((event, emit) async {
      emit(GroupCreateInitiated());
      try {
        final group =
            await groupRepository.create(event.group, event.authToken);
        emit(GroupCreated(group));
      } catch (error) {
        emit(GroupOperationFailure(error));
      }
    });
  }
}
