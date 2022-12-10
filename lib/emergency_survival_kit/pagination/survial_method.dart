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
    double w = MediaQuery.of(context).size.width;
    Widget leafeBar = Stack(
      alignment: Alignment.center,
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
                width: w * 0.2,
                child: const Divider(
                  color: Colors.black,
                  thickness: 1,
                ),
              ),
              SizedBox(
                width: w * 0.2,
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
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage("resources/image/background/method_background.png"), fit: BoxFit.cover),
        ),
        child: FutureBuilder(
          future: readMethod('resources/doc/survial/methods.json'),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              List method = snapshot.data[widget.methodNum]['content'];
              String title = snapshot.data[widget.methodNum]['title'];
              String image = snapshot.data[widget.methodNum]['image'];
              List<Widget> contents = List.generate(
                method.length - 1,
                (index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(method[index], style: ThemeText.contentStyle),
                ),
              );
              Widget lastContent = Text(method[method.length - 1], textAlign: TextAlign.center, style: ThemeText.subtitleStyle);

              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                        child: Column(
                          children: [
                            Row(children: [
                              IconButton(
                                iconSize: 40,
                                onPressed: () => Navigator.pop(context),
                                icon: const Icon(Icons.keyboard_double_arrow_left),
                              ),
                              Text('方法${widget.methodNum + 1}', style: ThemeText.titleHint),
                            ]),
                            Text(title, style: ThemeText.titleStyle),
                          ],
                        ),
                      ),
                      leafeBar,
                    ],
                  ),
                  Column(children: contents),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 50),
                    child: Image.asset(image, width: MediaQuery.of(context).size.width - 50, height: 200),
                  ),
                  lastContent,
                  const SizedBox(),
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
