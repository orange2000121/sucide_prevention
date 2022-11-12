import 'package:flutter/material.dart';
import 'package:sucide_prevention/home/components/gradient_button.dart';
import 'package:sucide_prevention/utils.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage('resources/image/background/splash_background.png'), fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Row(children: [IconButton(iconSize: 40, onPressed: () => Navigator.pop(context), icon: const Icon(Icons.keyboard_double_arrow_left))]),
                const Text('個人基本資料', style: ThemeText.titleStyle),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width * 0.8,
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Color(0xffF8F8F8),
                        border: ThemeBorder.inputBorder,
                        labelText: '原密碼',
                      ),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Color(0xffF8F8F8),
                        border: ThemeBorder.inputBorder,
                        labelText: '新密碼',
                      ),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Color(0xffF8F8F8),
                        border: ThemeBorder.inputBorder,
                        labelText: '確認新密碼',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GradientButton(
                width: 170,
                height: 50,
                borderRadius: BorderRadius.circular(50),
                gradient: const LinearGradient(colors: [Color(0xffEEEBEB), Color(0xffC9D1DD)]),
                onPressed: () {
                  //todo ： 送出修改密碼
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    Text('更換密碼', style: TextStyle(color: Colors.black, fontSize: 26)),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
