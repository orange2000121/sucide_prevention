import 'package:flutter/material.dart';
import 'package:sucide_prevention/auth/home/login_page.dart';
import 'package:sucide_prevention/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sucide_prevention/auth.dart';

class createaccount extends StatefulWidget {
  const createaccount({Key? key}) : super(key: key);

  @override
  State<createaccount> createState() => _createaccountState();
}

class _createaccountState extends State<createaccount> {
  final AuthService auth = AuthService();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("resources/image/background/splash_background.png"), fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // pop arrow
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: Row(children: [
                IconButton(
                  iconSize: 40,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.keyboard_double_arrow_left),
                )
              ]),
            ),
            Column(
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
                    controller: email,
                    decoration: const InputDecoration(
                      border: ThemeBorder.inputBorder,
                      labelText: '聯絡信箱',
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: password,
                    decoration: const InputDecoration(
                      border: ThemeBorder.inputBorder,
                      labelText: '密碼',
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () async {
                    final status = await auth.signupwithemail(email, password);
                    if (status) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ));
                    }
                  },
                  child: const Text('註冊', style: ThemeText.buttonStyle),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).padding.top + 20,
            ),
          ],
        ),
      ),
    );
  }
}
