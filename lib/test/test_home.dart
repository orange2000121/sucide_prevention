import 'package:flutter/material.dart';
import 'package:sucide_prevention/test/rate.dart';

class TestHome extends StatefulWidget {
  const TestHome({Key? key}) : super(key: key);

  @override
  State<TestHome> createState() => _TestHomeState();
}

class _TestHomeState extends State<TestHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('test home')),
        body: GridView.count(
          crossAxisCount: 2,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RateBar()),
                );
              },
              child: const Text('Rate'),
            ),
          ],
        ));
  }
}
