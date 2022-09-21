import 'package:flutter/material.dart';
import 'package:sucide_prevention/home/home_page.dart';
import 'package:sucide_prevention/splash_page.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(const Duration(seconds: 3)),
      builder: (context, AsyncSnapshot snapshot) {
        // Loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            home: SplashPage(),
          );
        }

        // Main
        else {
          return const MaterialApp(
            home: HomePage(),
          );
        }
      },
    );
  }
}
