import 'package:flutter/material.dart';
import 'package:sucide_prevention/choose_mood/doc/questions.dart';
import 'package:sucide_prevention/utils.dart';

class PosNegMood extends StatefulWidget {
  ///回傳正面情緒與負面情緒的所有選擇選項
  final Function(List pos, List neg) onAnswer;
  const PosNegMood({Key? key, required this.onAnswer}) : super(key: key);

  @override
  State<PosNegMood> createState() => _PosNegMoodState();
}

class _PosNegMoodState extends State<PosNegMood> {
  final TextStyle buttonTextStyle = const TextStyle(fontSize: 25);
  final Color chosenColor = const Color(0xff94C1C9);
  bool isPositive = true;

  ///每個正面選項是否被選擇
  late List<bool> isPosItemSelected;

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
    isPosItemSelected = List.generate(MoodDoc.moodData['positive'].length, (index) => false);
    isNegItemSelected = List.generate(MoodDoc.moodData['negative'].length, (index) => false);
    widget.onAnswer(getSelectedMood(isPosItemSelected, MoodDoc.moodData['positive']), getSelectedMood(isNegItemSelected, MoodDoc.moodData['negative']));
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> posText = List.generate(MoodDoc.moodData['positive'].length, (index) {
      return Center(
          child: ElevatedButton(
        onPressed: () {
          setState(() {
            isPosItemSelected[index] = !isPosItemSelected[index];
            widget.onAnswer(getSelectedMood(isPosItemSelected, MoodDoc.moodData['positive']), getSelectedMood(isNegItemSelected, MoodDoc.moodData['negative']));
          });
        },
        style: ElevatedButton.styleFrom(
          primary: isPosItemSelected[index] ? chosenColor : Colors.transparent,
          onPrimary: Colors.black,
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
    List<Widget> negText = List.generate(MoodDoc.moodData['negative'].length, (index) {
      return Center(
          child: ElevatedButton(
        onPressed: () {
          setState(() {
            isNegItemSelected[index] = !isNegItemSelected[index];
          });
        },
        style: ElevatedButton.styleFrom(
          primary: isNegItemSelected[index] ? chosenColor : Colors.transparent,
          onPrimary: Colors.black,
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(18), color: const Color(0xffDCD9D9)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      onPressed: () => setState(() {
                            isPositive = true;
                          }),
                      style: isPositive ? ThemeButton.ovalButtonSelect : ThemeButton.ovalButtonUnselect,
                      child: Text('正面情緒', style: buttonTextStyle)),
                  ElevatedButton(
                      onPressed: () => setState(() {
                            isPositive = false;
                          }),
                      style: isPositive ? ThemeButton.ovalButtonUnselect : ThemeButton.ovalButtonSelect,
                      child: Text('負面情緒', style: buttonTextStyle)),
                ],
              ),
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('選擇對應情緒的詞語', style: ThemeText.subtitleStyle),
        ),
        Expanded(
          child: GridView.count(
            crossAxisCount: 3,
            childAspectRatio: 1.5,
            children: isPositive ? posText : negText,
          ),
        )
      ],
    );
  }
}
