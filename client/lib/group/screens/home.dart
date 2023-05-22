import 'package:flutter/material.dart';
import 'package:client/profile.dart';
import 'package:client/reading_list.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  static const String routeName = 'home';

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
              const Padding(
                padding: EdgeInsets.fromLTRB(16.0, 12, 16, 12),
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    labelText: 'Search',
                    border: OutlineInputBorder(),
                  ),
                ),
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
                padding: EdgeInsets.all(16.0),
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
                    return JoinedClubCard(
                      title: joinedClubs[index]['title']!,
                      picture: joinedClubs[index]['picture']!,
                      description: joinedClubs[index]['description']!,
                    );
                  },
                ),
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
              context.goNamed(ReadingListPage.routeName);
              break;
            case 2:
              break;
            case 3:
              context.goNamed(ProfilePage.routeName);

              break;
          }
        },
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
    return Container(
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
    return Container(
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
    );
  }
}
