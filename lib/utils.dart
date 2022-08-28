import 'package:flutter/material.dart';

abstract class ThemeText {
  static const TextStyle titleStyle = TextStyle(
    fontSize: 30,
    // fontWeight: FontWeight.bold,
  );
  static const TextStyle buttonStyle = TextStyle(
    fontSize: 23,
  );
  static const TextStyle bottomSheetButton = TextStyle(
    fontSize: 16,
    color: Colors.black,
  );
  static const TextStyle subtitleStyle = TextStyle(
    fontSize: 20,
  );
}

abstract class ThemeBorder {
  static const OutlineInputBorder inputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(30)),
    borderSide: BorderSide(color: Color(0xff707070)),
  );
}
