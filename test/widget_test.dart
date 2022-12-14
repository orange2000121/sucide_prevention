// import 'package:flutter/material.dart';
// import 'package:sucide_prevention/choose_mood/components/used.dart';

// import 'package:flutter/material.dart';
// import 'package:sucide_prevention/choose_mood/components/chose_date.dart';
// import 'package:sucide_prevention/choose_mood/components/locations.dart';
// import 'package:sucide_prevention/choose_mood/components/mood_rating_bar.dart';
// import 'package:sucide_prevention/choose_mood/components/button_options.dart';
// import 'package:sucide_prevention/choose_mood/components/positive_negative_mood.dart';
// import 'package:sucide_prevention/choose_mood/components/short_answer.dart';
// import 'package:sucide_prevention/choose_mood/components/used.dart';
// import 'package:sucide_prevention/choose_mood/components/wheel_chose.dart';
// import 'package:sucide_prevention/choose_mood/doc/questions.dart';

// import 'package:sucide_prevention/utils.dart';

// void main() {
//   runApp(MaterialApp(
//     home: Scaffold(
//       body: MoodHome(),
//       bottomNavigationBar: BottomNavigationBar(
//         onTap: (value) => setState(() => currentIndex = value),
//         currentIndex: currentIndex,
//         backgroundColor: const Color(0xFFD6DCDB),
//         items: [
//           BottomNavigationBarItem(
//               icon: BottomButton(
//                 imageName: 'resources/image/button/satisfaction rate.png',
//                 select: currentIndex,
//                 buttonIdx: 0,
//               ),
//               label: '心情紀錄'),
//           BottomNavigationBarItem(
//               icon: BottomButton(
//                 imageName: 'resources/image/button/mental.png',
//                 select: currentIndex,
//                 buttonIdx: 1,
//               ),
//               label: '緊急救生包'),
//           BottomNavigationBarItem(
//               icon: BottomButton(
//                 imageName: 'resources/image/button/user.png',
//                 select: currentIndex,
//                 buttonIdx: 2,
//               ),
//               label: '我的'),
//         ],
//       ),
//     ),
//   ));
// }

// class MoodHome extends StatefulWidget {
//   const MoodHome({Key? key}) : super(key: key);

//   @override
//   State<MoodHome> createState() => _MoodHomeState();
// }

// class _MoodHomeState extends State<MoodHome> {
//   /// 輸入問題標籤，輸出製作好的問卷頁面
//   ///
//   /// args : List<int> questions
//   ///
//   /// return : List<Widget> pages

//   List<Widget> questionPagination = [];
//   int pageIndex = 0;
//   List<Map> answers = [];
//   Map<String, List> answerTemp = {};
//   List<Widget> makeQuestionPagination(List questions, {List<Widget> lastQuestionPagination = const []}) {
//     questionPagination = [];
//     questionPagination.addAll(lastQuestionPagination);
//     for (int i = 0; i < questions.length; i++) {
//       Map question = MoodDoc.allQuestions[questions[i].toString()];
//       switch (question['type']) {
//         case "rattingBar":
//           questionPagination.add(MoodRatingBar(
//             title: question['title'],
//             colors: question['options'],
//             onAnswer: (String answer) {
//               answerTemp = {
//                 question['title']: [answer],
//               };
//             },
//           ));
//           break;
//         case "posNegMood":
//           questionPagination.add(PosNegMood(
//             onAnswer: (List pos, List neg) {
//               answerTemp = {
//                 '正面情緒': pos,
//                 '負面情緒': neg,
//               };
//             },
//           ));
//           break;
//         case "buttonOptipn":
//           questionPagination.add(ButtonOptions(
//             title: question['title'],
//             options: question['options'],
//             onAnswer: (option) {
//               answerTemp = {
//                 question['title']: [option],
//               };
//               setState(() {
//                 makeQuestionPagination(
//                   MoodDoc.questionOrder[option],
//                   lastQuestionPagination: questionPagination.sublist(0, ++pageIndex),
//                 );
//               });
//             },
//           ));
//           break;
//         case "date":
//           questionPagination.add(ChoseDate(
//             title: question['title'],
//             onAnswer: (date) {
//               print('date: $date');
//               answerTemp = {
//                 question['title']: [date]
//               };
//             },
//           ));
//           break;
//         case "location":
//           questionPagination.add(Locations(
//             title: question['title'],
//             onAnswer: (String location) {
//               answerTemp = {
//                 question['title']: [location]
//               };
//             },
//           ));
//           break;
//         case "optionWheel":
//           questionPagination.add(WheelChoose(
//             title: question['title'],
//             options: question['options'],
//             onAnswer: (List answer) {
//               answerTemp = {
//                 question['title']: answer,
//               };
//             },
//           ));
//           break;
//         case "form":
//           questionPagination.add(ShortAnswer(
//             title: question['title'],
//             onAnswer: (String answer) {
//               answerTemp = {
//                 question['title']: [answer],
//               };
//             },
//           ));
//           break;
//         case "using":
//           questionPagination.add(Used(
//             title: question['title'],
//             onAnswer: (Map answer) {
//               answerTemp = {
//                 question['title']: [answer],
//               };
//             },
//           ));
//           break;
//       }
//     }
//     print(questionPagination);
//     return questionPagination;
//   }

//   Widget moodHomeBottom() {
//     return questionPagination[pageIndex] is! ButtonOptions
//         ? pageIndex == questionPagination.length - 1 && pageIndex != 0
//             ? SendUp(onTap: () {
//                 print(answers);
//               })
//             : NextQuestion(onTap: () {
//                 if (pageIndex < questionPagination.length - 1) {
//                   setState(() {
//                     pageIndex++;
//                     answers.add(answerTemp);
//                     print(answerTemp);
//                   });
//                 }
//               })
//         : const SizedBox();
//   }

//   @override
//   void initState() {
//     super.initState();
//     makeQuestionPagination(MoodDoc.questionOrder['main']);
//   }

//   @override
//   Widget build(BuildContext context) {
//     double topPadding = MediaQuery.of(context).padding.top;
//     return Scaffold(
//       body: Container(
//           width: MediaQuery.of(context).size.width,
//           decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('resources/image/background/splash_background.png'), fit: BoxFit.cover)),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Padding(
//                 padding: EdgeInsets.only(top: topPadding),
//                 child: Row(children: [
//                   IconButton(
//                     iconSize: 40,
//                     onPressed: () {
//                       if (pageIndex == 0) {
//                         setState(() {
//                           makeQuestionPagination(MoodDoc.questionOrder['main']);
//                         });
//                       } else if (pageIndex < questionPagination.length) {
//                         setState(() {
//                           pageIndex--;
//                         });
//                       }
//                     },
//                     icon: const Icon(Icons.keyboard_double_arrow_left),
//                   )
//                 ]),
//               ),
//               Used(title: 'used', onAnswer: (a) {}),
//               SendUp(onTap: () {})
//             ],
//           )),
//     );
//   }
// }

// class NextQuestion extends StatelessWidget {
//   final VoidCallback onTap;
//   const NextQuestion({Key? key, required this.onTap}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           InkWell(
//             onTap: onTap,
//             child: Row(
//               children: const [
//                 Text('下ㄧ頁', style: ThemeText.buttonStyle),
//                 Icon(Icons.keyboard_double_arrow_right, size: 40),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class SendUp extends StatelessWidget {
//   final VoidCallback onTap;
//   const SendUp({Key? key, required this.onTap}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 10),
//       child: ElevatedButton(
//         onPressed: onTap,
//         style: ThemeButton.mainButton,
//         child: const Padding(
//           padding: EdgeInsets.fromLTRB(30, 7, 30, 7),
//           child: Text('送出', style: ThemeText.buttonStyle),
//         ),
//       ),
//     );
//   }
// }
