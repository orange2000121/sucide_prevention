import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RateBar extends StatefulWidget {
  const RateBar({Key? key}) : super(key: key);

  @override
  State<RateBar> createState() => _RateBarState();
}

class _RateBarState extends State<RateBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RateBar'),
      ),
      body: Center(
          child: RatingBar(
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
      )),
    );
  }
}
