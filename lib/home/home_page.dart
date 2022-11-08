import 'package:flutter/material.dart';
import 'package:sucide_prevention/auth/home/user_profile.dart';
import 'package:sucide_prevention/choose_mood/home/mood_home.dart';
import 'package:sucide_prevention/emergency_survival_kit/home/emergency_survival_home.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  final List<Widget> _pages = const [
    MoodHome(),
    SurvialHome(),
    UserProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) => setState(() => currentIndex = value),
        currentIndex: currentIndex,
        backgroundColor: const Color(0xFFD6DCDB),
        items: [
          BottomNavigationBarItem(
              icon: BottomButton(
                imageName: 'resources/image/button/satisfaction rate.png',
                select: currentIndex,
                buttonIdx: 0,
              ),
              label: '心情紀錄'),
          BottomNavigationBarItem(
              icon: BottomButton(
                imageName: 'resources/image/button/mental.png',
                select: currentIndex,
                buttonIdx: 1,
              ),
              label: '緊急救生包'),
          BottomNavigationBarItem(
              icon: BottomButton(
                imageName: 'resources/image/button/user.png',
                select: currentIndex,
                buttonIdx: 2,
              ),
              label: '我的'),
        ],
      ),
    );
  }
}

class BottomButton extends StatelessWidget {
  final String imageName;
  final int select;
  final int buttonIdx;
  const BottomButton({Key? key, required this.imageName, required this.select, required this.buttonIdx}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: select == buttonIdx ? Colors.white : Colors.transparent,
      ),
      child: Image.asset(imageName, width: 40, height: 40),
    );
  }
}
