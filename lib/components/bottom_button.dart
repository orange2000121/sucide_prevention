import 'package:flutter/material.dart';
import 'package:sucide_prevention/utils.dart';

class BottomButton extends StatefulWidget {
  const BottomButton({Key? key}) : super(key: key);

  @override
  State<BottomButton> createState() => _BottomButtonState();
}

class _BottomButtonState extends State<BottomButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  bool chooseMood = false;
  double buttonWidth = 60;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFFD6DCDB),
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                debugPrint('choose_mood: $chooseMood');
                chooseMood = true;
              });
            },
            style: ElevatedButton.styleFrom(primary: chooseMood ? Colors.white : Colors.transparent, shadowColor: Colors.transparent),
            child: Row(children: [
              Image.asset('resources/image/button/satisfaction rate.png', width: buttonWidth, height: buttonWidth),
              const SizedBox(width: 5),
              const Text('心情紀錄', style: ThemeText.bottomSheetButton),
            ]),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                debugPrint('choose_mood: $chooseMood');
                chooseMood = false;
              });
            },
            style: ElevatedButton.styleFrom(primary: chooseMood ? Colors.transparent : Colors.white, shadowColor: Colors.transparent),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Image.asset('resources/image/button/mental.png', width: buttonWidth, height: buttonWidth),
              const SizedBox(width: 5),
              const Text(
                '緊急救生包',
                style: ThemeText.bottomSheetButton,
              ),
            ]),
          ),
        ),
      ]),
    );
  }
}
