import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ReadingListForm extends StatefulWidget {
  @override
  _ReadingListFormState createState() => _ReadingListFormState();
}

class _ReadingListFormState extends State<ReadingListForm> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController genreController = TextEditingController();
  XFile? pickedImage;

  void _createReadingList() {
    // leul create  a reading list use the controllers to get the values of each field
    String title = titleController.text;
    String author = authorController.text;
    String description = descriptionController.text;
    String genre = genreController.text;
    XFile? pickedImage;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Reading list created successfully'),
      ),
    );

    Navigator.pop(context);
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
    genreController.dispose();
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
              controller: genreController,
              decoration: const InputDecoration(labelText: 'Genre'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                if (titleController.text.isEmpty ||
                    authorController.text.isEmpty ||
                    descriptionController.text.isEmpty ||
                    genreController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter all fields'),
                    ),
                  );
                  return;
                }
                _createReadingList();
              },
              child: const Text('Create Reading List'),
            ),
          ],
        ),
      ),
    );
  }
}
