import 'package:flutter/material.dart';
import 'package:sucide_prevention/choose_mood/doc/questions.dart';
import 'package:sucide_prevention/utils.dart';

class PositiveMood extends StatefulWidget {
  ///回傳正面情緒的所有選擇選項
  final Function(List pos) onAnswer;
  const PositiveMood({Key? key, required this.onAnswer}) : super(key: key);

  @override
  State<PositiveMood> createState() => _PositiveMoodState();
}

class _PositiveMoodState extends State<PositiveMood> {
  final TextStyle buttonTextStyle = const TextStyle(fontSize: 25);
  final Color chosenColor = const Color(0xff94C1C9);

  ///每個負面選項是否被選擇
  late List<bool> isPosItemSelected;

  List<String> getSelectedMood(isItemSelected, moodData) {
    List<String> selectedMood = [];
    for (int i = 0; i < isItemSelected.length; i++) {
      if (isItemSelected[i]) {
        selectedMood.add(moodData[i]);
      }
    }
    return selectedMood;
  }

  @override
  void initState() {
    super.initState();
    isPosItemSelected = List.generate(MoodDoc.moodData['positive'].length, (index) => false);
    widget.onAnswer(getSelectedMood(isPosItemSelected, MoodDoc.moodData['positive']));
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> negText = List.generate(MoodDoc.moodData['positive'].length, (index) {
      return Center(
          child: ElevatedButton(
        onPressed: () {
          setState(() {
            isPosItemSelected[index] = !isPosItemSelected[index];
            widget.onAnswer(getSelectedMood(isPosItemSelected, MoodDoc.moodData['positive']));
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: isPosItemSelected[index] ? chosenColor : Colors.transparent,
          foregroundColor: Colors.black,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
        ),
        child: Text(
          MoodDoc.moodData['positive'][index],
          style: ThemeText.buttonStyle,
        ),
      ));
    });
    return Column(
      children: [
        const Text('正面情緒', style: ThemeText.titleStyle),
        // const Padding(
        //   padding: EdgeInsets.all(8.0),
        //   child: Text('選擇對應情緒的詞語', style: ThemeText.subtitleStyle),
        // ),
        Expanded(
          child: GridView.count(
            crossAxisCount: 3,
            childAspectRatio: 1.5,
            children: negText,
          ),
        )
      ],
    );
  }
}
