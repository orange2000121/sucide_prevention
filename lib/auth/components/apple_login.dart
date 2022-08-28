import 'package:flutter/material.dart';

class AppleSignInButton extends StatefulWidget {
  const AppleSignInButton({Key? key}) : super(key: key);

  @override
  State<AppleSignInButton> createState() => _AppleSignInButtonState();
}

class _AppleSignInButtonState extends State<AppleSignInButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: Image.asset('resources/image/button/apple__4_-removebg-preview.png'),
      iconSize: 80,
    );
  }
}
