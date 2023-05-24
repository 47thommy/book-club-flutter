import 'package:flutter/material.dart';
import 'package:client/profile.dart';
import 'package:client/reading_list.dart';
import 'login/login_page.dart';
import 'home.dart';
import 'schedule.dart';

void main() {
  runApp(const BookClubApp());
}

class BookClubApp extends StatelessWidget {
  const BookClubApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Book Club',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
      routes: {
        ReadingListPage.routeName: (context) => ReadingListPage(),
        LoginPage.routeName: (context) => const LoginPage(),
        HomePage.routeName: (context) => HomePage(),
        ProfilePage.routeName: (context) => ProfilePage(),
        ScheduleListPage.routeName: (context) => ScheduleListPage()
      },
    );
  }
}
