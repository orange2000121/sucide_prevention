import 'package:flutter/material.dart';
import 'package:sucide_prevention/home/components/gradient_button.dart';
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
    double w = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
      child: GradientButton(
        onPressed: onPressed,
        width: w * 0.8,
        height: h * 0.08,
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(colors: [Color(0xffE0E0E0), Color(0xffE7E6E6), Color(0xffEEEBEB)]),
        child: Text(title, style: ThemeText.subtitleStyle),
      ),
    );
  }
}
