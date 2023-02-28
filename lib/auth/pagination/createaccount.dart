import 'package:flutter/material.dart';
import 'package:sucide_prevention/auth/home/login_page.dart';
import 'package:sucide_prevention/utils.dart';
import 'package:sucide_prevention/auth.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
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
                      await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('註冊成功'),
                          content: const Text('請重新登入'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'OK'),
                              child: const Text('確定'),
                            ),
                          ],
                        ),
                      );
                      if (!mounted) return;
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
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
