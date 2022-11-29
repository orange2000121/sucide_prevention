import 'package:flutter/material.dart';

// SplashPage
class SplashPage extends StatelessWidget {
  final String photoPath;
  const SplashPage({Key? key, required this.photoPath}) : super(key: key);

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
                  photoPath,
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
