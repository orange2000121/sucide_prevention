import 'package:flutter/material.dart';
import 'package:sucide_prevention/utils.dart';

class WheelChoose extends StatefulWidget {
  final String title;
  final Map options;
  final Function(List answer) onAnswer;
  const WheelChoose({
    Key? key,
    required this.title,
    required this.options,
    required this.onAnswer,
  }) : super(key: key);

  @override
  State<WheelChoose> createState() => _WheelChooseState();
}

class _WheelChooseState extends State<WheelChoose> {
  List answer = [];
  late List wheelOptions, inputOptions;
  @override
  void initState() {
    super.initState();

    // childrenItens.add(OtherInput());
    wheelOptions = widget.options['wheel'];
    inputOptions = widget.options['input'];
    for (int i = 0; i < wheelOptions.length; i++) {
      answer.add(wheelOptions[i][0]);
    }
    for (int i = 0; i < inputOptions.length; i++) {
      answer.add('');
    }
    widget.onAnswer(answer);
  }

  List<Widget> makeChildrenItems() {
    List<Widget> childrenItens = [];
    childrenItens = List.generate(wheelOptions.length, (index) {
      return Wheel(
        onSelect: (value) {
          answer[index] = value;
          widget.onAnswer(answer);
        },
        options: wheelOptions[index],
      );
    });
    childrenItens.addAll(List.generate(inputOptions.length, (index) {
      return OtherInput(
        onSelect: (value) {
          answer[wheelOptions.length + index] = value;
          widget.onAnswer(answer);
        },
        hint: inputOptions[index],
      );
    }));
    return childrenItens;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(widget.title, style: ThemeText.titleStyle),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: makeChildrenItems(),
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
  static const Widget myDivider = Divider(
    color: Color.fromARGB(255, 146, 144, 144),
    thickness: 1,
  );
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    double itemWidth = w * 0.3;
    return Column(
      children: [
        SizedBox(
          width: itemWidth,
          child: myDivider,
        ),
        SizedBox(
          width: w * 0.8,
          height: h * 0.15,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xff94C1C9),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  width: w * 0.6,
                  height: h * 0.065,
                ),
              ),
              ListWheelScrollView(
                physics: const FixedExtentScrollPhysics(),
                itemExtent: 42,
                useMagnifier: true,
                magnification: 1.5,
                onSelectedItemChanged: (value) => widget.onSelect(widget.options[value]),
                children: List.generate(widget.options.length, (index) {
                  return Text(widget.options[index], style: ThemeText.subtitleStyle);
                }),
              ),
            ],
          ),
        ),
        SizedBox(
          width: itemWidth,
          child: myDivider,
        ),
      ],
    );
  }
}

class OtherInput extends StatelessWidget {
  final String hint;
  final Function(String) onSelect;
  const OtherInput({super.key, required this.hint, required this.onSelect});
  static const Widget myDivider = Divider(
    color: Color.fromARGB(255, 146, 144, 144),
    thickness: 1,
  );
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double itemWidth = w * 0.3;
    return Column(
      children: [
        SizedBox(
          width: itemWidth,
          child: myDivider,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: itemWidth * 1.8,
            child: TextField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: hint,
                filled: true,
                fillColor: const Color(0xff94C1C9),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) => onSelect(value),
              onSubmitted: (value) => onSelect(value),
            ),
          ),
        ),
        SizedBox(
          width: itemWidth,
          child: myDivider,
        ),
      ],
    );
  }
}
