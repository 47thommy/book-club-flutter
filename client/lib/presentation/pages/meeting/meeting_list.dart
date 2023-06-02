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

class Schedule {
  final String description;
  final TimeOfDay time;
  final String location;

  Schedule({
    required this.description,
    required this.time,
    required this.location,
  });
}

class ScheduleListPage extends StatefulWidget {
  static const String routeName = 'meetings-list';

  final int groupId;

  const ScheduleListPage(this.groupId, {super.key});

  @override
  State<ScheduleListPage> createState() => _ScheduleListPageState();
}

class _ScheduleListPageState extends State<ScheduleListPage> {
  var _isEditing = false;
  final _descriptionController = TextEditingController();
  final _timeController = TextEditingController();
  final _dateController = TextEditingController();
  final _locationController = TextEditingController();
  late TimeOfDay selectedTime;
  late DateTime _selectedDate;
  late int editedIndex;

  @override
  void initState() {
    super.initState();
    selectedTime = TimeOfDay.now();
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _timeController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void startEditing(Meeting meeting, int index) {
    setState(() {
      _isEditing = true;
      editedIndex = index;
      _descriptionController.text = meeting.description;
      selectedTime = _tryParse(meeting.time);
      _locationController.text = meeting.location;
    });
  }

  TimeOfDay _tryParse(String time) {
    try {
      final hour = int.tryParse(time.split(":")[0]);
      final minute = int.tryParse(time.split(":")[1].split(" ")[0]);
      return TimeOfDay(hour: hour!, minute: minute!);
    } catch (_) {
      return TimeOfDay.now();
    }
  }

  void saveEditedSchedule(BuildContext context, Meeting meeting) {
    final updatedMeeting = Meeting(
        id: meeting.id,
        description: _descriptionController.text,
        date: _dateController.text,
        location: _locationController.text,
        time: _tryParse(_timeController.text).format(context));

    context
        .read<MeetingBloc>()
        .add(MeetingUpdate(updatedMeeting, widget.groupId));
  }

  void deleteSchedule(int index) {
    setState(() {
      // schedules.removeAt(index);
    });
  }

  Future<void> pickTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (pickedTime != null) {
      setState(() {
        selectedTime = pickedTime;
        _timeController.text = selectedTime.format(context);
      });
    }
  }

  Future<void> _selectDate() async {
    final selectedTime = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      initialDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (selectedTime != null) {
      setState(() {
        _selectedDate = selectedTime;
        _dateController.text = selectedTime.toLocal().toString().split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => GroupBloc(
            userRepository: context.read<UserRepository>(),
            groupRepository: context.read<GroupRepository>())
          ..add(LoadGroupDetail(widget.groupId)),

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
                    setState(() {
                      _isEditing = false;
                    });
                    context
                        .read<GroupBloc>()
                        .add(LoadGroupDetail(widget.groupId));
                  }

                  // on meeting delete
                  else if (state is MeetingDeleted) {
                    showSuccess(context, 'Meeting deleted');
                    context
                        .read<GroupBloc>()
                        .add(LoadGroupDetail(widget.groupId));
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
                          if (state is GroupDetailLoaded) {
                            return ListView.builder(
                              itemCount: state.group.meetings.length,
                              itemBuilder: (context, index) {
                                final schedule = state.group.meetings[index];

                                return Dismissible(
                                    key: Key(schedule.description),
                                    direction: DismissDirection.endToStart,
                                    onDismissed: (direction) {
                                      if (direction ==
                                          DismissDirection.endToStart) {
                                        deleteSchedule(index);
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
                                            title: _isEditing &&
                                                    editedIndex == index
                                                ? TextField(
                                                    controller:
                                                        _descriptionController,
                                                    decoration:
                                                        const InputDecoration(
                                                      labelText: 'Description',
                                                    ),
                                                  )
                                                : Text(
                                                    schedule.description,
                                                    style: const TextStyle(
                                                        fontSize: 18),
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
                                                    if (_isEditing &&
                                                        editedIndex == index)
                                                      Expanded(
                                                        child: TextField(
                                                          controller:
                                                              _timeController,
                                                          readOnly: true,
                                                          onTap: pickTime,
                                                          decoration:
                                                              const InputDecoration(
                                                            labelText: 'Time',
                                                            suffixIcon: Icon(
                                                                Icons.schedule),
                                                          ),
                                                        ),
                                                      )
                                                    else
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
                                                          style:
                                                              const TextStyle(
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
                                                    if (_isEditing &&
                                                        editedIndex == index)
                                                      Expanded(
                                                        child: TextField(
                                                          controller:
                                                              _dateController,
                                                          readOnly: true,
                                                          onTap: _selectDate,
                                                          decoration:
                                                              const InputDecoration(
                                                            labelText: 'Date',
                                                            suffixIcon: Icon(Icons
                                                                .calendar_today),
                                                          ),
                                                        ),
                                                      )
                                                    else
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
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 16),
                                                        ),
                                                      ]),
                                                  ],
                                                ),

                                                //
                                                // Location
                                                const SizedBox(height: 4.0),
                                                _isEditing &&
                                                        editedIndex == index
                                                    ? TextField(
                                                        controller:
                                                            _locationController,
                                                        decoration:
                                                            const InputDecoration(
                                                          labelText: 'Location',
                                                        ),
                                                      )
                                                    : Row(children: [
                                                        const Icon(
                                                          Icons.location_on,
                                                          size: 14,
                                                        ),
                                                        const SizedBox(
                                                            width: 5),
                                                        Text(
                                                          schedule.location,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 16),
                                                        )
                                                      ]),
                                              ],
                                            ),
                                            trailing: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                if (_isEditing &&
                                                    editedIndex == index)
                                                  IconButton(
                                                    onPressed: () =>
                                                        saveEditedSchedule(
                                                            context,
                                                            schedule
                                                                .toMeeting()),
                                                    icon:
                                                        const Icon(Icons.check),
                                                  ),
                                                if (!_isEditing)
                                                  IconButton(
                                                    onPressed: () =>
                                                        startEditing(
                                                            schedule
                                                                .toMeeting(),
                                                            index),
                                                    icon:
                                                        const Icon(Icons.edit),
                                                  ),
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
