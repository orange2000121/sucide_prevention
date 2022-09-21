import 'package:flutter/material.dart';
import 'package:sucide_prevention/choose_mood/doc/mood_data.dart';
import 'package:sucide_prevention/utils.dart';

class PosNegMood extends StatefulWidget {
  const PosNegMood({Key? key}) : super(key: key);

  @override
  State<PosNegMood> createState() => _PosNegMoodState();
}

class _PosNegMoodState extends State<PosNegMood> {
  final TextStyle buttonTextStyle = const TextStyle(fontSize: 25);
  bool isPositive = true;
  late List<bool> isPosItemSelected;
  late List<bool> isNegItemSelected;
  @override
  void initState() {
    super.initState();
    isPosItemSelected = List.generate(moodData['positive'].length, (index) => false);
    isNegItemSelected = List.generate(moodData['negative'].length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> posText = List.generate(moodData['positive'].length, (index) {
      return Center(
          child: ElevatedButton(
        onPressed: () {
          setState(() {
            isPosItemSelected[index] = !isPosItemSelected[index];
          });
        },
        style: ElevatedButton.styleFrom(
          primary: isPosItemSelected[index] ? const Color(0xffDDEBEB) : Colors.transparent,
          onPrimary: Colors.black,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
        ),
        child: Text(
          moodData['positive'][index],
          style: ThemeText.buttonStyle,
        ),
      ));
    });
    List<Widget> negText = List.generate(moodData['negative'].length, (index) {
      return Center(
          child: ElevatedButton(
        onPressed: () {
          setState(() {
            isNegItemSelected[index] = !isNegItemSelected[index];
          });
        },
        style: ElevatedButton.styleFrom(
          primary: isNegItemSelected[index] ? const Color(0xffDDEBEB) : Colors.transparent,
          onPrimary: Colors.black,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
        ),
        child: Text(
          moodData['negative'][index],
          style: ThemeText.buttonStyle,
        ),
      ));
    });
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('resources/image/background/splash_background.png'), fit: BoxFit.cover)),
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.keyboard_double_arrow_left, size: 40),
                  ),
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
                            style: ThemeButton.ovalButton,
                            child: Text('正面情緒', style: buttonTextStyle)),
                        ElevatedButton(
                            onPressed: () => setState(() {
                                  isPositive = false;
                                }),
                            style: ThemeButton.ovalButton,
                            child: Text('負面情緒', style: buttonTextStyle)),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10)
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
          ),
        ),
      ),
    );
  }
}
