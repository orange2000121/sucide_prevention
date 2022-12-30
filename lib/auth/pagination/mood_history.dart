import 'dart:convert';

import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:sucide_prevention/tool/mood_db.dart';
import 'package:sucide_prevention/utils.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class MoodHistory extends StatefulWidget {
  const MoodHistory({super.key});

  @override
  State<MoodHistory> createState() => _MoodHistoryState();
}

class _MoodHistoryState extends State<MoodHistory> {
  String selectDate = DateTime.now().toString().split(' ')[0];
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
        backgroundColor: const Color.fromARGB(255, 234, 232, 232),
        title: Text('$date 的心情紀錄'),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(record.length, (recordIdx) {
            return Card(
              color: const Color(0xffDDEBEB),
              shadowColor: const Color.fromARGB(255, 143, 155, 155),
              child: Column(
                children: [
                  Text(title[recordIdx]),
                  const Divider(),
                  SizedBox(
                    width: 300,
                    height: 50,
                    child: ListView(
                      padding: const EdgeInsets.only(left: 20),
                      scrollDirection: Axis.horizontal,
                      children: List.generate(
                        content[recordIdx].length,
                        (contentIdx) => Center(child: Text('${content[recordIdx][contentIdx]}${contentIdx == content[recordIdx].length - 1 ? '' : '、'}')),
                      ),
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
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage("resources/image/background/green_cloud.png"), fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            SizedBox(
              height: topPadding + 20,
            ),
            Row(
              children: [
                IconButton(
                  iconSize: 40,
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.keyboard_double_arrow_left),
                ),
              ],
            ),
            leafeBar,
            const Text('心情紀錄', style: ThemeText.titleStyle),
            SizedBox(width: w * 0.7, child: const Divider(color: Colors.black, thickness: 1)),
            SfDateRangePicker(
              onSelectionChanged: (dateTime) {
                setState(() {
                  String date = dateTime.value.toString().split(' ')[0];
                  selectDate = date;
                });
              },
            ),
            Expanded(
              child: FutureBuilder(
                  future: MoodDB().queryByDate(selectDate),
                  builder: (context, AsyncSnapshot<List<Map>> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        padding: const EdgeInsets.only(top: 10),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          Map record = jsonDecode(snapshot.data![index]['record'])[0];
                          String mood = record.values.first[0];
                          String time = snapshot.data![index]['date'].split(' ')[1];
                          String hour = time.split(':')[0];
                          return Padding(
                            padding: EdgeInsets.fromLTRB(w * 0.05, 5, w * 0.05, 5),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(10),
                                foregroundColor: Colors.black,
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                              ),
                              onPressed: () => moodDialog(snapshot.data![index]),
                              child: Row(
                                children: [
                                  Text('$hour 點的心情紀錄'),
                                  const Spacer(),
                                  Text(mood),
                                  const Spacer(),
                                  const Icon(Icons.keyboard_arrow_right),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
