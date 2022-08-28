import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SurvialMethod extends StatefulWidget {
  final String methodNum;
  const SurvialMethod({Key? key, required this.methodNum}) : super(key: key);

  @override
  State<SurvialMethod> createState() => _SurvialMethodState();
}

class _SurvialMethodState extends State<SurvialMethod> {
  Future<List> readMethod(String methodNum) async {
    String loadString = await rootBundle.loadString('resources/doc/survial/method_text.json');
    debugPrint(loadString);
    return await json.decode(loadString)[methodNum];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: readMethod(widget.methodNum),
        builder: (context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) => Text(snapshot.data![index]),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
