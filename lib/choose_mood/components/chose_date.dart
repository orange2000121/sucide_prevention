import 'package:flutter/material.dart';
import 'package:sucide_prevention/utils.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class ChoseDate extends StatefulWidget {
  final String title;
  final Function(String date) onAnswer;
  const ChoseDate({Key? key, required this.title, required this.onAnswer}) : super(key: key);

  @override
  State<ChoseDate> createState() => _ChoseDateState();
}

class _ChoseDateState extends State<ChoseDate> {
  @override
  void initState() {
    super.initState();
    widget.onAnswer(DateTime.now().toString());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(widget.title, style: ThemeText.titleStyle),
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: SfDateRangePicker(
            maxDate: DateTime.now(),
            onSelectionChanged: (dateTime) {
              String date = dateTime.value.toString().split(' ')[0];
              widget.onAnswer(date);
            },
          ),
        ),
        const SizedBox(),
      ],
    );
  }
}
