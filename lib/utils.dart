import 'package:flutter/material.dart';

abstract class ThemeText {
  static const TextStyle titleStyle = TextStyle(
    fontSize: 30,
    // fontWeight: FontWeight.bold,
  );
  static const TextStyle subtitleStyle = TextStyle(
    fontSize: 25,
  );
  static const TextStyle contentStyle = TextStyle(
    fontSize: 20,
  );
  static const TextStyle buttonStyle = TextStyle(
    fontSize: 23,
  );
  static const TextStyle bottomSheetButton = TextStyle(
    fontSize: 16,
    color: Colors.black,
  );
  static const TextStyle dropDownItem = TextStyle(
    fontSize: 20,
    color: Colors.black,
  );
}

abstract class ThemeBorder {
  static const OutlineInputBorder inputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(30)),
    borderSide: BorderSide(color: Color(0xff707070)),
  );
}

abstract class ThemeButton {
  static ButtonStyle ovalButtonSelect = ButtonStyle(
      foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
      backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0))),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap);
  static ButtonStyle ovalButtonUnselect = ButtonStyle(
      foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
      backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
      shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0))),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap);
  static ButtonStyle mainButton = ButtonStyle(
      foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
      backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(194, 242, 242, 242)),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0))),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap);
}
