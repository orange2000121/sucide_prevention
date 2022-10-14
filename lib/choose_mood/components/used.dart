import 'package:flutter/material.dart';
import 'package:sucide_prevention/utils.dart';

class Used extends StatefulWidget {
  final String title;
  final Function(Map answer) onAnswer;
  const Used({Key? key, required this.title, required this.onAnswer}) : super(key: key);

  @override
  State<Used> createState() => _UsedState();
}

class _UsedState extends State<Used> {
  Map answer = {
    '有無使用緊急救生包?': '有',
    '是否使用其他方式？': '有',
    '有用程度(1-5)': '1',
    '備註': '',
  };
  @override
  void initState() {
    super.initState();
    widget.onAnswer(answer);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(widget.title, style: ThemeText.titleStyle),
        Column(
          children: [
            Dropdown(
              title: '有無使用緊急救生包?',
              options: const ['有', '沒有'],
              onSelect: (value) {
                answer['有無使用緊急救生包'] = value;
                widget.onAnswer(answer);
              },
            ),
            Dropdown(
              title: '是否使用其他方式？',
              options: const ['有', '沒有'],
              onSelect: (value) {
                answer['是否使用其他方式'] = value;
                widget.onAnswer(answer);
              },
            ),
            Dropdown(
              title: '有用程度(1-5)',
              options: const ['1', '2', '3', '4', '5'],
              onSelect: (value) {
                answer['有用程度'] = value;
                widget.onAnswer(answer);
              },
            ),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('備註', style: ThemeText.subtitleStyle),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.65,
                    child: TextField(
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: '備註...',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(28.0)),
                        ),
                      ),
                      onSubmitted: (value) {
                        answer['備註'] = value;
                        widget.onAnswer(answer);
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        const SizedBox(),
      ],
    );
  }
}

class Dropdown extends StatefulWidget {
  final String title;
  final List<String> options;
  final Function(String) onSelect;
  const Dropdown({Key? key, required this.title, required this.options, required this.onSelect}) : super(key: key);

  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  late String dropdownValue;
  @override
  void initState() {
    super.initState();
    dropdownValue = widget.options.first;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title, style: ThemeText.subtitleStyle),
        Container(
          width: MediaQuery.of(context).size.width * 0.65,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 3.0),
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(28),
            color: Colors.white,
          ),
          child: DropdownButton<String>(
            value: dropdownValue,
            icon: const Icon(Icons.arrow_downward),
            elevation: 30,
            style: ThemeText.dropDownItem,
            borderRadius: BorderRadius.circular(10),
            onChanged: (String? value) {
              // This is called when the user selects an item.
              setState(() {
                dropdownValue = value!;
                widget.onSelect(value);
              });
            },
            items: widget.options.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
