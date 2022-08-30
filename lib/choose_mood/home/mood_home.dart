import 'package:flutter/material.dart';
import 'package:sucide_prevention/utils.dart';

class MoodHome extends StatefulWidget {
  const MoodHome({Key? key}) : super(key: key);

  @override
  State<MoodHome> createState() => _MoodHomeState();
}

class _MoodHomeState extends State<MoodHome> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('resources/image/background/splash_background.png'), fit: BoxFit.cover)),
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.fromLTRB(0, 100, 0, 10), child: Text('選擇今天的心情狀況', style: ThemeText.titleStyle)),
            OptionButton(
                onPressed: () {
                  debugPrint('快樂');
                },
                title: '快樂'),
            OptionButton(
                onPressed: () {
                  debugPrint('痛苦');
                },
                title: '痛苦'),
            OptionButton(onPressed: () {}, title: '衝動想法'),
            OptionButton(onPressed: () {}, title: '酒精/毒品'),
            OptionButton(onPressed: () {}, title: '其他情緒'),
          ],
        ));
  }
}

class OptionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  const OptionButton({Key? key, required this.onPressed, required this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
      child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
              backgroundColor: MaterialStateProperty.all<Color>(const Color(0xffE0E0E0)),
              minimumSize: MaterialStateProperty.all<Size>(const Size.fromHeight(60)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)))),
          child: Text(title, style: ThemeText.subtitleStyle)),
    );
  }
}
