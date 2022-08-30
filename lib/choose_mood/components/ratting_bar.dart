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
    return RatingBar(
      initialRating: 0,
      direction: Axis.horizontal,
      allowHalfRating: false,
      itemCount: 5,
      ratingWidget: RatingWidget(
        full: const Icon(Icons.star, color: Colors.amber),
        half: const Icon(Icons.star_half, color: Colors.amber),
        empty: const Icon(Icons.star_border, color: Colors.amber),
      ),
      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
      onRatingUpdate: (rating) {
        debugPrint('Rating is $rating');
      },
    );
  }
}
