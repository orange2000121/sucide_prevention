# doc
## question.json
>儲存情緒選項的問題，以束狀的方式儲存。

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

