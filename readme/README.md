# doc

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
## 資料庫
使用Firebase,firestore架構
* user
  * mood
    * 每次選擇情緒的結果
  * profile
    * 手錶編號
    * 姓名
    * 生份證
    * 生日
    * id