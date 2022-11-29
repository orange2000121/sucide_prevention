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
    "22": {"type": "date", "title": "請輸入發生的時間", "options": []},
    "11": {
      "type": "location",
      "title": "請輸入地點",
      "options": ["溫軟的家", "公司", "學校", "朋友家", "其他"]
    },
    "3": {
      "type": "rattingBar",
      "title": "身體痛苦指數有幾分",
      "options": const [Color(0xffFFE5C0), Color(0xffFDD29B), Color(0xffFBA953), Color(0xffF58229), Color(0xffDF6F19)]
    },
    "4": {
      "type": "rattingBar",
      "title": "情緒痛苦指數有幾分",
      "options": const [Color.fromARGB(102, 0, 92, 51), Color.fromARGB(128, 0, 92, 51), Color.fromARGB(153, 0, 92, 51), Color.fromARGB(204, 0, 92, 51), Color.fromARGB(255, 0, 92, 51)]
    },
    "5": {
      "type": "rattingBar",
      "title": "今天的快樂指數有幾分",
      "options": const [Color(0xffB2FFB2), Color(0xff8EFF8E), Color(0xff6DF96D), Color(0xff58F758), Color(0xff1EE81E)]
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
      "options": {
        "wheel": [
          ["口服", "注射"],
          ["100g", "200g", "300g"]
        ],
        "input": []
      }
    },
    "10": {
      "type": "optionWheel",
      "title": "種類",
      "options": {
        "wheel": [
          ["安非他命", "烈酒", "搖頭丸", "強力膠"]
        ],
        "input": []
      }
    },
    "19": {
      "type": "optionWheel",
      "title": "數量/種類",
      "options": {
        "wheel": [],
        "input": ["按此輸入食物種類", "按此輸入數量"]
      }
    },
    "20": {
      "type": "optionWheel",
      "title": "種類/數量",
      "options": {
        "wheel": [
          ["水果酒", "紅/白酒", "烈酒"]
        ],
        "input": ["按此輸入數量"]
      }
    },
    "21": {
      "type": "optionWheel",
      "title": "使用方法/數量",
      "options": {
        "wheel": [
          ["口服", "注射"]
        ],
        "input": ["按此輸入數量"]
      }
    },
    "12": {"type": "form", "title": "有什麼要補充說明?", "options": []},
    "13": {"type": "form", "title": "有其他其情緒?告訴我吧", "options": []},
    "14": {"type": "using", "title": "緊急救生包使用情形", "options": []},
    "15": {
      "type": "buttonOptipn",
      "title": "有哪種衝動想法?",
      "options": ["自殺", "自傷", "酒精", "毒品", "暴食"]
    },
    "16": {
      "type": "buttonOptipn",
      "title": "請選擇今天的心情狀態",
      "options": ["快樂", "痛苦", "衝動想法", "其他情緒"]
    },
    "17": {
      "type": "negMood",
      "title": "選擇對應情緒的詞語",
      "options": ["負面情緒"]
    },
    "18": {
      "type": "posMood",
      "title": "選擇對應情緒的詞語",
      "options": ["正面情緒"]
    },
  };

  static Map questionOrder = {
    "main": [16],
    "快樂": [5, 18, 1, 11, 12],
    "痛苦": [3, 4, 17, 1, 11],
    "衝動想法": [15],
    "自殺": [6, 2, 11, 14],
    "自傷": [7, 2, 11, 14],
    "酒精": [20, 2, 11, 14],
    "毒品": [21, 2, 11, 14],
    "暴食": [19, 22, 11, 14],
    "酒精/毒品": [9, 10, 2, 11, 14],
    "其他情緒": [13, 8, 1, 11, 14]
  };
  static Map moodData = {
    "positive": [
      "冷靜",
      "自信",
      "知足",
      "渴望",
      "狂喜",
      "投入",
      "興奮",
      "感激",
      "開心",
      "幽默",
      "受啟發",
      "有愛",
      "積極",
      "樂觀",
      "耐心",
      "安心",
      "放鬆",
      "放心",
      "可靠",
      "意外",
      "極愉快",
      "無畏",
      "高興",
      "活力",
      "熱情",
      "快樂",
      "精力充沛",
      "平靜",
      "好玩",
      "重獲新生",
      "滿意",
      "極好"
    ],
    "negative": [
      "生氣",
      "害怕",
      "困擾",
      "焦慮",
      "羞愧",
      "無聊",
      "困惑",
      "垂頭喪氣",
      "沮喪",
      "失望",
      "噁心",
      "尷尬",
      "挫折",
      "罪惡",
      "不安全",
      "嫉妒",
      "孤獨",
      "憤恨不平",
      "難過",
      "不自在",
      "有壓力",
      "擔心",
      "過度疲憊",
      "極度不安",
      "空虛",
      "精疲力盡",
      "憤怒",
      "被激怒",
      "心煩意亂",
      "萎靡不振",
      "緊張",
      "麻木",
      "疲憊"
    ]
  };
}
