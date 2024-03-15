import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sucide_prevention/choose_mood/components/chose_date.dart';
import 'package:sucide_prevention/choose_mood/components/locations.dart';
import 'package:sucide_prevention/choose_mood/components/mood_rating_bar.dart';
import 'package:sucide_prevention/choose_mood/components/button_options.dart';
import 'package:sucide_prevention/choose_mood/components/negative_mood.dart';
import 'package:sucide_prevention/choose_mood/components/positive_mood.dart';
import 'package:sucide_prevention/choose_mood/components/positive_negative_mood.dart';
import 'package:sucide_prevention/choose_mood/components/short_answer.dart';
import 'package:sucide_prevention/choose_mood/components/used.dart';
import 'package:sucide_prevention/choose_mood/components/wheel_chose.dart';
import 'package:sucide_prevention/choose_mood/doc/questions.dart';
import 'package:sucide_prevention/choose_mood/pagination/chose_mood_end.dart';
import 'package:sucide_prevention/tool/mood_db.dart';
import 'package:sucide_prevention/utils.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sucide_prevention/auth.dart';

class MoodHome extends StatefulWidget {
  const MoodHome({Key? key}) : super(key: key);

  @override
  State<MoodHome> createState() => _MoodHomeState();
}

class _MoodHomeState extends State<MoodHome> {
  /// 輸入問題標籤，輸出製作好的問卷頁面
  ///
  /// args : List<int> questions
  ///
  /// return : List<Widget> pages
  ///
  final AuthService auth = AuthService();

  List<Widget> questionPagination = [];
  int pageIndex = 0;
  List<Map<String, dynamic>> answers = [];
  Map<String, List> answerTemp = {};
  List<Widget> makeQuestionPagination(List questions, {List<Widget> lastQuestionPagination = const []}) {
    questionPagination = [];
    questionPagination.addAll(lastQuestionPagination);
    for (int i = 0; i < questions.length; i++) {
      Map question = MoodDoc.allQuestions[questions[i].toString()];
      switch (question['type']) {
        case "rattingBar":
          questionPagination.add(MoodRatingBar(
            title: question['title'],
            colors: question['options'],
            onAnswer: (String answer) {
              answerTemp = {
                question['title']: [answer],
              };
            },
          ));
          break;
        case "posNegMood":
          questionPagination.add(PosNegMood(
            onAnswer: (List pos, List neg) {
              answerTemp = {
                '正面情緒': pos,
                '負面情緒': neg,
              };
            },
          ));
          break;
        case "negMood":
          questionPagination.add(NegativeMood(
            onAnswer: (List neg) {
              answerTemp = {
                '負面情緒': neg,
              };
            },
          ));
          break;
        case "posMood":
          questionPagination.add(PositiveMood(
            onAnswer: (List pos) {
              answerTemp = {
                '正面情緒': pos,
              };
            },
          ));
          break;
        case "buttonOptipn":
          questionPagination.add(ButtonOptions(
            title: question['title'],
            options: question['options'],
            onAnswer: (option) {
              answerTemp = {
                question['title']: [option],
              };
              answers.add(answerTemp);
              setState(() {
                makeQuestionPagination(
                  MoodDoc.questionOrder[option],
                  lastQuestionPagination: questionPagination.sublist(0, ++pageIndex),
                );
              });
              answerTemp = {};
            },
          ));
          break;
        case "date":
          questionPagination.add(ChoseDate(
            title: question['title'],
            onAnswer: (date) {
              answerTemp = {
                question['title']: [date]
              };
            },
          ));
          break;
        case "location":
          questionPagination.add(Locations(
            title: question['title'],
            onAnswer: (String location) {
              answerTemp = {
                question['title']: [location]
              };
            },
          ));
          break;
        case "optionWheel":
          questionPagination.add(WheelChoose(
            title: question['title'],
            options: question['options'],
            onAnswer: (List answer) {
              answerTemp = {
                question['title']: answer,
              };
            },
          ));
          break;
        case "form":
          questionPagination.add(ShortAnswer(
            title: question['title'],
            onAnswer: (String answer) {
              answerTemp = {
                question['title']: [answer],
              };
            },
          ));
          break;
        case "using":
          questionPagination.add(Used(
            title: question['title'],
            onAnswer: (Map answer) {
              answerTemp = {
                question['title']: [answer],
              };
            },
          ));
          break;
      }
    }
    return questionPagination;
  }

  PageController pageController = PageController();
  Widget moodHomeBottom() {
    return questionPagination[pageIndex] is! ButtonOptions //如果是ButtonOptions，就不顯示下一步及送出
        ? pageIndex == questionPagination.length - 1 && pageIndex != 0 //如果是最後一頁，就顯示送出
            ? SendUp(onTap: () async {
                if (answerTemp.isEmpty) {
                  Fluttertoast.showToast(msg: '需填寫問題');
                  return;
                }

                if (answers.length < questionPagination.length) {
                  //加入最後ㄧ個問題的回答
                  answers.add(answerTemp);
                }
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ChoseMoodEnd(answers: answers)), (route) => false);
                String now = DateTime.now().toString();
                // insert to mood_db on sqlite
                await MoodDB().insertMood(answers, now);

                // firestore 上傳
                FirebaseFirestore db = FirebaseFirestore.instance;
                await db.collection(auth.getuserdata()).doc('mood').set({now: answers}, SetOptions(merge: true));

                Fluttertoast.cancel();
                if (!mounted) return;
                Fluttertoast.showToast(msg: '上傳成功');
              })
            : NextQuestion(onTap: () {
                if (pageIndex < questionPagination.length - 1) {
                  if (answerTemp.isNotEmpty) {
                    answers.add(answerTemp);
                    answerTemp = {};
                    pageController.animateToPage(
                      ++pageIndex,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                    );
                    setState(() {});
                  } else {
                    Fluttertoast.showToast(msg: '需填寫問題');
                  }
                }
                FocusManager.instance.primaryFocus?.unfocus();
              })
        : const SizedBox();
  }

  @override
  void initState() {
    super.initState();
    makeQuestionPagination(MoodDoc.questionOrder['main']);
  }

  @override
  Widget build(BuildContext context) {
    double topPadding = MediaQuery.of(context).padding.top;
    try {
      pageController.animateToPage(pageIndex, duration: const Duration(milliseconds: 400), curve: Curves.easeInOut); // 換頁動畫
      pageController = PageController(initialPage: pageIndex); //初始化pageController
    } catch (e) {
      pageController = PageController(initialPage: pageIndex); //初始化pageController
    }
    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('resources/image/background/splash_background.png'), fit: BoxFit.cover)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              pageIndex == 0
                  ? SizedBox(height: topPadding + 40)
                  : Padding(
                      padding: EdgeInsets.only(top: topPadding),
                      child: Row(children: [
                        IconButton(
                          iconSize: 40,
                          onPressed: () {
                            if (pageIndex == 1) {
                              pageIndex = 0;
                              setState(() {
                                makeQuestionPagination(MoodDoc.questionOrder['main']);
                              });
                            } else if (pageIndex < questionPagination.length) {
                              answers.removeLast();
                              pageIndex--;
                              pageController.animateToPage(
                                pageIndex,
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.easeInOut,
                              );
                            }
                          },
                          icon: const Icon(Icons.keyboard_double_arrow_left),
                        )
                      ]),
                    ),
              Expanded(
                child: PageView(
                  controller: pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: questionPagination,
                ),
              ),
              moodHomeBottom()
            ],
          )),
    );
  }
}

class NextQuestion extends StatelessWidget {
  final VoidCallback onTap;
  const NextQuestion({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            onTap: onTap,
            child: Row(
              children: const [
                Text('下ㄧ頁', style: ThemeText.buttonStyle),
                Icon(Icons.keyboard_double_arrow_right, size: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SendUp extends StatelessWidget {
  final VoidCallback onTap;
  const SendUp({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ElevatedButton(
        onPressed: onTap,
        style: ThemeButton.mainButton,
        child: const Padding(
          padding: EdgeInsets.fromLTRB(30, 7, 30, 7),
          child: Text('送出', style: ThemeText.buttonStyle),
        ),
      ),
    );
  }
}
