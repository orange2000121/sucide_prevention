import 'package:flutter/material.dart';
import 'package:sucide_prevention/auth/home/login_page.dart';
import 'package:sucide_prevention/home/home_page.dart';
import 'package:sucide_prevention/auth.dart';
import 'package:sucide_prevention/splash_page.dart';

class GoogleSignInButton extends StatefulWidget {
  const GoogleSignInButton({Key? key}) : super(key: key);

  @override
  State<GoogleSignInButton> createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  final AuthService auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        final ok = await auth.signinWithGoogle();
        if (ok) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ));
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginPage(),
              ));
        }
      },
      icon: Image.asset('resources/image/button/google__1_-removebg-preview.png'),
      iconSize: 80,
    );
  }
}
