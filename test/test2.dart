import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: MoodHome(),
  ));
}

class MoodHome extends StatefulWidget {
  const MoodHome({Key? key}) : super(key: key);

  @override
  State<MoodHome> createState() => _MoodHomeState();
}

class _MoodHomeState extends State<MoodHome> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      bottomNavigationBar: Container(
        height: 20,
        color: Colors.red,
      ),
      body: Center(
        child: Container(
          height: h,
          color: Colors.blue,
        ),
      ),
    );
  }
}
