import 'package:client/reading_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class BookDescription extends StatelessWidget {
  final String title;
  final String genres;
  final String author;
  final String bookCover;
  final String publishDate;
  final String pageCount;
  final String description;

  const BookDescription({
    Key? key,
    required this.title,
    required this.genres,
    required this.author,
    required this.bookCover,
    required this.publishDate,
    required this.pageCount,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              height: height / 2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: Image.asset(
                  bookCover,
                  fit: BoxFit.cover,
                  width: 200,
                  height: 200,
                ),
              ),
            ),
            Container(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      author,
                    ),
                    Text(
                      publishDate,
                      style: TextStyle(fontSize: 13),
                    ),
                    Text(
                      genres,
                      style: TextStyle(fontSize: 13),
                    ),
                    Text(
                      pageCount,
                      style: TextStyle(fontSize: 13),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(5),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'SYNOPSIS',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(description, style: TextStyle(fontSize: 12))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
