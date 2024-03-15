import 'package:flutter/material.dart';
import 'package:sucide_prevention/home/components/gradient_button.dart';
import 'package:sucide_prevention/home/home_page.dart';
import 'package:sucide_prevention/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpTell extends StatefulWidget {
  const HelpTell({super.key});

  @override
  State<HelpTell> createState() => _HelpTellState();
}

class _HelpTellState extends State<HelpTell> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('resources/image/background/splash_background.png'),
          fit: BoxFit.cover,
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('撥打關懷專線', style: ThemeText.titleStyle),
            Column(
              children: const [
                HelpTellItem(title: "安心專線：1925 依舊愛我", number: "1925"),
                HelpTellItem(title: "男性關懷專線：0800-013-999", number: "0800013999"),
                HelpTellItem(title: "台北市衛生局 心理衛生中心", number: "023393885"),
                HelpTellItem(title: "董氏基金會自殺防治網", number: "0227766133"),
                HelpTellItem(title: "張老師全球資訊網", number: "1980"),
                HelpTellItem(title: "台北市生命線協會：各縣市生命線", number: "1995"),
                HelpTellItem(title: "台北醫學大學附設醫院防治專線", number: "02-2737-2181"),
                HelpTellItem(title: "台北馬偕 轉3680-3683", number: "022543-3535"),
                HelpTellItem(title: "淡水馬偕 轉2726-2728", number: "022809-4661"),
              ],
            ),
            GradientButton(
                width: 170,
                height: 50,
                borderRadius: BorderRadius.circular(50),
                gradient: const LinearGradient(colors: [Color(0xffEEEBEB), Color(0xffC9D1DD)]),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const HomePage()), (route) => false);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    Icon(Icons.home, size: 45, color: Color.fromARGB(255, 68, 67, 67)),
                    Text('回主頁', style: TextStyle(color: Colors.black, fontSize: 26)),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

class HelpTellItem extends StatelessWidget {
  final String title;
  final String number;

  const HelpTellItem({super.key, required this.title, required this.number});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
      child: Row(
        children: [
          Image.asset('resources/image/decorate/grid (1).png'),
          TextButton(
            onPressed: () => launchUrl(Uri.parse('tel:$number')),
            child: Text(title, style: ThemeText.contentStyle),
          ),
        ],
      ),
    );
  }
}
