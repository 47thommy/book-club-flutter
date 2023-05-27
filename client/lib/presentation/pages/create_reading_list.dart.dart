import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ReadingListForm extends StatefulWidget {
  @override
  _ReadingListFormState createState() => _ReadingListFormState();
}

class _ReadingListFormState extends State<ReadingListForm> {
  final TextEditingController readingListTitleController =
      TextEditingController();
  List<Books> booksEntries = [];

  void createReadingList() {
    String title = readingListTitleController.text;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Reading list created successfully'),
      ),
    );

    Navigator.pop(context);
  }

  @override
  void dispose() {
    readingListTitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Reading List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextFormField(
              controller: readingListTitleController,
              decoration:
                  const InputDecoration(labelText: 'Reading List Title'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                if (readingListTitleController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter a reading list title'),
                    ),
                  );
                  return;
                }
                createReadingList();
              },
              child: const Text('Create Reading List'),
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () async {
                final newBooks = await showDialog<Books>(
                  context: context,
                  builder: (BuildContext context) {
                    return CreateBooks();
                  },
                );

                if (newBooks != null) {
                  setState(() {
                    booksEntries.add(newBooks);
                  });
                }
              },
              child: const Text('Add Books'),
            ),
            const SizedBox(height: 16.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: booksEntries
                  .map(
                    (books) => BooksTile(
                      books: books,
                      onDelete: () {
                        setState(() {
                          booksEntries.remove(books);
                        });
                      },
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class Books {
  XFile? pickedImage;
  String title;
  String author;
  String description;
  int pageCount;
  String genre;

  Books({
    this.pickedImage,
    required this.title,
    required this.author,
    required this.description,
    required this.pageCount,
    required this.genre,
  });
}

class CreateBooks extends StatefulWidget {
  @override
  _CreateBooksState createState() => _CreateBooksState();
}

class _CreateBooksState extends State<CreateBooks> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController pageCountController = TextEditingController();
  final TextEditingController genreController = TextEditingController();
  XFile? pickedImage;

  void addBooks() {
    String title = titleController.text;
    String author = authorController.text;
    String description = descriptionController.text;
    int pageCount = int.tryParse(pageCountController.text) ?? 0;
    String genre = genreController.text;

    Books newBooks = Books(
      pickedImage: pickedImage,
      title: title,
      author: author,
      description: description,
      pageCount: pageCount,
      genre: genre,
    );

    Navigator.pop(context, newBooks);
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        pickedImage = pickedFile;
      });
    }
  }

  void _cancelImageSelection() {
    setState(() {
      pickedImage = null;
    });
  }

  @override
  void dispose() {
    titleController.dispose();
    authorController.dispose();
    descriptionController.dispose();
    pageCountController.dispose();
    genreController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          shrinkWrap: true,
          children: [
            GestureDetector(
              onTap: pickImage,
              child: pickedImage == null
                  ? Container(
                      height: 200.0,
                      color: Colors.grey.shade200,
                      child: const Icon(Icons.add_photo_alternate, size: 50.0),
                    )
                  : Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Image.file(File(pickedImage!.path),
                            height: 200.0, fit: BoxFit.cover),
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.white),
                          onPressed: _cancelImageSelection,
                        ),
                      ],
                    ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: authorController,
              decoration: const InputDecoration(labelText: 'Author'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: pageCountController,
              decoration: const InputDecoration(labelText: 'Page Count'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: genreController,
              decoration: const InputDecoration(labelText: 'Genre'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                if (titleController.text.isEmpty ||
                    authorController.text.isEmpty ||
                    descriptionController.text.isEmpty ||
                    pageCountController.text.isEmpty ||
                    genreController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter all fields'),
                    ),
                  );
                  return;
                }
                addBooks();
              },
              child: const Text('Add Books Entry'),
            ),
          ],
        ),
      ),
    );
  }
}

class BooksTile extends StatelessWidget {
  final Books books;
  final VoidCallback onDelete;

  const BooksTile({required this.books, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 50.0,
        height: 50.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey.shade200,
        ),
        child: books.pickedImage != null
            ? Image.file(
                File(books.pickedImage!.path),
                fit: BoxFit.cover,
              )
            : const Icon(Icons.book),
      ),
      title: Text(books.title),
      subtitle: Text(books.author),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: onDelete,
      ),
    );
  }
}
