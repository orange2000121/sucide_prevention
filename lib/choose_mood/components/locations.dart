import 'package:flutter/material.dart';
import 'package:sucide_prevention/utils.dart';

class Locations extends StatefulWidget {
  final String title;
  const Locations({Key? key, required this.title}) : super(key: key);

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
            const LocationButton(title: '溫暖的家', iconPath: 'resources/image/button/location/home.png'),
            const LocationButton(title: '公司', iconPath: 'resources/image/button/location/company.png'),
            const LocationButton(title: '學校', iconPath: 'resources/image/button/location/school.png'),
            const LocationButton(title: '朋友家', iconPath: 'resources/image/button/location/friend.png'),
            Padding(
              padding: EdgeInsets.fromLTRB(h * 0.13, 0, 0, 0),
              child: Row(
                children: const [
                  Text('其他', style: ThemeText.subtitleStyle),
                  SizedBox(width: 10),
                  SizedBox(
                    width: 150,
                    child: TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xffE0E0E0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        hintText: '請輸入地點',
                      ),
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
  const LocationButton({Key? key, required this.title, required this.iconPath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.fromLTRB(h * 0.1, 0, 0, 0),
      child: InkWell(
        onTap: () {},
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
