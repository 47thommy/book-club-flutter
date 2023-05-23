import 'package:flutter/material.dart';
import 'package:client/group/screens/home.dart';
import 'package:client/profile.dart';
import 'package:go_router/go_router.dart';

class ReadingListPage extends StatelessWidget {
  static const String routeName = 'reading-list';

  const ReadingListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reading List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Recommended Books',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              height: 250,
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: recommendedBooks.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 120,
                    child: Card(
                      child: ListTile(
                        title: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    recommendedBooks[index].title,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(recommendedBooks[index].author),
                                  Text(recommendedBooks[index].genre),
                                  Text(recommendedBooks[index].description),
                                ],
                              ),
                            ),
                            Image.asset(
                              recommendedBooks[index].image,
                              width: 80,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Currently Reading',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.85,
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: currentlyReadingBooks.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 120,
                    child: Card(
                      child: ListTile(
                        leading: Image.asset(
                          currentlyReadingBooks[index].image,
                          width: 80,
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              currentlyReadingBooks[index].title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(currentlyReadingBooks[index].author),
                            Text(currentlyReadingBooks[index].genre),
                            Text(currentlyReadingBooks[index].description),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
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
        currentIndex: 1,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          switch (index) {
            case 0:
              context.goNamed(HomePage.routeName);
              break;
            case 1:
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

class Book {
  final String image;
  final String title;
  final String author;
  final String description;
  final String genre;

  Book({
    required this.image,
    required this.title,
    required this.author,
    required this.description,
    required this.genre,
  });
}

List<Book> recommendedBooks = [
  Book(
    image: 'assets/trending1.png',
    title: 'Book 1',
    author: 'Author 1',
    genre: 'Genre 1',
    description: 'Description of Book 1',
  ),
  Book(
    image: 'assets/trending2.png',
    title: 'Book 2',
    author: 'Author 2',
    genre: 'Genre 2',
    description: 'Description of Book 2',
  ),
];

List<Book> currentlyReadingBooks = [
  Book(
    image: 'assets/joined1.png',
    title: 'Book 3',
    author: 'Author 3',
    genre: 'Genre 3',
    description: 'Description of Book 3',
  ),
  Book(
    image: 'assets/joined2.png',
    title: 'Book 4',
    author: 'Author 4',
    genre: 'Genre 4',
    description: 'Description of Book 4',
  ),
  Book(
    image: 'assets/joined1.png',
    title: 'Book 3',
    author: 'Author 3',
    genre: 'Genre 3',
    description: 'Description of Book 3',
  ),
  Book(
    image: 'assets/joined2.png',
    title: 'Book 4',
    author: 'Author 4',
    genre: 'Genre 4',
    description: 'Description of Book 4',
  ),
  Book(
    image: 'assets/joined1.png',
    title: 'Book 3',
    author: 'Author 3',
    genre: 'Genre 3',
    description: 'Description of Book 3',
  ),
  Book(
    image: 'assets/joined2.png',
    title: 'Book 4',
    author: 'Author 4',
    genre: 'Genre 4',
    description: 'Description of Book 4',
  ),
];
