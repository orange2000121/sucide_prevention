import 'package:flutter/material.dart';
import 'package:sucide_prevention/auth.dart';
import 'package:sucide_prevention/auth/home/login_page.dart';
import 'package:sucide_prevention/utils.dart';
import 'package:sucide_prevention/home/components/gradient_button.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final AuthService auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('resources/image/background/splash_background.png'),
          fit: BoxFit.cover,
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text('個人基本資料', style: ThemeText.titleStyle),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
                  child: Row(
                    children: [
                      Image.asset('resources/image/grid (1).png'),
                      Text('帳號 ： ${auth.getuserdata()}', style: ThemeText.contentStyle),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset('resources/image/grid (1).png'),
                          const Text('密碼 ： *******', style: ThemeText.contentStyle),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: IconButton(icon: Image.asset('resources/image/button/up-arrow.png'), onPressed: () {}),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
                  child: Row(
                    children: [
                      Image.asset('resources/image/grid (1).png'),
                      const Text('手錶編號 ： ', style: ThemeText.contentStyle),
                      const SizedBox(
                        width: 172,
                        height: 40,
                        child: TextField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xffF8F8F8),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(50.0)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            GradientButton(
                width: 170,
                height: 50,
                borderRadius: BorderRadius.circular(50),
                gradient: const LinearGradient(colors: [Color(0xffEEEBEB), Color(0xffC9D1DD)]),
                onPressed: () {
                  auth.signoutwithGoogle();
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoginPage()), (route) => false);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset('resources/image/button/exit.png'),
                    const Text('登出', style: TextStyle(color: Colors.black, fontSize: 26)),
                  ],
                )),
          ],
        ));
  }
}
