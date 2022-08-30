import 'package:flutter/material.dart';
import 'package:sucide_prevention/utils.dart';

// class BottomBar extends StatefulWidget {
//   const BottomBar({Key? key}) : super(key: key);

//   @override
//   State<BottomBar> createState() => _BottomBarState();
// }

// class _BottomBarState extends State<BottomBar> with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   final Select _select = Select();
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(vsync: this);
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _controller.dispose();
//   }

//   void changeSelect() {
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         color: const Color(0xFFD6DCDB),
//       ),
//       child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//         BottomButton(
//           imageName: 'resources/image/button/mental.png',
//           buttonIdx: 0,
//           select: _select,
//           change: changeSelect,
//         ),
//         BottomButton(
//           imageName: 'resources/image/button/satisfaction rate.png',
//           buttonIdx: 1,
//           select: _select,
//           change: changeSelect,
//         ),
//         BottomButton(
//           imageName: 'resources/image/button/user.png',
//           buttonIdx: 2,
//           select: _select,
//           change: changeSelect,
//         ),
//       ]),
//     );
//   }
// }

// class Select {
//   int bottomBarIndex = 0;
// }

class BottomButton extends StatelessWidget {
  final String imageName;
  final int select;
  final int buttonIdx;
  // final Function change;
  const BottomButton({Key? key, required this.imageName, required this.select, required this.buttonIdx}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: select == buttonIdx ? Colors.white : Colors.transparent,
      ),
      child: Image.asset(imageName, width: 50, height: 50),
    );
  }
}
