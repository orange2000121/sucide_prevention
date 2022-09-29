import 'package:flutter/material.dart';
import 'package:sucide_prevention/utils.dart';

class WheelChoose extends StatefulWidget {
  final String title;
  final List options;
  const WheelChoose({Key? key, required this.title, required this.options}) : super(key: key);

  @override
  State<WheelChoose> createState() => _WheelChooseState();
}

class _WheelChooseState extends State<WheelChoose> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(widget.title, style: ThemeText.titleStyle),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(widget.options.length, (index) {
              return Wheel(
                onSelect: (value) {
                  print(value);
                },
                options: widget.options[index],
              );
            }),
          ),
        ),
        const SizedBox(),
      ],
    );
  }
}

class Wheel extends StatefulWidget {
  final List options;
  final Function(String) onSelect;
  const Wheel({Key? key, required this.options, required this.onSelect}) : super(key: key);

  @override
  State<Wheel> createState() => _WheelState();
}

class _WheelState extends State<Wheel> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Container(
      height: h * 0.2,
      width: w * 0.8,
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.black),
          bottom: BorderSide(color: Colors.black),
        ),
      ),
      child: ListWheelScrollView(
        itemExtent: 42,
        useMagnifier: true,
        magnification: 1.5,
        onSelectedItemChanged: (value) => widget.onSelect(widget.options[value]),
        children: List.generate(widget.options.length, (index) {
          return Text(widget.options[index], style: ThemeText.subtitleStyle);
        }),
      ),
    );
  }
}
