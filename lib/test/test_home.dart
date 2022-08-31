import 'package:flutter/material.dart';
import 'package:sucide_prevention/choose_mood/components/mood_rating_bar.dart';
import 'package:sucide_prevention/choose_mood/pagination/positive_negative_mood.dart';
import 'package:sucide_prevention/test/rate.dart';

class TestHome extends StatefulWidget {
  const TestHome({Key? key}) : super(key: key);

  @override
  State<TestHome> createState() => _TestHomeState();
}

class _TestHomeState extends State<TestHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('test home')),
        body: GridView.count(
          crossAxisCount: 2,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RateBar()),
                );
              },
              child: const Text('Rate'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Scaffold(body: Center(child: MoodRatingBar()))),
                );
              },
              child: const Text('mood ratingbar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Scaffold(body: Center(child: PosNegMood()))),
                );
              },
              child: const Text('pos neg mood'),
            ),
          ],
        ));
  }
}
