import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MoodRatingBar extends StatefulWidget {
  const MoodRatingBar({Key? key}) : super(key: key);

  @override
  State<MoodRatingBar> createState() => _MoodRatingBarState();
}

class _MoodRatingBarState extends State<MoodRatingBar> {
  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      direction: Axis.vertical,
      initialRating: 0,
      itemCount: 5,
      unratedColor: Color.fromARGB(255, 108, 98, 200),
      itemBuilder: (context, index) {
        switch (index) {
          case 0:
            return Container(
              alignment: Alignment.center,
              width: 60,
              height: 60,
              color: const Color(0xffFFB5B5),
              child: const Text('1'),
            );
          case 1:
            return Container(
              alignment: Alignment.center,
              width: 60,
              height: 60,
              color: const Color(0xffFF9797),
              child: const Text('2'),
            );
          case 2:
            return Container(
              alignment: Alignment.center,
              width: 60,
              height: 60,
              color: const Color(0xffFF7575),
              child: const Text('3'),
            );
          case 3:
            return Container(
              alignment: Alignment.center,
              width: 60,
              height: 60,
              color: const Color(0xffFF5151),
              child: const Text('4'),
            );
          case 4:
            return Container(
              alignment: Alignment.center,
              width: 60,
              height: 60,
              color: const Color(0xffFF2D2D),
              child: const Text('5'),
            );
          default:
            return const Icon(Icons.h_mobiledata);
        }
      },
      onRatingUpdate: (rating) {
        print(rating);
      },
    );
  }
}
