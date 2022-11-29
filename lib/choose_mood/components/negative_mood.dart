import 'package:flutter/material.dart';
import 'package:sucide_prevention/choose_mood/doc/questions.dart';
import 'package:sucide_prevention/utils.dart';

class NegativeMood extends StatefulWidget {
  ///回傳正面情緒與負面情緒的所有選擇選項
  final Function(List neg) onAnswer;
  const NegativeMood({Key? key, required this.onAnswer}) : super(key: key);

  @override
  State<NegativeMood> createState() => _NegativeMoodState();
}

class _NegativeMoodState extends State<NegativeMood> {
  final TextStyle buttonTextStyle = const TextStyle(fontSize: 25);
  final Color chosenColor = const Color(0xff94C1C9);
  bool isPositive = true;

  ///每個負面選項是否被選擇
  late List<bool> isNegItemSelected;

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
    isNegItemSelected = List.generate(MoodDoc.moodData['negative'].length, (index) => false);
    widget.onAnswer(getSelectedMood(isNegItemSelected, MoodDoc.moodData['negative']));
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> negText = List.generate(MoodDoc.moodData['negative'].length, (index) {
      return Center(
          child: ElevatedButton(
        onPressed: () {
          setState(() {
            isNegItemSelected[index] = !isNegItemSelected[index];
            widget.onAnswer(getSelectedMood(isNegItemSelected, MoodDoc.moodData['negative']));
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: isNegItemSelected[index] ? chosenColor : Colors.transparent,
          foregroundColor: Colors.black,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
        ),
        child: Text(
          MoodDoc.moodData['negative'][index],
          style: ThemeText.buttonStyle,
        ),
      ));
    });
    return Column(
      children: [
        const Text('負面情緒', style: ThemeText.titleStyle),
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
