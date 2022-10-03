import 'package:flutter/material.dart';
import 'package:sucide_prevention/utils.dart';

class ButtonOptions extends StatefulWidget {
  final Function(String) onAnswer;
  final String title;
  final List<String> options;
  const ButtonOptions({
    Key? key,
    required this.onAnswer,
    required this.options,
    required this.title,
  }) : super(key: key);

  @override
  State<ButtonOptions> createState() => _ButtonOptionsState();
}

class _ButtonOptionsState extends State<ButtonOptions> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(widget.title, style: ThemeText.titleStyle),
        Column(
          children: List.generate(widget.options.length, (index) {
            return OptionButton(
              onPressed: () => widget.onAnswer(widget.options[index]),
              title: widget.options[index],
            );
          }),
        ),
        const SizedBox(),
      ],
    );
  }
}

class OptionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  const OptionButton({Key? key, required this.onPressed, required this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
      child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
              backgroundColor: MaterialStateProperty.all<Color>(const Color(0xffE0E0E0)),
              minimumSize: MaterialStateProperty.all<Size>(Size.fromHeight(h * 0.08)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)))),
          child: Text(title, style: ThemeText.subtitleStyle)),
    );
  }
}
