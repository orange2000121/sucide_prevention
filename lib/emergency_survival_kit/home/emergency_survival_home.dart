import 'dart:math';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:sucide_prevention/emergency_survival_kit/pagination/survial_method.dart';
import 'package:sucide_prevention/tool/load_json.dart';
import 'package:sucide_prevention/tool/sharepreference_helper.dart';

import 'package:sucide_prevention/utils.dart';

class SurvialHome extends StatefulWidget {
  const SurvialHome({Key? key}) : super(key: key);

  @override
  State<SurvialHome> createState() => _SurvialHomeState();
}

class _SurvialHomeState extends State<SurvialHome> {
  List modeConst = [
    {'title': '我的最愛', 'mode': 'favorite', 'image': 'resources/image/button/heart.png'},
    {'title': '隨機產生', 'mode': 'random', 'image': 'resources/image/button/shuffle.png'},
    {'title': '緊急救生包', 'mode': 'all', 'image': 'resources/image/button/mental.png'},
  ];
  int modeIndex = 2;
  String methodMode = 'all';
  String title = '緊急救生包';
  final ScrollController _controler = ScrollController();
  Future choseMethod(String mode) async {
    List allMethodList = await readMethod('resources/doc/survial/methods.json');
    List randomMethodList = [];
    List favoriteMethodList = [];
    List randomList = [];
    List favoriteList = await SharePreferenceHelper().getJson(SharePreferenceHelper.favoriteKey) ?? [];
    for (int i = 0; i < allMethodList.length; i++) {
      allMethodList[i]['id'] = i;
    }
    switch (mode) {
      case 'random':
        // random choose 5 method
        while (randomMethodList.length < 5) {
          int random = Random().nextInt(allMethodList.length);
          if (!randomList.contains(random)) {
            randomList.add(random);
            randomMethodList.add(allMethodList[random]);
          }
        }
        return randomMethodList;
      case 'favorite':
        if (favoriteList.isNotEmpty) {
          for (int i = 0; i < favoriteList.length; i++) {
            favoriteMethodList.add(allMethodList[favoriteList[i]]);
          }
        }
        return favoriteMethodList;
      default:
        return allMethodList;
    }
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double topPadding = MediaQuery.of(context).padding.top;
    Widget leafeBar = Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Image.asset("resources/image/decorate/leafe.png"),
        SizedBox(
          width: w * 0.6,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: w * 0.25,
                child: const Divider(
                  color: Colors.black,
                  thickness: 1,
                ),
              ),
              SizedBox(
                width: w * 0.25,
                child: const Divider(
                  color: Colors.black,
                  thickness: 1,
                ),
              ),
            ],
          ),
        ),
      ],
    );
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage("resources/image/background/green_cloud.png"), fit: BoxFit.cover),
            ),
            child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              SizedBox(
                height: topPadding + 20,
              ),
              leafeBar,
              Text(title, style: ThemeText.titleStyle),
              SizedBox(
                width: w * 0.7,
                child: const Divider(
                  color: Colors.black,
                  thickness: 1,
                ),
              ),
              Expanded(
                child: FutureBuilder(
                    future: choseMethod(modeConst[modeIndex]['mode']),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          padding: const EdgeInsets.only(top: 20),
                          controller: _controler,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                              child: OpenContainer(
                                transitionDuration: const Duration(milliseconds: 800),
                                closedColor: Colors.white,
                                closedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                                closedBuilder: ((context, action) {
                                  return Padding(
                                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                    child: Column(
                                      children: [
                                        Text('${snapshot.data[index]['title']}', style: ThemeText.subtitleStyle),
                                        const SizedBox(height: 10),
                                        Container(
                                          height: 200,
                                          width: w * 0.8,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: const Color.fromARGB(191, 255, 255, 255),
                                            image: DecorationImage(image: AssetImage(snapshot.data[index]['image']), fit: BoxFit.cover),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                                openBuilder: ((context, action) {
                                  return SurvialMethod(methodNum: snapshot.data[index]['id']);
                                }),
                              ),
                            );
                          },
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ),
            ]),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: IconButton(
                iconSize: 50,
                onPressed: () {
                  setState(() {
                    _controler.animateTo(0, duration: const Duration(milliseconds: 300), curve: Curves.ease);
                    modeIndex = (modeIndex + 1) % 3;
                    title = modeConst[modeIndex]['title'];
                  });
                },
                icon: Image.asset(modeConst[(modeIndex + 1) % 3]['image']),
              ),
            ),
          )
        ],
      ),
    );
  }
}
