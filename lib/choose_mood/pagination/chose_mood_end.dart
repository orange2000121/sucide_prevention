import 'package:flutter/material.dart';
import 'package:sucide_prevention/home/home_page.dart';
import 'package:sucide_prevention/splash_page.dart';

class ChoseMoodEnd extends StatefulWidget {
  const ChoseMoodEnd({super.key});

  @override
  State<ChoseMoodEnd> createState() => _ChoseMoodEndState();
}

class _ChoseMoodEndState extends State<ChoseMoodEnd> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(const Duration(seconds: 1)), //畫面持續時間
      builder: (context, AsyncSnapshot snapshot) {
        // Loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SplashPage(photoPath: "resources/image/chose_mood_end.png");
        }
        // Main
        else {
          return const HomePage();
        }
      },
    );
  }
}
