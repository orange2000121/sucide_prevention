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
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(widget.title, style: ThemeText.titleStyle),
        Column(
          children: [
            LocationButton(title: '溫暖的家', iconPath: 'resources/image/button/location/home.png', onPressed: (title) => widget.onAnswer(title)),
            LocationButton(title: '公司', iconPath: 'resources/image/button/location/company.png', onPressed: (title) => widget.onAnswer(title)),
            LocationButton(title: '學校', iconPath: 'resources/image/button/location/school.png', onPressed: (title) => widget.onAnswer(title)),
            LocationButton(title: '朋友家', iconPath: 'resources/image/button/location/friend.png', onPressed: (title) => widget.onAnswer(title)),
            Padding(
              padding: EdgeInsets.fromLTRB(h * 0.13, 0, 0, 0),
              child: Row(
                children: [
                  const Text('其他', style: ThemeText.subtitleStyle),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 150,
                    child: TextField(
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Color(0xffE0E0E0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        hintText: '請輸入地點',
                      ),
                      onSubmitted: (value) {
                        widget.onAnswer(value);
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        const SizedBox(),
      ],
    );
  }
}

class LocationButton extends StatelessWidget {
  final String title;
  final String iconPath;
  final Function(String title) onPressed;
  const LocationButton({Key? key, required this.title, required this.iconPath, required this.onPressed}) : super(key: key);

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
            Image.asset(iconPath, width: h * 0.12),
            const SizedBox(width: 10),
            Text(title, style: ThemeText.subtitleStyle),
          ],
        ),
      ),
    );
  }
}
