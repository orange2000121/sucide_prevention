import 'package:flutter/material.dart';
import 'package:sucide_prevention/utils.dart';

class PosNegMood extends StatefulWidget {
  const PosNegMood({Key? key}) : super(key: key);

  @override
  State<PosNegMood> createState() => _PosNegMoodState();
}

class _PosNegMoodState extends State<PosNegMood> {
  final TextStyle buttonTextStyle = const TextStyle(fontSize: 25);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Positive and Negative Mood'),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.85,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(18), color: const Color(0xffDCD9D9)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(onPressed: () {}, style: ThemeButton.ovalButton, child: Text('正面情緒', style: buttonTextStyle)),
                  ElevatedButton(onPressed: () {}, style: ThemeButton.ovalButton, child: Text('負面情緒', style: buttonTextStyle)),
                ],
              ),
            ),
            Text('選擇對應情緒的詞語', style: ThemeText.subtitleStyle),
            SizedBox()
          ],
        ),
      ),
    );
  }
}
