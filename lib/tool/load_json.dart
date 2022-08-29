import 'dart:convert';
import 'package:flutter/services.dart';

Future readMethod(String file, {String? key}) async {
  String loadString = await rootBundle.loadString(file);
  return key == null ? await json.decode(loadString) : await json.decode(loadString)[key];
}
