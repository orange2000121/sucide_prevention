import 'package:flutter/material.dart';
import 'package:sucide_prevention/utils.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class ChoseDate extends StatefulWidget {
  final String title;
  const ChoseDate({Key? key, required this.title}) : super(key: key);

  @override
  State<ChoseDate> createState() => _ChoseDateState();
}

class _ChoseDateState extends State<ChoseDate> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(widget.title, style: ThemeText.titleStyle),
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: SfDateRangePicker(),
        ),
        const SizedBox(),
      ],
    );
  }
}
