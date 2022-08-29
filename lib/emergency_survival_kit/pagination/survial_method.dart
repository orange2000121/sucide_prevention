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
              return ListView.builder(
                itemCount: method.length + 2,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('方法${widget.methodNum + 1}: $title', style: ThemeText.titleStyle),
                      ),
                    );
                  } else if (index < method.length + 1) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(method[index - 1], style: ThemeText.subtitleStyle),
                      ),
                    );
                  } else {
                    return Image.asset(image, width: MediaQuery.of(context).size.width - 50, height: 200);
                  }
                },
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
