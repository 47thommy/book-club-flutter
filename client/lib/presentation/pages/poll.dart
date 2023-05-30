import 'package:flutter/material.dart';

class PollsPage extends StatefulWidget {
  const PollsPage({super.key});

  @override
  _PollsPageState createState() => _PollsPageState();
}

class _PollsPageState extends State<PollsPage> {
  List<Poll> polls = [
    Poll(
      question: 'What is your favorite color?',
      options: ['black', 'Blue', 'Green', 'Yellow'],
      votes: [30, 15, 5, 7],
    ),
    Poll(
      question: 'Which programming language do you prefer?',
      options: ['Java', 'Python', 'JavaScript', 'C++'],
      votes: [10, 15, 20, 8],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Polls'),
      ),
      body: ListView.builder(
        itemCount: polls.length,
        itemBuilder: (context, index) {
          return PollCard(poll: polls[index]);
        },
      ),
    );
  }
}

class Poll {
  final String question;
  final List<String> options;
  final List<int> votes;

  Poll({
    required this.question,
    required this.options,
    required this.votes,
  });
}

class PollCard extends StatefulWidget {
  final Poll poll;

  const PollCard({Key? key, required this.poll}) : super(key: key);

  @override
  _PollCardState createState() => _PollCardState();
}

class _PollCardState extends State<PollCard> {
  int? selectedOptionIndex;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              widget.poll.question,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            Column(
              children: List.generate(widget.poll.options.length, (index) {
                final option = widget.poll.options[index];
                final votes = widget.poll.votes[index];
                final totalVotes = widget.poll.votes.reduce((a, b) => a + b);
                final percentage = totalVotes > 0 ? votes / totalVotes : 0.0;

                return Option(
                  option: option,
                  votes: votes,
                  percentage: percentage,
                  isSelected: selectedOptionIndex == index,
                  onTap: () {
                    setState(() {
                      if (selectedOptionIndex == index) {
                        widget.poll.votes[index] -= 1;
                        selectedOptionIndex = null;
                      } else {
                        if (selectedOptionIndex != null) {
                          widget.poll.votes[selectedOptionIndex!] -= 1;
                        }

                        widget.poll.votes[index] += 1;
                        selectedOptionIndex = index;
                      }
                    });
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class Option extends StatelessWidget {
  final String option;
  final int votes;
  final double percentage;
  final bool isSelected;
  final VoidCallback onTap;

  const Option({
    Key? key,
    required this.option,
    required this.votes,
    required this.percentage,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = Colors.green;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: isSelected ? Colors.grey[300] : Colors.grey[200],
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: color.withOpacity(0.3),
                    blurRadius: 8.0,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              option,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              '$votes Votes',
              style: TextStyle(
                fontSize: 14.0,
                color: color,
              ),
            ),
            const SizedBox(height: 8.0),
            LinearProgressIndicator(
              value: percentage,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ],
        ),
      ),
    );
  }
}
