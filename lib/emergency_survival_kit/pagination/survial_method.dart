import 'package:flutter/material.dart';
import 'package:sucide_prevention/tool/load_json.dart';
import 'package:sucide_prevention/tool/sharepreference_helper.dart';
import 'package:sucide_prevention/utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SurvialMethod extends StatefulWidget {
  final int methodNum;
  const SurvialMethod({Key? key, required this.methodNum}) : super(key: key);

  @override
  State<SurvialMethod> createState() => _SurvialMethodState();
}

class _SurvialMethodState extends State<SurvialMethod> {
  bool isFav = false;
  GlobalKey infomationKey = GlobalKey();

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
                method.length,
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(),
                                Container(
                                  constraints: BoxConstraints(maxWidth: w * 0.7),
                                  child: Text(title, style: ThemeText.titleStyle),
                                ),
                                IconButton(
                                  key: infomationKey,
                                  onPressed: () {
                                    RenderBox box = infomationKey.currentContext!.findRenderObject() as RenderBox;
                                    Offset position = box.localToGlobal(Offset.zero); //this is global position
                                    double y = position.dy; //this is y - I think it's what you want
                                    double x = position.dx; //this is x - I think it's what you want
                                    showMenu(
                                      context: context,
                                      position: RelativeRect.fromLTRB(x, y + 50, 0, 0),
                                      items: [
                                        const PopupMenuItem(
                                          child: Text('參考書籍：DBT®技巧訓練講義及作業單'),
                                        ),
                                        PopupMenuItem(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Text('自殺防治中心：'),
                                              TextButton(
                                                onPressed: () => launchUrlString('https://www.mmh.org.tw/depwebpage.php?id=96'),
                                                child: const Text('https://www.mmh.org.tw/depwebpage.php?id=96'),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                  icon: Image.asset('resources/image/button/infomation.png'),
                                ),
                              ],
                            ),
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
                  // lastContent,
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
