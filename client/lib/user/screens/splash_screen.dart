import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  static const routeName = "splashscreen";

  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            Image.asset("assets/logo/logo.png"),
            const Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Book club",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                )),
          ])),
    );
  }
}
