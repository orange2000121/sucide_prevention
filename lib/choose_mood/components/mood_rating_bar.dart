import 'package:flutter/material.dart';
import 'package:sucide_prevention/utils.dart';

class MoodRatingBar extends StatefulWidget {
  final String title;
  final List colors;
  const MoodRatingBar({Key? key, required this.title, required this.colors}) : super(key: key);

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
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("resources/image/background/splash_background.png"), fit: BoxFit.cover)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(widget.title, style: ThemeText.titleStyle),
          const SizedBox(height: 40),
          Column(
            children: List<Widget>.generate(widget.colors.length, (idx) {
              int tempIdx = widget.colors.length - idx - 1;
              return InkWell(
                onTap: () {
                  setState(() {
                    rating = tempIdx;
                  });
                },
                child: Container(
                  width: 60,
                  height: 60,
                  color: rating >= tempIdx ? widget.colors[tempIdx] : Colors.grey,
                  alignment: Alignment.center,
                  child: Text('${tempIdx + 1}', style: const TextStyle(fontSize: 20)),
                ),
              );
            }),
          )
        ],
      ),
    );
  }
}
