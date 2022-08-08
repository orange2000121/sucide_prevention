import 'package:flutter/material.dart';

// SplashPage
class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF333333),
      body: Center(
        child: Icon(
          Icons.pets,
          size: MediaQuery.of(context).size.width * 0.7,
        ),
      ),
    );
  }
}
