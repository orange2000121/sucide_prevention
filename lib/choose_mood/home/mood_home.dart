import 'package:flutter/material.dart';
import 'package:sucide_prevention/choose_mood/components/mood_rating_bar.dart';
import 'package:sucide_prevention/choose_mood/pagination/button_options.dart';
import 'package:sucide_prevention/choose_mood/pagination/positive_negative_mood.dart';
import 'package:sucide_prevention/choose_mood/doc/questions.dart';

class MoodHome extends StatefulWidget {
  const MoodHome({Key? key}) : super(key: key);

  @override
  State<MoodHome> createState() => _MoodHomeState();
}

class _MoodHomeState extends State<MoodHome> {
  /// 輸入問題標籤，輸出製作好的問卷頁面
  ///
  /// args : List<int> questions
  ///
  /// return : List<Widget> pages

  List<Widget> questionPagination = [];

  List<Widget> makeQuestionPagination(List questions) {
    for (int i = 0; i < questions.length; i++) {
      Map question = MoodDoc.allQuestions[questions[i].toString()];
      switch (question['type']) {
        case "rattingBar":
          questionPagination.add(MoodRatingBar(
            title: question['title'],
            colors: question['options'],
          ));
          break;
        case "posNegMood":
          questionPagination.add(const PosNegMood());
          break;
        case "buttonOptipn":
          questionPagination.add(ButtonOptions(
            title: question['title'],
            options: question['options'],
            onPressed: (option) {},
          ));
          break;
      }
    }
    return questionPagination;
  }

  @override
  void initState() {
    super.initState();
    makeQuestionPagination(MoodDoc.questionOrder['衝動想法']);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('resources/image/background/splash_background.png'), fit: BoxFit.cover)),
        child: PageView.builder(
            itemCount: questionPagination.length,
            itemBuilder: (BuildContext context, int index) {
              return questionPagination[index];
            }));
  }
}
