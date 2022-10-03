import 'package:flutter/material.dart';
import 'package:sucide_prevention/utils.dart';

class ShortAnswer extends StatefulWidget {
  final String title;
  final Function(String answer) onAnswer;
  const ShortAnswer({Key? key, required this.title, required this.onAnswer}) : super(key: key);

  @override
  State<ShortAnswer> createState() => _ShortAnswerState();
}

class _ShortAnswerState extends State<ShortAnswer> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(widget.title, style: ThemeText.titleStyle),
        SizedBox(
          width: w * 0.6,
          child: TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.fromLTRB(20, 20, 20, w * 0.5),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(18.0)),
              ),
              hintText: '你的心情...',
            ),
            onSubmitted: (value) {
              widget.onAnswer(value);
            },
          ),
        ),
        const SizedBox(),
      ],
    );
  }
}
