import 'package:flutter/material.dart';
import 'package:sucide_prevention/tool/load_json.dart';
import 'package:sucide_prevention/tool/sharepreference_helper.dart';
import 'package:sucide_prevention/utils.dart';

class SurvialMethod extends StatefulWidget {
  final int methodNum;
  const SurvialMethod({Key? key, required this.methodNum}) : super(key: key);

  @override
  State<SurvialMethod> createState() => _SurvialMethodState();
}

class _SurvialMethodState extends State<SurvialMethod> {
  bool isFav = false;

  Future<bool> determineFav() async {
    List? favoriteList = await SharePreferenceHelper().getJson(SharePreferenceHelper.favoriteKey);
    if (favoriteList == null) {
      return false;
    }
    if (favoriteList.contains(widget.methodNum)) {
      isFav = true;
    }
    return isFav;
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    Widget leafeBar = Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          "resources/image/decorate/leafe.png",
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                      iconSize: 40,
                                      onPressed: () => Navigator.pop(context),
                                      icon: const Icon(Icons.keyboard_double_arrow_left),
                                    ),
                                    Text('方法${widget.methodNum + 1}', style: ThemeText.titleHint),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 30),
                                  child: FutureBuilder(
                                    future: determineFav(),
                                    builder: (context, snapshot) => IconButton(
                                      onPressed: () async {
                                        setState(() {
                                          isFav = !isFav;
                                        });
                                        List favoriteList = await SharePreferenceHelper().getJson(SharePreferenceHelper.favoriteKey) ?? [];
                                        if (isFav) {
                                          favoriteList.add(widget.methodNum);
                                        } else {
                                          favoriteList.remove(widget.methodNum);
                                        }
                                        SharePreferenceHelper().setJson(SharePreferenceHelper.favoriteKey, favoriteList);
                                      },
                                      icon: Icon(isFav ? Icons.favorite : Icons.favorite_border, size: 36, color: isFav ? Colors.red[400] : Colors.black),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(title, style: ThemeText.titleStyle),
                          ],
                        ),
                      ),
                      leafeBar,
                    ],
                  ),
                  Column(children: contents),
                  Container(
                    padding: const EdgeInsets.only(bottom: 50),
                    width: w * 0.85,
                    height: h * 0.33,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
                    ),
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
