import 'dart:developer';

import 'package:client/application/group/group.dart';
import 'package:client/application/meeting/meeting_bloc.dart';
import 'package:client/application/meeting/meeting_event.dart';
import 'package:client/application/meeting/meeting_state.dart';
import 'package:client/domain/meeting/meeting.dart';
import 'package:client/infrastructure/group/group_repository.dart';
import 'package:client/infrastructure/meeting/dto/meeting_mapper.dart';
import 'package:client/infrastructure/meeting/meeting_repository.dart';
import 'package:client/infrastructure/user/user_repository.dart';
import 'package:client/presentation/pages/common/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class MyScheduleListPage extends StatefulWidget {
  static const String routeName = 'user-meetings-list';

  const MyScheduleListPage({super.key});

  @override
  State<MyScheduleListPage> createState() => _MyScheduleListPageState();
}

class _MyScheduleListPageState extends State<MyScheduleListPage> {
  final _descriptionController = TextEditingController();
  final _timeController = TextEditingController();
  final _dateController = TextEditingController();
  final _locationController = TextEditingController();

  late int editedIndex;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _timeController.dispose();
    _dateController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => GroupBloc(
            userRepository: context.read<UserRepository>(),
            groupRepository: context.read<GroupRepository>())
          ..add(LoadGroups()),

        //
        child: BlocProvider(
            create: (context) => MeetingBloc(
                  meetingRepository: context.read<MeetingRepository>(),
                  userRepository: context.read<UserRepository>(),
                ),

            //
            child: BlocConsumer<MeetingBloc, MeetingState>(
                listener: (context, state) {
                  // on meeting update
                  if (state is MeetingUpdated) {
                    showSuccess(context, 'Meeting updated');

                    context.read<GroupBloc>().add(LoadGroups());
                  }

                  // on meeting delete
                  else if (state is MeetingDeleted) {
                    showSuccess(context, 'Meeting deleted');

                    context.read<GroupBloc>().add(LoadGroups());
                  }

                  // on error
                  else if (state is MeetingOperationFailure) {
                    showFailure(context, state.error.failure.toString());
                  }
                },

                // body
                builder: (context, state) =>
                    //
                    Scaffold(
                        appBar: AppBar(
                          title: const Text('Schedules'),
                        ),
                        body: BlocBuilder<GroupBloc, GroupState>(
                            builder: (context, state) {
                          // got joined groups
                          if (state is GroupsFetchSuccess) {
                            final groups = state.joinedGroups;
                            final meetings = [];

                            final meetingToGroupMap = {};

                            for (var group in groups) {
                              for (var meeting in group.meetings) {
                                meetings.add(meeting);
                                meetingToGroupMap[meeting] = group;
                              }
                            }

                            return ListView.builder(
                              itemCount: meetings.length,
                              itemBuilder: (context, index) {
                                final schedule = meetings[index];

                                return Dismissible(
                                    key: Key(schedule.description),
                                    direction: DismissDirection.endToStart,
                                    onDismissed: (direction) {
                                      if (direction ==
                                          DismissDirection.endToStart) {
                                        // deleteSchedule(index);
                                      }
                                    },
                                    background: Container(
                                      alignment: Alignment.centerRight,
                                      padding:
                                          const EdgeInsets.only(right: 16.0),
                                      color: Colors.red,
                                      child: const Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Card(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 16.0, vertical: 8.0),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: ListTile(
                                            // description
                                            title: Text(
                                              schedule.description,
                                              style:
                                                  const TextStyle(fontSize: 18),
                                            ),
                                            subtitle: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                //
                                                // time
                                                const SizedBox(height: 4.0),
                                                Row(
                                                  children: [
                                                    Row(children: [
                                                      const Icon(
                                                        Icons.schedule,
                                                        size: 14,
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        schedule.time,
                                                        style: const TextStyle(
                                                            fontSize: 16),
                                                      ),
                                                    ]),
                                                  ],
                                                ),

                                                //
                                                // date
                                                const SizedBox(height: 4.0),
                                                Row(
                                                  children: [
                                                    Row(children: [
                                                      const Icon(
                                                        Icons.calendar_today,
                                                        size: 14,
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        schedule.date,
                                                        style: const TextStyle(
                                                            fontSize: 16),
                                                      ),
                                                    ]),
                                                  ],
                                                ),

                                                //
                                                // Location
                                                const SizedBox(height: 4.0),
                                                Row(children: [
                                                  const Icon(
                                                    Icons.location_on,
                                                    size: 14,
                                                  ),
                                                  const SizedBox(width: 5),
                                                  Text(
                                                    schedule.location,
                                                    style: const TextStyle(
                                                        fontSize: 16),
                                                  )
                                                ]),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ));
                              },
                            );
                          }
                          return const Center(
                              child: CircularProgressIndicator());
                        })))));
  }
}
