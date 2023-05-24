import 'dart:io';

import 'package:flutter/material.dart';
import 'package:client/profile.dart';
import 'package:client/reading_list.dart';
import 'package:image_picker/image_picker.dart';
import 'clubDetail.dart';
import 'package:client/schedule.dart';

class HomePage extends StatelessWidget {
  static const String routeName = '/home';
  void navigateToReadingList(BuildContext context) {
    Navigator.pushNamed(context, ReadingListPage.routeName);
  }

  void navigateToProfile(BuildContext context) {
    Navigator.pushNamed(context, ProfilePage.routeName);
  }

  void navigateToSchedule(BuildContext context) {
    Navigator.pushNamed(context, ScheduleListPage.routeName);
  }

  final List<Map<String, String>> trendingClubs = [
    {
      'title': 'Bookaholics',
      'picture': 'assets/trending1.png',
      'description': 'Book worms paradise',
    },
    {
      'title': 'The liberates',
      'picture': 'assets/trending2.png',
      'description': 'Book club in your town',
    },
    {
      'title': 'Novel',
      'picture': 'assets/trending3.png',
      'description': 'Club for readers and writes',
    },
    {
      'title': 'Novel',
      'picture': 'assets/trending3.png',
      'description': 'Club for readers and writes',
    },
  ];

  final List<Map<String, String>> joinedClubs = [
    {
      'title': 'Teen readers',
      'picture': 'assets/joined1.png',
      'description':
          'Lorem ipsum dolor, sit amet consectetur adi pis icing elit. Cupiditate inventore iusto vel rei ciend is voluptas quae tempore omn.',
    },
    {
      'title': 'Wise words',
      'picture': 'assets/joined2.png',
      'description':
          'Lorem ipsum dolor, sit amet consectetur adi pis icing elit. Cupiditate inventore iusto vel rei ciend is voluptas quae tempore omn.',
    },
    {
      'title': 'Teen readers',
      'picture': 'assets/joined1.png',
      'description':
          'Lorem ipsum dolor, sit amet consectetur adi pis icing elit. Cupiditate inventore iusto vel rei ciend is voluptas quae tempore omn.',
    },
    {
      'title': 'Wise words',
      'picture': 'assets/joined2.png',
      'description':
          'Lorem ipsum dolor, sit amet consectetur adi pis icing elit. Cupiditate inventore iusto vel rei ciend is voluptas quae tempore omn.',
    },
  ];

  List<Map<String, String>> createdClubs = [];

  void createClub(BuildContext context) async {
    final ImagePicker picker = ImagePicker();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        String clubName = '';
        String description = '';
        XFile? image;

        return Center(
          child: SingleChildScrollView(
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return AlertDialog(
                  title: const Text('Create Book Club'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        decoration:
                            const InputDecoration(labelText: 'Club Name'),
                        onChanged: (value) {
                          setState(() {
                            clubName = value;
                          });
                        },
                      ),
                      TextField(
                        decoration:
                            const InputDecoration(labelText: 'Description'),
                        onChanged: (value) {
                          setState(() {
                            description = value;
                          });
                        },
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          final XFile? pickedImage = await picker.pickImage(
                              source: ImageSource.gallery);
                          if (pickedImage != null) {
                            setState(() {
                              image = pickedImage;
                            });
                          }
                        },
                        child: const Text('Pick Image'),
                      ),
                      if (image != null)
                        Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Image.file(
                              File(image!.path),
                              width: 150,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  image = null;
                                });
                              },
                              icon: const Icon(Icons.cancel),
                              color: Colors.black,
                            ),
                          ],
                        ),
                    ],
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        if (clubName.isNotEmpty && description.isNotEmpty) {
                          Navigator.of(context).pop();

                          final newClub = {
                            'title': clubName,
                            'description': description,
                            'picture': image?.path ?? '',
                          };

                          createdClubs.add(newClub);
                          // leul new club

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Club created successfully.'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      },
                      child: const Text('Create'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancel'),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              Row(
                children: [
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(16.0, 12, 0, 12),
                      child: TextField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          labelText: 'Search',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      //leul search
                    },
                    child: const Text('Search'),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Trending Clubs',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 200,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: trendingClubs.map((club) {
                    return TrendingClubCard(
                      title: club['title']!,
                      picture: club['picture']!,
                      description: club['description']!,
                    );
                  }).toList(),
                ),
              ),
              const Padding(
                padding:
                    EdgeInsets.only(top: 16.0, right: 16, left: 16, bottom: 0),
                child: Text(
                  'Joined Clubs',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 1,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: joinedClubs.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: JoinedClubCard(
                        title: joinedClubs[index]['title']!,
                        picture: joinedClubs[index]['picture']!,
                        description: joinedClubs[index]['description']!,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
            ],
          ),
        ),
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
        currentIndex: 0,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          switch (index) {
            case 0:
              break;
            case 1:
              navigateToReadingList(context);
              break;
            case 2:
              navigateToSchedule(context);
              break;
            case 3:
              navigateToProfile(context);

              break;
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          createClub(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TrendingClubCard extends StatelessWidget {
  final String title;
  final String picture;
  final String description;

  const TrendingClubCard({
    Key? key,
    required this.title,
    required this.picture,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ClubDetailsPage(
              title: title,
              picture: picture,
              numberOfMembers: 10,
              memberRoles: const ["creator", "admin", "member"],
              isJoined: false,
            ),
          ),
        );
      },
      child: Container(
        width: 150,
        margin: const EdgeInsets.only(right: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                picture,
                width: 150,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4.0),
            Expanded(
              child: Text(
                description,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class JoinedClubCard extends StatelessWidget {
  final String title;
  final String picture;
  final String description;

  const JoinedClubCard({
    Key? key,
    required this.title,
    required this.picture,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ClubDetailsPage(
                title: title,
                picture: picture,
                numberOfMembers: 20,
                memberRoles: const ["creator", "admin", "member"],
                isJoined: true),
          ),
        );
      },
      child: Container(
        width: 150,
        margin: const EdgeInsets.only(right: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                picture,
                width: 150,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 20.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    description,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
