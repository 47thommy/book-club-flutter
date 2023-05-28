import 'package:client/home.dart';
import 'package:client/profile.dart';
import 'package:client/schedule.dart';
import 'package:flutter/material.dart';

class ReadingListPage extends StatelessWidget {
  static const String routeName = '/readinglist';

  void navigateToProfile(BuildContext context) {
    Navigator.pushNamed(context, ProfilePage.routeName);
  }

  void navigateToHomePage(BuildContext context) {
    Navigator.pushNamed(context, HomePage.routeName);
  }

  void navigateToSchedule(BuildContext context) {
    Navigator.pushNamed(context, ScheduleListPage.routeName);
  }

  const ReadingListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reading Lists'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              'Recommended Reading Lists',
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            ReadingListSection(
              readingLists: [
                ReadingList(
                  title: 'Summer Reads',
                  books: [
                    Book(
                      pickedImage: "assets/joined1.png",
                      title: 'Mockingbird',
                      author: 'marshal mathers',
                      description: 'A classic novel set in the American South.',
                      pageCount: 336,
                      genre: 'Fiction',
                    ),
                    Book(
                      pickedImage: "assets/joined1.png",
                      title: '1984',
                      author: 'George washington',
                      description:
                          'A dystopian novel set in a totalitarian society.',
                      pageCount: 328,
                      genre: 'Fiction',
                    ),
                  ],
                ),
                ReadingList(
                  title: 'Winter Reads',
                  books: [
                    Book(
                      pickedImage: "assets/joined1.png",
                      title: 'Mockingbird',
                      author: 'marshal mathers',
                      description: 'A classic novel set in the American South.',
                      pageCount: 336,
                      genre: 'Fiction',
                    ),
                    Book(
                      pickedImage: "assets/joined1.png",
                      title: '1984',
                      author: 'George washington',
                      description:
                          'A dystopian novel set in a totalitarian society.',
                      pageCount: 328,
                      genre: 'Fiction',
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 32.0),
            Text(
              'Currently Reading',
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            ReadingListSection(
              readingLists: [
                ReadingList(
                  title: 'Sci-Fi books',
                  books: [
                    Book(
                      pickedImage: "assets/joined2.png",
                      title: 'Lorem',
                      author: 'ronaldo messi',
                      description: 'An epic science fiction novel.',
                      pageCount: 688,
                      genre: 'Science Fiction',
                    ),
                    Book(
                      pickedImage: "assets/joined2.png",
                      title: 'Foundation',
                      author: 'Isaac newton',
                      description:
                          'The first book in a popular science fiction series.',
                      pageCount: 320,
                      genre: 'Science Fiction',
                    ),
                  ],
                ),
                ReadingList(
                  title: 'horror books',
                  books: [
                    Book(
                      pickedImage: "assets/joined2.png",
                      title: 'Lorem',
                      author: 'ronaldo messi',
                      description: 'An epic science fiction novel.',
                      pageCount: 688,
                      genre: 'Science Fiction',
                    ),
                    Book(
                      pickedImage: "assets/joined2.png",
                      title: 'Foundation',
                      author: 'Isaac newton',
                      description:
                          'The first book in a popular science fiction series.',
                      pageCount: 320,
                      genre: 'Science Fiction',
                    ),
                  ],
                ),
                ReadingList(
                  title: 'commedy books',
                  books: [
                    Book(
                      pickedImage: "assets/joined2.png",
                      title: 'Lorem',
                      author: 'ronaldo messi',
                      description: 'An epic science fiction novel.',
                      pageCount: 688,
                      genre: 'Science Fiction',
                    ),
                    Book(
                      pickedImage: "assets/joined2.png",
                      title: 'Foundation',
                      author: 'Isaac newton',
                      description:
                          'The first book in a popular science fiction series.',
                      pageCount: 320,
                      genre: 'Science Fiction',
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ReadingListSection extends StatelessWidget {
  final List<ReadingList> readingLists;

  const ReadingListSection({
    Key? key,
    required this.readingLists,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16.0),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: readingLists.length,
          itemBuilder: (context, index) {
            final readingList = readingLists[index];
            return ReadingListTitle(readingList: readingList);
          },
        ),
      ],
    );
  }
}

class ReadingListTitle extends StatefulWidget {
  final ReadingList readingList;

  const ReadingListTitle({
    Key? key,
    required this.readingList,
  }) : super(key: key);

  @override
  _ReadingListTitleState createState() => _ReadingListTitleState();
}

class _ReadingListTitleState extends State<ReadingListTitle> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: Card(
            elevation: 3.0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                onTap: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
                title: Text(
                  widget.readingList.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        if (isExpanded)
          Column(
            children: [
              for (var book in widget.readingList.books)
                ListTile(
                  leading: Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.shade200,
                    ),
                    child: book.pickedImage != null
                        ? Image.asset(
                            book.pickedImage!,
                            fit: BoxFit.cover,
                          )
                        : const Icon(Icons.book),
                  ),
                  title: Text(book.title),
                  subtitle: Text(book.author),
                ),
            ],
          ),
      ],
    );
  }
}

class ReadingList {
  final String title;
  final List<Book> books;

  ReadingList({
    required this.title,
    required this.books,
  });
}

class Book {
  final String? pickedImage;
  final String title;
  final String author;
  final String description;
  final int pageCount;
  final String genre;

  Book({
    this.pickedImage,
    required this.title,
    required this.author,
    required this.description,
    required this.pageCount,
    required this.genre,
  });
}
