import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sucide_prevention/auth/components/google_login.dart';
import 'package:sucide_prevention/home/home_page.dart';
import 'package:sucide_prevention/utils.dart';
import 'package:sucide_prevention/auth/pagination/fogot_password.dart';
import 'package:sucide_prevention/auth/pagination/createaccount.dart';

import '../../auth.dart'; //這裡是相對路徑，要注意

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final AuthService auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("resources/image/background/splash_background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: const Color.fromARGB(65, 112, 112, 112)),
              color: const Color.fromARGB(90, 255, 255, 255),
              borderRadius: const BorderRadius.all(Radius.circular(30)),
            ),
            width: MediaQuery.of(context).size.width * 0.88,
            height: MediaQuery.of(context).size.height * 0.69,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: const BorderSide(color: Colors.black),
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ForgotPassword(),
                            ),
                          );
                        },
                        child: const Text('忘記密碼', style: ThemeText.titleStyle),
                      ),
                      Container(alignment: Alignment.center, width: 20, child: const Text('/', style: ThemeText.titleStyle)),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: const BorderSide(color: Colors.black),
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const createaccount(),
                            ),
                          );
                        },
                        child: const Text('註冊帳號', style: ThemeText.titleStyle),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      controller: email,
                      decoration: const InputDecoration(
                        labelText: '帳號',
                        hintStyle: TextStyle(fontSize: 18),
                        border: ThemeBorder.inputBorder,
                      ),
                      validator: (value) => value!.isEmpty ? '請輸入帳號' : null,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      obscureText: true,
                      controller: password,
                      decoration: const InputDecoration(
                        labelText: '密碼',
                        hintStyle: TextStyle(fontSize: 18),
                        border: ThemeBorder.inputBorder,
                      ),
                      validator: (value) => value!.isEmpty ? '密碼不能為空' : null,
                    ),
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () async {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }
                      bool check = await auth.signinwithemail(email, password);
                      print('check: $check');
                      if (check) {
                        // firestore 下載更新手錶編號
                        FirebaseFirestore db = FirebaseFirestore.instance;
                        var auth = AuthService();
                        var profile = db.collection(auth.getuserdata()).doc('profile').snapshots().first;
                        profile.then((value) {
                          SharedPreferences.getInstance().then((prefs) {
                            prefs.setString('watchid', value.data()!['watchid']);
                          });
                        });

                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const HomePage()),
                          (route) => false,
                        );
                      } else {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginPage()),
                          (route) => false,
                        );
                      }
                    },
                    child: Container(
                      width: 300,
                      height: 60,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: const Color(0xff707070)),
                        borderRadius: const BorderRadius.all(Radius.circular(30)),
                      ),
                      child: const Center(
                        child: Text('登入',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
