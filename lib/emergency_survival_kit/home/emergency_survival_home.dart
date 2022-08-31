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
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(image: AssetImage("resources/image/background/green_cloud.png"), fit: BoxFit.cover),
      ),
      child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(0, 80, 0, 20),
          child: Text('緊急救生包', style: ThemeText.titleStyle),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height - 260,
          child: FutureBuilder(
              future: readMethod('resources/doc/survial/method.json'),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  List? survialTitle = snapshot.data['title'];
                  List? survialImage = snapshot.data['image'];

                  return ListView.builder(
                    itemCount: survialTitle!.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          debugPrint('$index');
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SurvialMethod(methodNum: index)));
                        },
                        child: Column(
                          children: [
                            Text('方法${index + 1}: ${survialTitle[index]}', style: ThemeText.subtitleStyle),
                            const SizedBox(height: 10),
                            Image.asset(survialImage![index], width: MediaQuery.of(context).size.width - 50, height: 200),
                          ],
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
