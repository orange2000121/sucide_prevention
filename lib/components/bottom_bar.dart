import 'package:flutter/material.dart';
import 'package:sucide_prevention/utils.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Select _select = Select();
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void changeSelect() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFFD6DCDB),
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        BottomButton(
          imageName: 'resources/image/button/mental.png',
          buttonIdx: 0,
          select: _select,
          change: changeSelect,
        ),
        BottomButton(
          imageName: 'resources/image/button/satisfaction rate.png',
          buttonIdx: 1,
          select: _select,
          change: changeSelect,
        ),
        BottomButton(
          imageName: 'resources/image/button/user.png',
          buttonIdx: 2,
          select: _select,
          change: changeSelect,
        ),
      ]),
    );
  }
}

class Select {
  int bottomBarIndex = 0;
}

class BottomButton extends StatelessWidget {
  final String imageName;
  final Select select;
  final int buttonIdx;
  final Function change;
  const BottomButton({Key? key, required this.imageName, required this.select, required this.buttonIdx, required this.change}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          select.bottomBarIndex = buttonIdx;
          change();
        },
        style: select.bottomBarIndex == buttonIdx
            ? ElevatedButton.styleFrom(primary: Colors.white, shadowColor: Colors.black)
            : ElevatedButton.styleFrom(primary: Colors.transparent, shadowColor: Colors.transparent),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Image.asset(imageName, width: 60, height: 60),
          const SizedBox(width: 5),
        ]),
      ),
    );
  }
}
