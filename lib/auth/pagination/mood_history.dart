import 'dart:convert';

import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:sucide_prevention/tool/mood_db.dart';
import 'package:sucide_prevention/utils.dart';

class MoodHistory extends StatefulWidget {
  const MoodHistory({super.key});

  @override
  State<MoodHistory> createState() => _MoodHistoryState();
}

class _MoodHistoryState extends State<MoodHistory> {
  void moodDialog(Map data) async {
    String date = data['date'].split(' ')[0];
    List record = jsonDecode(data['record']);
    List<String> title = [];
    List<List> content = [];
    for (var element in record) {
      element.forEach(((key, value) {
        title.add(key);
        content.add(element[key]);
      }));
    }
    await showDialog<bool>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('$date 的心情紀錄'),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(record.length, (recordIdx) {
            return Card(
              child: Column(
                children: [
                  Text(title[recordIdx]),
                  SizedBox(
                    width: 300,
                    height: 50,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: List.generate(content[recordIdx].length, (contentIdx) => Text('${content[recordIdx][contentIdx]}')),
                    ),
                  )
                ],
              ),
            );
          }),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('確認'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
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

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage("resources/image/background/green_cloud.png"), fit: BoxFit.cover),
        ),
        child: Column(children: [
          SizedBox(
            height: topPadding + 20,
          ),
          leafeBar,
          const Text('心情紀錄', style: ThemeText.titleStyle),
          SizedBox(width: w * 0.7, child: const Divider(color: Colors.black, thickness: 1)),
          Expanded(
            child: FutureBuilder(
                future: MoodDB().queryAllRows(),
                builder: (context, AsyncSnapshot<List<Map>> snapshot) {
                  if (snapshot.hasData) {
                    print(snapshot.data);
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            onTap: () => moodDialog(snapshot.data![index]),
                            title: Text('${snapshot.data![index]['date'].split(' ')[0]} 的心情紀錄'),
                          ),
                        );
                      },
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                }),
          ),
        ]),
      ),
    );
  }
}
