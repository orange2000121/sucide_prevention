/*
  type:posNegMood,location,rattingBar,optionWheel,form,using,buttonOptipn,date
*/
import 'package:flutter/material.dart';

class MoodDoc {
  static Map allQuestions = {
    "0": {
      "type": "posNegMood",
      "title": "選擇對應情緒的詞語",
      "options": ["正向情緒", "負面情緒"]
    },
    "1": {"type": "date", "title": "請輸入時間", "options": []},
    "2": {"type": "date", "title": "請輸入有衝動想法的時間", "options": []},
    "11": {
      "type": "location",
      "title": "請輸入地點",
      "options": ["溫軟的家", "公司", "學校", "朋友家", "其他"]
    },
    "3": {
      "type": "rattingBar",
      "title": "身體痛苦指數有幾分",
      "options": const [Color(0xffFFB5B5), Color(0xffFF9797), Color(0xffFF7575), Color(0xffFF5151), Color(0xffFF2D2D)]
    },
    "4": {
      "type": "rattingBar",
      "title": "情緒痛苦指數有幾分",
      "options": const [Color(0xffFFB5B5), Color(0xffFF9797), Color(0xffFF7575), Color(0xffFF5151), Color(0xffFF2D2D)]
    },
    "5": {
      "type": "rattingBar",
      "title": "今天的快樂指數有幾分",
      "options": const [Color(0xffFFB5B5), Color(0xffFF9797), Color(0xffFF7575), Color(0xffFF5151), Color(0xffFF2D2D)]
    },
    "6": {
      "type": "rattingBar",
      "title": "想要自殺的衝動有幾分?",
      "options": const [Color(0xffFFB5B5), Color(0xffFF9797), Color(0xffFF7575), Color(0xffFF5151), Color(0xffFF2D2D)]
    },
    "7": {
      "type": "rattingBar",
      "title": "想要自傷的衝動有幾分?",
      "options": const [Color(0xffFFB5B5), Color(0xffFF9797), Color(0xffFF7575), Color(0xffFF5151), Color(0xffFF2D2D)]
    },
    "8": {
      "type": "rattingBar",
      "title": "這個情緒感受幾分呢",
      "options": const [Color(0xffFFB5B5), Color(0xffFF9797), Color(0xffFF7575), Color(0xffFF5151), Color(0xffFF2D2D)]
    },
    "9": {
      "type": "optionWheel",
      "title": "使用方式/數量",
      "options": [
        ["口服", "注射"],
        ["100g", "200g", "300g"]
      ]
    },
    "10": {
      "type": "optionWheel",
      "title": "種類",
      "options": [
        ["安非他命", "烈酒", "搖頭丸", "強力膠"]
      ]
    },
    "12": {"type": "form", "title": "有什麼要補充說明?", "options": []},
    "13": {"type": "form", "title": "有其他其情緒?告訴我吧", "options": []},
    "14": {"type": "using", "title": "緊急救生包使用情形", "options": []},
    "15": {
      "type": "buttonOptipn",
      "title": "有哪種衝動想法?",
      "options": ["自殺", "自傷"]
    },
    "16": {
      "type": "buttonOptipn",
      "title": "請選擇今天的心情狀態",
      "options": ["快樂", "痛苦", "衝動想法", "酒精/毒品", "其他情緒"]
    },
  };

  static Map questionOrder = {
    "main": [16],
    "痛苦": [3, 4, 0, 1, 11],
    "快樂": [5, 1, 11, 12],
    "衝動想法": [15],
    "自殺": [6, 2, 11, 14],
    "自傷": [7, 2, 11, 14],
    "酒精/毒品": [9, 10, 2, 11, 14],
    "其他情緒": [13, 8, 1, 11]
  };
}
