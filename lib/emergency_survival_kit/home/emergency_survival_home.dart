import 'package:flutter/material.dart';
import 'package:sucide_prevention/components/bottom_button.dart';
import 'package:sucide_prevention/emergency_survival_kit/pagination/survial_method.dart';

import 'package:sucide_prevention/utils.dart';

class SurvialHome extends StatefulWidget {
  const SurvialHome({Key? key}) : super(key: key);

  @override
  State<SurvialHome> createState() => _SurvialHomeState();
}

class _SurvialHomeState extends State<SurvialHome> {
  static const survialTitle = ['改變臉的溫度', '激烈運動', '熱水澡', '調節呼吸', '吃喜歡的東西'];
  static const survialImage = [
    'resources/image/survial/Meditation-pana.png',
    'resources/image/survial/Image 4.png',
    'resources/image/survial/Image 3.png',
    'resources/image/survial/Eating donuts-pana.png',
    'resources/image/survial/Bath.png',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage("resources/image/background/green_cloud.png"), fit: BoxFit.cover),
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 80, 0, 20),
            child: Text('緊急救生包', style: ThemeText.titleStyle),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height - 230,
            child: ListView.builder(
              itemCount: survialTitle.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SurvialMethod(methodNum: '$index')));
                  },
                  child: Column(
                    children: [
                      Text('方法${index + 1}: ${survialTitle[index]}', style: ThemeText.subtitleStyle),
                      const SizedBox(height: 10),
                      Image.asset(survialImage[index], width: MediaQuery.of(context).size.width - 50, height: 200),
                    ],
                  ),
                );
              },
            ),
          ),
          const BottomButton(),
        ]),
      ),
    );
  }
}
