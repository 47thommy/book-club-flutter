import 'dart:developer';

import 'package:client/application/group/group.dart';
import 'package:client/application/poll/poll.dart';
import 'package:client/domain/poll/poll_form.dart';
import 'package:client/infrastructure/group/group_repository.dart';
import 'package:client/infrastructure/poll/poll_repository.dart';
import 'package:client/infrastructure/user/user_repository.dart';
import 'package:client/presentation/pages/common/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PollCreateScreen extends StatefulWidget {
  static const routeName = 'poll';

  final int groupId;

  const PollCreateScreen(this.groupId, {super.key});

  @override
  State<PollCreateScreen> createState() => _PollCreateScreenState();
}

class _PollCreateScreenState extends State<PollCreateScreen> {
  final TextEditingController questionController = TextEditingController();
  final List<TextEditingController> optionControllers = [];

  @override
  void dispose() {
    questionController.dispose();
    optionControllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

  void addOption() {
    setState(() {
      optionControllers.add(TextEditingController());
    });
  }

  void removeOption(int index) {
    setState(() {
      optionControllers.removeAt(index);
    });
  }

  void createPoll(BuildContext context) {
    final String question = questionController.text.trim();
    final List<String> options = optionControllers
        .map((controller) => controller.text.trim())
        .where((option) => option.isNotEmpty)
        .toList();

    if (question.isEmpty || options.length < 2) {
      showFailure(context, 'Please enter a question and at least two options');
      return;
    }

    final pollForm = PollForm(question: question, options: options);

    context.read<PollBloc>().add(PollCreate(pollForm, widget.groupId));

    questionController.clear();
    optionControllers.forEach((controller) => controller.clear());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => PollBloc(
            pollRepository: context.read<PollRepository>(),
            userRepository: context.read<UserRepository>(),
            groupRepository: context.read<GroupRepository>()),

        //
        // body
        child: BlocConsumer<PollBloc, PollState>(listener: ((context, state) {
          // on poll create
          if (state is PollCreated) {
            showSuccess(context, 'Poll created');
            context.read<GroupBloc>().add(LoadGroupDetail(widget.groupId));
            context.pop();
          }

          // on error
          else if (state is PollOperationFailure) {
            showFailure(context, state.error.failure.toString());
          }
        }),

            //
            // screen
            builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Create Poll'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: questionController,
                    decoration: const InputDecoration(
                      labelText: 'Question',
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    'Options',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: List.generate(
                          optionControllers.length,
                          (index) {
                            return Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: optionControllers[index],
                                    decoration: InputDecoration(
                                      labelText: 'Option ${index + 1}',
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.remove_circle),
                                  onPressed: () => removeOption(index),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  ElevatedButton(
                    onPressed: addOption,
                    child: const Text('Add Option'),
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () => createPoll(context),
                    child: const Text('Create Poll'),
                  ),
                ],
              ),
            ),
          );
        }));
  }
}

class PollUpdated {}
