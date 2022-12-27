import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sucide_prevention/auth.dart';
import 'package:sucide_prevention/auth/home/login_page.dart';
import 'package:sucide_prevention/auth/pagination/change_password.dart';
import 'package:sucide_prevention/auth/pagination/mood_history.dart';
import 'package:sucide_prevention/tool/mood_db.dart';
import 'package:sucide_prevention/tool/sharepreference_helper.dart';
import 'package:sucide_prevention/utils.dart';
import 'package:sucide_prevention/home/components/gradient_button.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final AuthService auth = AuthService();
  final prefsHelper = SharePreferenceHelper();
  final watchIdController = TextEditingController();
  bool lock = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    prefsHelper.getString(SharePreferenceHelper.watchKey).then((value) {
      watchIdController.text = value ?? '';
      if (watchIdController.text.isEmpty) {
        // unlock the text field
        setState(() => lock = false);
      }
    });
    // prefs.then((pregs) {
    //   watchIdController.text = pregs.getString('watchid') ?? '';
    //   if (watchIdController.text.isEmpty) {
    //     // unlock the text field
    //     setState(() => lock = false);
    //   }
    // });
  }

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
                      Image.asset('resources/image/decorate/grid (1).png'),
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
                          Image.asset('resources/image/decorate/grid (1).png'),
                          const Text('密碼 ： *******', style: ThemeText.contentStyle),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: TextButton(
                          child: const Text('變更密碼', style: TextStyle(color: Color(0xff94C1C9))),
                          onPressed: () async {
                            bool status = await auth.resetpassword(auth.getuserdata());
                            if (status) {
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text('已寄送密碼重設信件'),
                                  content: const Text('請至信箱收取信件'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () => Navigator.pop(context, 'OK'),
                                      child: const Text('確認'),
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
                  child: Row(
                    children: [
                      Image.asset('resources/image/decorate/grid (1).png'),
                      const Text('手錶編號 ： ', style: ThemeText.contentStyle),
                      SizedBox(
                        width: 172,
                        height: 40,
                        child: TextField(
                          controller: watchIdController,
                          readOnly: lock,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Color(0xffF8F8F8),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(50.0)),
                            ),
                          ),
                          onChanged: (value) {
                            prefsHelper.setString(SharePreferenceHelper.watchKey, value);
                            // prefs.then((pregs) {
                            //   pregs.setString('watchNumber', value);
                            // });
                          },
                          onSubmitted: (value) {
                            prefsHelper.setString(SharePreferenceHelper.watchKey, value);
                            // prefs.then((pregs) {
                            //   pregs.setString('watchNumber', value);
                            // });
                            // firestore 上傳更新手錶編號
                            FirebaseFirestore db = FirebaseFirestore.instance;
                            db.collection(auth.getuserdata()).doc('profile').set({"watchid": value});

                            setState(() => lock = true);
                          },
                          onTap: () async {
                            //todo : unlock the text field
                            print('before lock: $lock');
                            if (lock) {
                              lock = (await showDialog<bool>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text('確定更改手錶編號？'),
                                  // content: const Text('AlertDialog description'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () => Navigator.pop(context, true),
                                      child: const Text('取消'),
                                    ),
                                    TextButton(
                                      onPressed: () => Navigator.pop(context, false),
                                      child: const Text('確認'),
                                    ),
                                  ],
                                ),
                              ))!;
                              setState(() {});
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
                  child: Row(
                    children: [
                      Image.asset('resources/image/decorate/grid (1).png'),
                      const Text('心情紀錄: ', style: ThemeText.contentStyle),
                      SizedBox(width: 20),
                      GradientButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const MoodHistory()));
                        },
                        width: 100,
                        height: 40,
                        borderRadius: BorderRadius.circular(50),
                        gradient: const LinearGradient(colors: [Color(0xffEEEBEB), Color(0xffC9D1DD)]),
                        child: const Text('查看', style: TextStyle(color: Colors.black, fontSize: 20)),
                      )
                    ],
                  ),
                )
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
