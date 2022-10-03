import 'package:flutter/material.dart';
import 'package:sucide_prevention/utils.dart';

class MoodRatingBar extends StatefulWidget {
  final String title;
  final List colors;

  /// 每次更改回答時，會呼叫此函式，回傳數值
  final Function(String) onAnswer;
  const MoodRatingBar({Key? key, required this.title, required this.colors, required this.onAnswer}) : super(key: key);

  @override
  State<MoodRatingBar> createState() => _MoodRatingBarState();
}

class _MoodRatingBarState extends State<MoodRatingBar> {
  List<Widget> barWidget = [];
  int rating = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(widget.title, style: ThemeText.titleStyle),
        Column(
          children: List<Widget>.generate(widget.colors.length, (idx) {
            int tempIdx = widget.colors.length - idx - 1;
            return InkWell(
              onTap: () {
                setState(() {
                  rating = tempIdx;
                  widget.onAnswer(rating.toString());
                });
              },
              child: Container(
                width: h * 0.1,
                height: h * 0.1,
                color: rating >= tempIdx ? widget.colors[tempIdx] : Colors.grey,
                alignment: Alignment.center,
                child: Text('${tempIdx + 1}', style: const TextStyle(fontSize: 20)),
              ),
            );
          }),
        ),
        const SizedBox(),
      ],
    );
  }
}
