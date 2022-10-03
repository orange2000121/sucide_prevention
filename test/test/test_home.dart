// import 'package:flutter/material.dart';
// import 'package:sucide_prevention/choose_mood/components/mood_rating_bar.dart';
// import 'package:sucide_prevention/choose_mood/components/button_options.dart';
// import 'package:sucide_prevention/choose_mood/components/positive_negative_mood.dart';

// class TestHome extends StatefulWidget {
//   const TestHome({Key? key}) : super(key: key);

//   @override
//   State<TestHome> createState() => _TestHomeState();
// }

// class _TestHomeState extends State<TestHome> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(title: const Text('test home')),
//         body: GridView.count(
//           crossAxisCount: 2,
//           children: <Widget>[
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => const Scaffold(
//                               body: Center(
//                                   child: MoodRatingBar(title: '今天心情如何', colors: [
//                             Color(0xffFFB5B5),
//                             Color(0xffFF9797),
//                             Color(0xffFF7575),
//                             Color(0xffFF5151),
//                             Color(0xffFF2D2D),
//                           ])))),
//                 );
//               },
//               child: const Text('mood ratingbar'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const Scaffold(body: Center(child: PosNegMood()))),
//                 );
//               },
//               child: const Text('pos neg mood'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => ButtonOptions(
//                             title: 'test',
//                             options: const ['tes1', 'test2'],
//                             onPressed: (String option) {},
//                           )),
//                 );
//               },
//               child: const Text('pos neg mood'),
//             ),
//           ],
//         ));
//   }
// }
