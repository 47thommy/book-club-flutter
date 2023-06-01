import 'dart:developer';

import 'package:client/application/group/group.dart';
import 'package:client/application/poll/poll.dart';
import 'package:client/domain/group/group.dart';
import 'package:client/domain/role/user_permission_validator.dart';
import 'package:client/infrastructure/group/dto/group_mapper.dart';

import 'package:client/infrastructure/group/group_repository.dart';
import 'package:client/infrastructure/poll/dto/poll_dto.dart';
import 'package:client/infrastructure/poll/poll_repository.dart';
import 'package:client/infrastructure/user/user_repository.dart';
import 'package:client/presentation/pages/common/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polls/flutter_polls.dart';
import 'package:go_router/go_router.dart';

import '../../../infrastructure/group/dto/group_dto.dart';

class PollsList extends StatefulWidget {
  static const routeName = 'polls';

  final int groupId;

  const PollsList(this.groupId, {super.key});

  @override
  State<PollsList> createState() => _PollsListState();
}

class _PollsListState extends State<PollsList> {
  Offset _tapPosition = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => PollBloc(
            pollRepository: context.read<PollRepository>(),
            userRepository: context.read<UserRepository>(),
            groupRepository: context.read<GroupRepository>()),

        //
        // body
        child: BlocConsumer<PollBloc, PollState>(listener: (context, state) {
          // on poll create
          if (state is PollCreated) {
            showSuccess(context, 'Poll created');
            context.read<GroupBloc>().add(LoadGroupDetail(widget.groupId));
          }

          // on poll create
          else if (state is PollDeleted) {
            showSuccess(context, 'Poll deleted');
            context.pop();
            context.read<GroupBloc>().add(LoadGroupDetail(widget.groupId));
          }

          // on error
          else if (state is PollOperationFailure) {
            showFailure(context, state.error.failure.toString());
          }
        },

            //
            // widget
            builder: (context, state) {
          return BlocProvider(
              create: (context) => GroupBloc(
                  userRepository: context.read<UserRepository>(),
                  groupRepository: context.read<GroupRepository>())
                ..add(LoadGroupDetail(widget.groupId)),

              //
              //
              child: Scaffold(
                  appBar: AppBar(title: const Text('Poll')),
                  body: Padding(
                      padding: const EdgeInsets.all(15),
                      child: BlocBuilder<GroupBloc, GroupState>(
                          builder: (context, state) {
                        //
                        //
                        if (state is GroupDetailLoaded) {
                          return SingleChildScrollView(
                              child: Column(
                                  children: state.group.polls
                                      .map((poll) => _buildPoll(
                                          context, poll, state.group))
                                      .toList()));
                        }

                        return const Center(child: CircularProgressIndicator());
                      }))));
        }));
  }

  Widget _buildPoll(BuildContext context, PollDto poll, GroupDto group) {
    return GestureDetector(
        onTapDown: (details) => _storePosition(details),
        onLongPress: () {
          _showPopupMenu(context, group.toGroup(), poll);
        },
        child: Padding(
            padding: const EdgeInsets.all(15),
            child: FlutterPolls(
              pollId: poll.id.toString(),
              // hasVoted: hasVoted.value,
              // userVotedOptionId: userVotedOptionId.value,
              onVoted: (PollOption pollOption, int newTotalVotes) async {
                await Future.delayed(const Duration(seconds: 1));

                /// If HTTP status is success, return true else false
                return true;
              },

              // pollEnded: days < 0,
              pollTitle: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  poll.question,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              pollOptions: _getPollOptions(context, poll),

              votedPercentageTextStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            )));
  }

  List<PollOption> _getPollOptions(BuildContext context, PollDto poll) {
    final options = <PollOption>[];

    var id = 0;
    for (var option in poll.options) {
      options.add(
        PollOption(
          id: id,
          title: Text(
            option,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          votes: 3,
        ),
      );
    }

    return options;
  }

  Future<void> _showPopupMenu(
      BuildContext context, Group group, PollDto poll) async {
    final user = context.read<UserRepository>().getLoggedInUserSync();

    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;

    await showMenu(
      context: context,
      position: RelativeRect.fromRect(
          _tapPosition & const Size(40, 40), // smaller rect, the touch area
          Offset.zero & overlay.size // Bigger rect, the entire screen
          ),
      items: [
        PopupMenuItem(
          onTap: () {},
          child: const Text("Retract vote"),
        ),
        if (user.hasPollDeletePermission(group))
          PopupMenuItem(
            onTap: () {
              context.read<PollBloc>().add(PollDelete(poll.id, group.id));
            },
            child: const Text("Delete poll"),
          ),
      ],
      elevation: 8.0,
    );
  }

  void _storePosition(TapDownDetails details) {
    _tapPosition = details.globalPosition;
  }
}
