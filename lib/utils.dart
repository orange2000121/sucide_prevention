import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class ThemeText {
  static const TextStyle titleStyle = TextStyle(
    fontSize: 26,
    // fontWeight: FontWeight.bold,
  );
  static const TextStyle buttonStyle = TextStyle(
    fontSize: 23,
  );
}

abstract class ThemeBorder {
  static const OutlineInputBorder inputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(30)),
    borderSide: BorderSide(color: Color(0xff707070)),
  );
}
