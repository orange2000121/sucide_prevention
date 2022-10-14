import 'package:flutter/material.dart';
import 'package:sucide_prevention/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sucide_prevention/auth.dart';

import '../home/login_page.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final AuthService auth = AuthService();
  TextEditingController emailreset = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("resources/image/splash_background.png"),
                fit: BoxFit.cover)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: const [
                  SizedBox(width: 50),
                  Text('請輸入你的聯絡信箱', style: ThemeText.titleStyle),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 300,
                child: TextFormField(
                  controller: emailreset,
                  decoration: const InputDecoration(
                    border: ThemeBorder.inputBorder,
                    labelText: '聯絡信箱',
                  ),
                ),
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () async {
                  final status = await auth.resetpassword(emailreset);
                  if (status) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ));
                  }
                },
                child: const Text('發送至信箱', style: ThemeText.buttonStyle),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
