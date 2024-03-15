import 'package:flutter/material.dart';
import 'package:sucide_prevention/choose_mood/pagination/help_tell.dart';
import 'package:sucide_prevention/home/home_page.dart';
import 'package:sucide_prevention/splash_page.dart';

class ChoseMoodEnd extends StatefulWidget {
  final List<Map<String, dynamic>> answers;
  const ChoseMoodEnd({super.key, required this.answers});

  @override
  State<ChoseMoodEnd> createState() => _ChoseMoodEndState();
}

class _ChoseMoodEndState extends State<ChoseMoodEnd> {
  @override
  void initState() {
    super.initState();
  }

  void tell() async {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    showDialog(
        context: context,
        builder: ((context) => AlertDialog(
              title: Text("hello"),
            )));
  }

  @override
  Widget build(BuildContext context) {
    for (var answer in widget.answers) {
      if (answer.keys.first == "有哪種衝動想法?") {
        if (answer.values.first[0] == "自殺" || answer.values.first[0] == "自傷") {
          return const HelpTell();
        }
      }
    }
    return FutureBuilder(
      future: Future.delayed(const Duration(seconds: 1)), //畫面持續時間
      builder: (context, AsyncSnapshot snapshot) {
        print("status : ${snapshot.connectionState}");
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
