import 'package:flutter/material.dart';

// SplashPage
class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage("resources/image/background/splash_background.png"), fit: BoxFit.cover),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'resources/image/splash_logo.png',
                  height: MediaQuery.of(context).size.width,
                  width: MediaQuery.of(context).size.width,
                ),
                Row(
                  children: const [
                    SizedBox(width: 150),
                    Text('', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
