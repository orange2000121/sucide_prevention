import 'package:flutter/material.dart';
import 'package:sucide_prevention/tool/load_json.dart';
import 'package:sucide_prevention/utils.dart';

class SurvialMethod extends StatefulWidget {
  final int methodNum;
  const SurvialMethod({Key? key, required this.methodNum}) : super(key: key);

  @override
  State<SurvialMethod> createState() => _SurvialMethodState();
}

class _SurvialMethodState extends State<SurvialMethod> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('緊急救生包'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage("resources/image/background/method_background.png"), fit: BoxFit.cover),
        ),
        child: FutureBuilder(
          future: readMethod('resources/doc/survial/method.json'),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              List method = snapshot.data['content'][widget.methodNum];
              String title = snapshot.data['title'][widget.methodNum];
              String image = snapshot.data['image'][widget.methodNum];
              List<Widget> contents = [];
              for (int i = 0; i < method.length; i++) {
                contents.add(Text(method[i], style: ThemeText.subtitleStyle));
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('方法${widget.methodNum + 1}: $title', style: ThemeText.titleStyle),
                  ),
                  ...contents,
                  Image.asset(image, width: MediaQuery.of(context).size.width - 50, height: 200)
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
