# AGQ 外部測試指南（External Test Guide）

## 測試網址

```
[請 Founder 填入正式外測網址]
```

範例：`https://agq.example.com/`

---

## 這個遊戲是什麼？

AGQ（Anime Guess / 動漫猜題）是一個動漫主題問答遊戲。玩家從 10 款熱門動漫作品中選擇一款，回答與該作品相關的題目，系統在作答結束後顯示成績與正確答案。

目前題庫：
- 鬼滅之刃（100 題）
- 其他 9 款作品各 50 題（進擊的巨人、咒術迴戰、火影忍者、死亡筆記本、One Piece、間諜家家酒、膽大黨、葬送的芙莉蓮、Solo Leveling）

---

## 測試者要做什麼

### 建議測試流程

**第一輪：從熟悉的作品開始**
1. 打開測試網址，點選你最熟悉的動漫作品
2. 選擇：題型=**混搭**、難易度=**不限**、題數=5 題
3. 完成作答，查看成績與正確答案

**第二輪：換一款不熟的作品**
1. 回首頁，選一款你平常比較少看的作品
2. 選擇不同難易度（建議試試**困難**或**極難**）
3. 作答完成後，若發現題目有問題（答案錯誤、敘述不清等），點「這題有問題？」送出回饋

**第三輪：試試單一題型**
1. 分別選擇**選擇題**和**填字題**各一次，感受不同題型的差異

**第四輪：試試投稿功能（選做）**
1. 點選上方導覽的「投稿題目」
2. 填入題目資料並送出，觀察是否正常完成

---

## 可測試的組合

| 項目 | 選項 |
|---|---|
| 作品 | 10 款任選（建議至少試 2~3 款） |
| 題型 | 混搭 / 選擇題 / 填字題 |
| 難易度 | 不限 / 簡單 / 普通 / 困難 / 極難 |
| 題數 | 5 / 10 / 20 題 |

> **提示**：選擇**極難**難易度時，建議選擇**鬼滅之刃**（題量最多，極難題最充足）。

---

## 如何回報問題

發現問題請依以下格式回報（可用文字或截圖）：

```
作品名稱：
題目內容（盡量完整引用）：
問題類型：
  [ ] 答案錯誤（正確答案應為：_______）
  [ ] 題目敘述不清
  [ ] 選項有問題
  [ ] 難易度不準（建議難易度：簡單 / 普通 / 困難 / 極難）
  [ ] 系統錯誤 / 頁面異常
  [ ] 其他（說明：_______）
截圖：（如有）
瀏覽器 / 裝置：（例如：Chrome / iPhone 15）
```

> 也可以直接在結果頁每題下方點「這題有問題？」送出內建回饋，管理員會在後台收到通知。

---

## 目前已知限制

以下限制為目前 MVP 的設計範圍，非 Bug：

| 限制 | 說明 |
|---|---|
| 無會員系統 | 作答進度不會跨裝置保存，換瀏覽器或清除 Cookie 後無法查看過往成績 |
| 回饋非即時生效 | 玩家送出的題目回饋需由管理員審核後才可能調整題目，不會立即反映 |
| 難易度分數動態調整 | 每次作答後系統會微調題目難易度分數，長期使用後難易度分布會有輕微變化 |
| 同日回饋限一次 | 同一玩家對同一題目每天最多提交一次回饋（重複送出時系統靜默處理，不顯示錯誤） |
| 投稿審核非即時 | 玩家投稿的新題目需等待管理員審核，通過後才會進入題庫 |
| 題庫回饋系統 | 目前無自動下架或自動修正機制，管理員手動處理後台回饋 |

---

## 外測觀察指標（管理員用）

外測期間可定期查詢以下 SQL 了解使用狀況：

### 完成作答率
```sql
SELECT
  COUNT(*) AS total_sessions,
  SUM(CASE WHEN status = 'completed' THEN 1 ELSE 0 END) AS completed,
  ROUND(100 * SUM(CASE WHEN status = 'completed' THEN 1 ELSE 0 END) / COUNT(*), 1) AS completion_pct
FROM quiz_sessions;
```

### 各作品被玩次數
```sql
SELECT aw.title, COUNT(*) AS quiz_count
FROM quiz_sessions qs
JOIN anime_works aw ON aw.id = qs.anime_work_id
GROUP BY aw.id, aw.title
ORDER BY quiz_count DESC;
```

### 題目回饋數量與類型分布
```sql
SELECT feedback_type, COUNT(*) AS cnt
FROM question_feedbacks
GROUP BY feedback_type
ORDER BY cnt DESC;
```

### 爭議題比例
```sql
SELECT
  COUNT(*) AS total_feedbacks,
  SUM(CASE WHEN feedback_type = 'wrong_answer' THEN 1 ELSE 0 END) AS wrong_answer_cnt,
  ROUND(100 * SUM(CASE WHEN feedback_type = 'wrong_answer' THEN 1 ELSE 0 END) / COUNT(*), 1) AS wrong_answer_pct
FROM question_feedbacks;
```

### 投稿量統計
```sql
SELECT status, COUNT(*) AS cnt
FROM questions
WHERE origin = 'submission'
GROUP BY status;
```
