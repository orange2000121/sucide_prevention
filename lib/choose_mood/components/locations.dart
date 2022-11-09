import 'package:flutter/material.dart';
import 'package:sucide_prevention/utils.dart';

class Locations extends StatefulWidget {
  final String title;
  final Function(String location) onAnswer;
  const Locations({Key? key, required this.title, required this.onAnswer}) : super(key: key);

  @override
  State<Locations> createState() => _LocationsState();
}

class _LocationsState extends State<Locations> {
  String select = '';
  FocusNode focusNode = FocusNode();

  void _onAnswer(String location) {
    setState(() {
      widget.onAnswer(location);
      select = location;
    });
  }

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      print('focus');
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(widget.title, style: ThemeText.titleStyle),
        Expanded(
          child: ListView(
            physics: focusNode.hasFocus ? const ScrollPhysics() : const NeverScrollableScrollPhysics(),
            children: [
              LocationButton(title: '溫暖的家', select: select, iconPath: 'resources/image/button/location/house.png', onPressed: (title) => _onAnswer(title)),
              LocationButton(title: '公司', select: select, iconPath: 'resources/image/button/location/employee.png', onPressed: (title) => _onAnswer(title)),
              LocationButton(title: '學校', select: select, iconPath: 'resources/image/button/location/school.png', onPressed: (title) => _onAnswer(title)),
              LocationButton(title: '朋友家', select: select, iconPath: 'resources/image/button/location/friend.png', onPressed: (title) => _onAnswer(title)),
              Padding(
                padding: EdgeInsets.fromLTRB(h * 0.13, 0, 0, 0),
                child: Row(
                  children: [
                    const Text('其他', style: ThemeText.subtitleStyle),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 150,
                      child: TextField(
                        focusNode: focusNode,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Color(0xffE0E0E0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ),
                          hintText: '請輸入地點',
                        ),
                        onChanged: (value) => _onAnswer(value),
                        onSubmitted: (value) => _onAnswer(value),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        const SizedBox(),
      ],
    );
  }
}

class LocationButton extends StatelessWidget {
  final String title;
  final String iconPath;
  final String select;
  final Function(String title) onPressed;
  const LocationButton({Key? key, required this.title, required this.iconPath, required this.onPressed, required this.select}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return InkWell(
      splashColor: Colors.greenAccent,
      onTap: () => onPressed(title),
      child: Padding(
        padding: EdgeInsets.fromLTRB(h * 0.1, 0, 0, 0),
        child: Row(
          children: [
            Container(
                padding: EdgeInsets.all(h * 0.01),
                margin: EdgeInsets.all(h * 0.005),
                decoration: BoxDecoration(
                  color: select == title ? const Color(0xffDDEBEB) : Colors.transparent,
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                ),
                child: Image.asset(iconPath, width: h * 0.08)),
            const SizedBox(width: 10),
            Text(title, style: ThemeText.subtitleStyle),
          ],
        ),
      ),
    );
  }
}
