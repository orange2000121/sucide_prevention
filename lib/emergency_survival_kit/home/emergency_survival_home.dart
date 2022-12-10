import 'package:flutter/material.dart';
import 'package:sucide_prevention/emergency_survival_kit/pagination/survial_method.dart';
import 'package:sucide_prevention/tool/load_json.dart';

import 'package:sucide_prevention/utils.dart';

class SurvialHome extends StatefulWidget {
  const SurvialHome({Key? key}) : super(key: key);

  @override
  State<SurvialHome> createState() => _SurvialHomeState();
}

class _SurvialHomeState extends State<SurvialHome> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    double topPadding = MediaQuery.of(context).padding.top;
    Widget leafeBar = Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Image.asset(
          "resources/image/leafe.png",
        ),
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
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(image: AssetImage("resources/image/background/green_cloud.png"), fit: BoxFit.cover),
      ),
      child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        SizedBox(
          height: topPadding + 20,
        ),
        leafeBar,
        const Text('緊急救生包', style: ThemeText.titleStyle),
        SizedBox(
          width: w * 0.7,
          child: const Divider(
            color: Colors.black,
            thickness: 1,
          ),
        ),
        Expanded(
          child: FutureBuilder(
              future: readMethod('resources/doc/survial/methods.json'),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          debugPrint('$index');
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SurvialMethod(methodNum: index)));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color.fromARGB(191, 255, 255, 255),
                          ),
                          margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: Column(
                            children: [
                              Text('方法${index + 1}: ${snapshot.data[index]['title']}', style: ThemeText.subtitleStyle),
                              const SizedBox(height: 10),
                              Image.asset(snapshot.data[index]['image'], width: MediaQuery.of(context).size.width - 50, height: 200),
                            ],
                          ),
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
    );
  }
}
