import 'package:client/application/group/group.dart';
import 'package:client/application/meeting/meeting_bloc.dart';
import 'package:client/application/meeting/meeting_event.dart';
import 'package:client/application/meeting/meeting_state.dart';
import 'package:client/domain/group/group.dart';
import 'package:client/domain/meeting/meeting.dart';
import 'package:client/infrastructure/meeting/meeting_repository.dart';
import 'package:client/infrastructure/user/user_repository.dart';
import 'package:client/presentation/pages/common/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CreateScheduleForm extends StatefulWidget {
  static const routeName = 'meeting';

  final int groupId;

  const CreateScheduleForm(this.groupId, {super.key});

  @override
  State<CreateScheduleForm> createState() => _CreateScheduleFormState();
}

class _CreateScheduleFormState extends State<CreateScheduleForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  Future<void> _selectTime() async {
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime != null) {
      setState(() {
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
        _dateController.text = selectedTime.toLocal().toString().split(' ')[0];
      });
    }
  }

  void _createSchedule(BuildContext context) {
    final user = context.read<UserRepository>().getLoggedInUserSync();

    if (_formKey.currentState!.validate()) {
      final meeting = Meeting(
        id: -1,
        description: _descriptionController.text,
        location: _locationController.text,
        time: _timeController.text,
        date: _dateController.text,
      );

      context.read<MeetingBloc>().add(MeetingCreate(meeting, widget.groupId));
    }
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _timeController.dispose();
    _locationController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => MeetingBloc(
            meetingRepository: context.read<MeetingRepository>(),
            userRepository: context.read<UserRepository>()),

        //
        // body
        child: BlocConsumer<MeetingBloc, MeetingState>(
            listener: (context, state) {
              // on poll create
              if (state is MeetingCreated) {
                showSuccess(context, 'Meeting created');
                context.read<GroupBloc>().add(LoadGroupDetail(widget.groupId));
                context.pop();
              }

              // on error
              else if (state is MeetingOperationFailure) {
                showFailure(context, state.error.failure.toString());
              }
            },

            //
            // Screen
            builder: (context, state) => Scaffold(
                  appBar: AppBar(
                    title: const Text('Create Schedule'),
                  ),
                  body: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            controller: _descriptionController,
                            decoration:
                                const InputDecoration(labelText: 'Description'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a description';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16.0),
                          GestureDetector(
                            onTap: _selectTime,
                            child: AbsorbPointer(
                              child: TextFormField(
                                controller: _timeController,
                                decoration: const InputDecoration(
                                  labelText: 'Time',
                                  suffixIcon: Icon(Icons.arrow_drop_down),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please select a time';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          GestureDetector(
                            onTap: _selectDate,
                            child: AbsorbPointer(
                              child: TextFormField(
                                controller: _dateController,
                                decoration: const InputDecoration(
                                  labelText: 'Date',
                                  suffixIcon: Icon(Icons.arrow_drop_down),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please select a time';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          TextFormField(
                            controller: _locationController,
                            decoration:
                                const InputDecoration(labelText: 'Location'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a location';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16.0),
                          ElevatedButton(
                            onPressed: () => _createSchedule(context),
                            child: const Text('Create Schedule'),
                          ),
                        ],
                      ),
                    ),
                  ),
                )));
  }
}
