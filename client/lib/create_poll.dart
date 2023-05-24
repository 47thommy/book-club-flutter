import 'package:flutter/material.dart';

class PollForm extends StatefulWidget {
  @override
  _PollFormState createState() => _PollFormState();
}

class _PollFormState extends State<PollForm> {
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

  void createPoll() {
    final String question = questionController.text.trim();
    final List<String> options = optionControllers
        .map((controller) => controller.text.trim())
        .where((option) => option.isNotEmpty)
        .toList();
    if (question.isEmpty || options.length < 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a question and at least two options'),
        ),

        // // TODO:  use do your magic with the created poll
      );
      return;
    }

    questionController.clear();
    optionControllers.forEach((controller) => controller.clear());
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Poll created successfully'),
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
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
              onPressed: createPoll,
              child: const Text('Create Poll'),
            ),
          ],
        ),
      ),
    );
  }
}
