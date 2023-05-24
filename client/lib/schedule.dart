import 'package:flutter/material.dart';
import 'package:client/profile.dart';
import 'package:client/reading_list.dart';
import 'home.dart';

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
  static const String routeName = '/schedule';

  @override
  _ScheduleListPageState createState() => _ScheduleListPageState();
}

void navigateToReadingList(BuildContext context) {
  Navigator.pushNamed(context, ReadingListPage.routeName);
}

void navigateToHomePage(BuildContext context) {
  Navigator.pushNamed(context, HomePage.routeName);
}

void navigateToProfile(BuildContext context) {
  Navigator.pushNamed(context, ProfilePage.routeName);
}

class _ScheduleListPageState extends State<ScheduleListPage> {
  final List<Schedule> schedules = [
    Schedule(
      description: 'Team Meeting',
      time: const TimeOfDay(hour: 10, minute: 0),
      location: 'Meeting Room 1',
    ),
    Schedule(
      description: 'Lunch Break',
      time: const TimeOfDay(hour: 12, minute: 30),
      location: 'Cafeteria',
    ),
    Schedule(
      description: 'Project Presentation',
      time: const TimeOfDay(hour: 15, minute: 0),
      location: 'Conference Room B',
    ),
  ];

  bool isEditing = false;
  TextEditingController descriptionController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  late TimeOfDay selectedTime;
  late int editedIndex;

  @override
  void initState() {
    super.initState();
    selectedTime = TimeOfDay.now();
  }

  @override
  void dispose() {
    descriptionController.dispose();
    timeController.dispose();
    locationController.dispose();
    super.dispose();
  }

  void startEditing(int index) {
    final schedule = schedules[index];
    setState(() {
      isEditing = true;
      editedIndex = index;
      descriptionController.text = schedule.description;
      selectedTime = schedule.time;
      locationController.text = schedule.location;
    });
  }

  void saveEditedSchedule() {
    final editedSchedule = Schedule(
      description: descriptionController.text,
      time: selectedTime,
      location: locationController.text,
    );

    setState(() {
      schedules[editedIndex] = editedSchedule;
      isEditing = false;
    });
  }

  void deleteSchedule(int index) {
    setState(() {
      schedules.removeAt(index);
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
        timeController.text = selectedTime.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedules'),
      ),
      body: ListView.builder(
        itemCount: schedules.length,
        itemBuilder: (context, index) {
          final schedule = schedules[index];
          return Dismissible(
            key: Key(schedule.description),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              if (direction == DismissDirection.endToStart) {
                deleteSchedule(index);
              }
            },
            background: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 16.0),
              color: Colors.red,
              child: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                margin:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: ListTile(
                  title: isEditing && editedIndex == index
                      ? TextField(
                          controller: descriptionController,
                          decoration: const InputDecoration(
                            labelText: 'Description',
                          ),
                        )
                      : Text(schedule.description),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4.0),
                      Row(
                        children: [
                          const Text('Time: '),
                          if (isEditing && editedIndex == index)
                            Expanded(
                              child: TextField(
                                controller: timeController,
                                readOnly: true,
                                onTap: pickTime,
                                decoration: const InputDecoration(
                                  labelText: 'Time',
                                  suffixIcon: Icon(Icons.schedule),
                                ),
                              ),
                            )
                          else
                            Text(schedule.time.format(context)),
                        ],
                      ),
                      const SizedBox(height: 4.0),
                      isEditing && editedIndex == index
                          ? TextField(
                              controller: locationController,
                              decoration: const InputDecoration(
                                labelText: 'Location',
                              ),
                            )
                          : Text('Location: ${schedule.location}'),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (isEditing && editedIndex == index)
                        IconButton(
                          onPressed: saveEditedSchedule,
                          icon: const Icon(Icons.check),
                        ),
                      if (!isEditing)
                        IconButton(
                          onPressed: () => startEditing(index),
                          icon: const Icon(Icons.edit),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            backgroundColor: Colors.black45,
            icon: Icon(Icons.people_alt_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.black45,
            icon: Icon(Icons.menu_book_rounded),
            label: 'Reading List',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.black45,
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.black45,
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: 2,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          switch (index) {
            case 0:
              navigateToHomePage(context);
              break;
            case 1:
              navigateToReadingList(context);
              break;
            case 2:
              break;
            case 3:
              navigateToProfile(context);

              break;
          }
        },
      ),
    );
  }
}
