import 'package:client/group/screens/group_details.dart';
import 'package:client/group/screens/groups_screen.dart';
import 'package:client/profile.dart';
import 'package:client/reading_list.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppScaffold extends StatefulWidget {
  const AppScaffold({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _calculateSelectedIndex(context),
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        onTap: onTap,
        items: const [
          BottomNavigationBarItem(
            backgroundColor: Colors.black45,
            icon: Icon(Icons.group),
            label: 'Groups',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.black45,
            icon: Icon(Icons.meeting_room),
            label: 'Meetings',
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
      ),
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final location = GoRouter.of(context).location;
    if (location.endsWith(HomePage.routeName)) {
      return 0;
    }
    if (location.endsWith(ReadingListPage.routeName)) {
      return 1;
    }
    if (location.endsWith(GroupDetailPage.routeName)) {
      return 2;
    }
    if (location.endsWith(ProfilePage.routeName)) {
      return 3;
    }
    return 0;
  }

  void onTap(int value) {
    switch (value) {
      case 0:
        return context.goNamed(HomePage.routeName);
      case 1:
        return context.goNamed(ReadingListPage.routeName);
      case 2:
        return context.goNamed(GroupDetailPage.routeName);
      case 3:
        return context.goNamed(ProfilePage.routeName);
      default:
        return context.goNamed(HomePage.routeName);
    }
  }
}
