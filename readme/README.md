# doc
## question.json
>儲存情緒選項的問題，以樹狀的方式儲存。

![照片](img\E27D5065-54E5-4D5E-8D84-1B3301629D07.jpg)
```json
"痛苦": {
    "attribute": "options",
    "child": {
        "身體": {
            "attribute": "scale",
            "child":{}
        }
    }
},
```
### attribute
* options : 選擇按鈕
* scale : 1~5線性刻度選項
* child : 選擇後的下個問題

## 架構
* lib: 所有的介面程式碼
  * auth: 有關登入/註冊的介面
  * home:包含chose_mood和emergency_survial_kit
  * chose_mood: 選擇情緒的介面
  * emergency_survial_kit: 緊急救生包的介面
  * 的介面
  * tool: api/storge等等邏輯
  * utils: style設定
## 問卷
問題集存在`lib/choose_mood/doc/questions.dart`
* allQuestions: 所有的問題
  * type: 問題類型：posNegMood,location,rattingBar,optionWheel,form,using,buttonOptipn,date
  * title: 問題的標題
  * options: 選項文字或顏色
* questionOrder: 問題的順序
