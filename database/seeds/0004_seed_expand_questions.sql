-- 依賴順序：此 seed 須在 0003_seed_tw_external_test_questions.sql 之後執行
-- 原因：依賴 anime_works.slug='demon-slayer' 作品資料已存在
-- 完整重建順序：migrations → 0001_seed_admin_user.php → 0002_seed_banned_words.php → 0003_seed_tw_external_test_questions.sql → 0004_seed_expand_questions.sql

START TRANSACTION;

-- 鬼滅之刃（demon-slayer）題庫擴充：現有 5 題（approved） + 新增 95 題（46 選擇題 + 49 填字題）= 100 題
-- Founder 決策：鬼滅之刃優先擴充到 100 題，其餘 9 款作品本次不擴充，維持現有 5 題

INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', '冨岡義勇是鬼殺隊的哪一柱？', '["水柱","風柱","蛇柱","蟲柱"]', '水柱', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '冨岡義勇是鬼殺隊的哪一柱？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', '胡蝶忍是鬼殺隊的哪一柱？', '["蟲柱","花柱","岩柱","音柱"]', '蟲柱', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '胡蝶忍是鬼殺隊的哪一柱？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', '甘露寺蜜璃是鬼殺隊的哪一柱？', '["戀柱","霞柱","蛇柱","炎柱"]', '戀柱', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '甘露寺蜜璃是鬼殺隊的哪一柱？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', '伊黑小芭內是鬼殺隊的哪一柱？', '["蛇柱","風柱","水柱","蟲柱"]', '蛇柱', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '伊黑小芭內是鬼殺隊的哪一柱？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', '不死川實彌是鬼殺隊的哪一柱？', '["風柱","霞柱","音柱","炎柱"]', '風柱', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '不死川實彌是鬼殺隊的哪一柱？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', '時透無一郎是鬼殺隊的哪一柱？', '["霞柱","水柱","戀柱","蛇柱"]', '霞柱', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '時透無一郎是鬼殺隊的哪一柱？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', '宇髓天元是鬼殺隊的哪一柱？', '["音柱","風柱","蟲柱","霞柱"]', '音柱', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '宇髓天元是鬼殺隊的哪一柱？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', '煉獄杏壽郎是鬼殺隊的哪一柱？', '["炎柱","水柱","戀柱","音柱"]', '炎柱', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '煉獄杏壽郎是鬼殺隊的哪一柱？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', '鬼殺隊的最高領導者是？', '["產屋敷耀哉","鬼舞辻無慘","繼國緣壹","桑島慈悟郎"]', '產屋敷耀哉', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '鬼殺隊的最高領導者是？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', '鬼滅之刃中所有鬼的始祖、最終大反派是？', '["鬼舞辻無慘","黑死牟","童磨","猗窩座"]', '鬼舞辻無慘', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '鬼滅之刃中所有鬼的始祖、最終大反派是？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', '鬼舞辻無慘麾下最精銳的鬼族合稱為？', '["十二鬼月","十二神將","十二天將","十二使徒"]', '十二鬼月', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '鬼舞辻無慘麾下最精銳的鬼族合稱為？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', '十二鬼月中戰力較強的一群被稱為？', '["上弦","下弦","上位","主力"]', '上弦', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '十二鬼月中戰力較強的一群被稱為？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', '在無限列車篇與煉獄杏壽郎交戰的上弦之參是？', '["猗窩座","童磨","黑死牟","半天狗"]', '猗窩座', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '在無限列車篇與煉獄杏壽郎交戰的上弦之參是？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', '上弦之壹「黑死牟」與繼國緣壹的關係是？', '["兄長","弟弟","兒子","徒弟"]', '兄長', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '上弦之壹「黑死牟」與繼國緣壹的關係是？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', '被視為所有呼吸法起源的劍術是？', '["日之呼吸","水之呼吸","雷之呼吸","風之呼吸"]', '日之呼吸', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '被視為所有呼吸法起源的劍術是？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', '我妻善逸能穩定使出的雷之呼吸招式是第幾式？', '["壹之型","貳之型","參之型","肆之型"]', '壹之型', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '我妻善逸能穩定使出的雷之呼吸招式是第幾式？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', '我妻善逸的雷之呼吸壹之型招式名稱是？', '["霹靂一閃","火車","碎冰","拔刀"]', '霹靂一閃', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '我妻善逸的雷之呼吸壹之型招式名稱是？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', '嘴平伊之助自創、獨力習得的呼吸法是？', '["獸之呼吸","蟲之呼吸","花之呼吸","岩之呼吸"]', '獸之呼吸', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '嘴平伊之助自創、獨力習得的呼吸法是？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', '嘴平伊之助自幼在山中被什麼動物扶養長大？', '["山豬","狼","熊","猴子"]', '山豬', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '嘴平伊之助自幼在山中被什麼動物扶養長大？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', '竈門炭治郎最初拜入哪位師父門下修行？', '["鱗瀧左近次","桑島慈悟郎","冨岡義勇","產屋敷耀哉"]', '鱗瀧左近次', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '竈門炭治郎最初拜入哪位師父門下修行？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', '教導我妻善逸的師父是？', '["桑島慈悟郎","鱗瀧左近次","冨岡義勇","煉獄杏壽郎"]', '桑島慈悟郎', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '教導我妻善逸的師父是？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', '竈門禰豆子變成鬼後，平時用什麼道具遮住嘴巴以壓抑衝動？', '["竹筒","面具","布條","鈴鐺"]', '竹筒', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '竈門禰豆子變成鬼後，平時用什麼道具遮住嘴巴以壓抑衝動？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', '竈門禰豆子作為鬼的特殊能力稱為？', '["爆血","血鬼術・幻惑","分身之術","結界"]', '爆血', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '竈門禰豆子作為鬼的特殊能力稱為？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', '宇髓天元的出身背景是？', '["忍者","武士","商人","醫生"]', '忍者', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '宇髓天元的出身背景是？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', '鬼殺隊士制服外觀主要以什麼顏色為主？', '["黑色","白色","紅色","藍色"]', '黑色', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '鬼殺隊士制服外觀主要以什麼顏色為主？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', '鬼殺隊中負責救助傷患、處理善後的非戰鬥人員稱為？', '["隱","育手","柱","鬼殺官"]', '隱', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '鬼殺隊中負責救助傷患、處理善後的非戰鬥人員稱為？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', '培育新進隊士的資深指導者在鬼殺隊中稱為？', '["育手","隱","頭目","統帥"]', '育手', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '培育新進隊士的資深指導者在鬼殺隊中稱為？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', '鬼滅之刃的故事背景設定在日本哪個時代？', '["大正時代","江戶時代","明治時代","昭和時代"]', '大正時代', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '鬼滅之刃的故事背景設定在日本哪個時代？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', '上弦之陸由兩名鬼組成，其中之一「墮姬」的兄長身分是？', '["妓夫太郎","半天狗","玉壺","童磨"]', '妓夫太郎', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '上弦之陸由兩名鬼組成，其中之一「墮姬」的兄長身分是？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', '上弦之肆「半天狗」的血鬼術特徵是？', '["能分裂出多個情緒化身","操控水與魚","吐出毒霧","召喚分身鏡"]', '能分裂出多個情緒化身', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '上弦之肆「半天狗」的血鬼術特徵是？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', '上弦之伍「玉壺」的血鬼術與什麼容器意象密切相關？', '["花瓶","竹筒","扇子","燈籠"]', '花瓶', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '上弦之伍「玉壺」的血鬼術與什麼容器意象密切相關？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', '上弦之貳「童磨」平時偽裝成什麼身分潛伏人間？', '["教團教主","醫生","商人","藝伎"]', '教團教主', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '上弦之貳「童磨」平時偽裝成什麼身分潛伏人間？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', '胡蝶忍因體力不足以斬下鬼首，因此改用什麼方式討伐鬼？', '["注射藤花之毒","使用火焰","使用水刃","以太刀連續突刺"]', '注射藤花之毒', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '胡蝶忍因體力不足以斬下鬼首，因此改用什麼方式討伐鬼？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', '對鬼特別有效的毒液取材自哪種花卉？', '["藤花","彼岸花","櫻花","梅花"]', '藤花', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '對鬼特別有效的毒液取材自哪種花卉？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', '甘露寺蜜璃因特殊體質而擁有異於常人的什麼能力？', '["驚人怪力與柔軟度","飛行能力","隱身能力","讀心能力"]', '驚人怪力與柔軟度', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '甘露寺蜜璃因特殊體質而擁有異於常人的什麼能力？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', '不死川實彌與哪位隊士是親兄弟？', '["不死川玄彌","我妻善逸","嘴平伊之助","時透無一郎"]', '不死川玄彌', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '不死川實彌與哪位隊士是親兄弟？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', '時透無一郎成為柱之前，對自己的過去記憶狀態是？', '["幾乎喪失記憶","記憶超群","完全正常","刻意隱瞞"]', '幾乎喪失記憶', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '時透無一郎成為柱之前，對自己的過去記憶狀態是？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', '冨岡義勇與竈門炭治郎初次相遇的契機是？', '["冨岡義勇發現變成鬼的禰豆子","兩人是同鄉舊識","在鬼殺隊考試中對戰","冨岡義勇救了炭治郎的父親"]', '冨岡義勇發現變成鬼的禰豆子', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '冨岡義勇與竈門炭治郎初次相遇的契機是？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', '鬼殺隊新進隊士需要通過什麼考驗才能正式成為隊士？', '["最終選別","入隊筆試","柱の推薦","產屋敷家面談"]', '最終選別', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '鬼殺隊新進隊士需要通過什麼考驗才能正式成為隊士？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', '「最終選別」的地點通常設定在？', '["藤花遍布的山","竹林","廢棄神社","河岸"]', '藤花遍布的山', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '「最終選別」的地點通常設定在？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', '竈門炭治郎在最終選別中主要對抗的鬼是？', '["手鬼","沼鬼","蜘蛛鬼","血鬼術師"]', '手鬼', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '竈門炭治郎在最終選別中主要對抗的鬼是？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', '猗窩座生前作為人類時最擅長的武術是？', '["拳法","劍術","弓術","槍術"]', '拳法', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '猗窩座生前作為人類時最擅長的武術是？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', '猗窩座作戰時堅持不對什麼樣的對象出手？', '["女性","老弱之人","兒童","隊士"]', '女性', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '猗窩座作戰時堅持不對什麼樣的對象出手？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', '鬼殺隊士的武器統稱為？', '["日輪刀","斬鬼刀","破魔劍","降妖刀"]', '日輪刀', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '鬼殺隊士的武器統稱為？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', '竈門炭治郎踏上鬼殺隊之旅，最初的目的是？', '["讓禰豆子變回人類","報考武士","尋找失蹤的父親","調查鬼舞辻無慘的下落"]', '讓禰豆子變回人類', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '竈門炭治郎踏上鬼殺隊之旅，最初的目的是？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', '鬼想要變得更強，通常需要吃下什麼？', '["人類","動物","其他的鬼","靈魂"]', '人類', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '鬼想要變得更強，通常需要吃下什麼？');

INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', '竈門炭治郎和竈門禰豆子的姓氏是？', NULL, '竈門', '["竈門家"]', 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '竈門炭治郎和竈門禰豆子的姓氏是？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', '我妻善逸暗戀的對象是鬼殺隊中的哪位少女？', NULL, '竈門禰豆子', '["禰豆子"]', 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '我妻善逸暗戀的對象是鬼殺隊中的哪位少女？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', '嘴平伊之助平時戴著什麼動物造型的面具？', NULL, '山豬', '["山豬面具"]', 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '嘴平伊之助平時戴著什麼動物造型的面具？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', '冨岡義勇所屬的呼吸法是？', NULL, '水之呼吸', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '冨岡義勇所屬的呼吸法是？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', '胡蝶忍所屬的呼吸法是？', NULL, '蟲之呼吸', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '胡蝶忍所屬的呼吸法是？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', '甘露寺蜜璃所屬的呼吸法是？', NULL, '戀之呼吸', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '甘露寺蜜璃所屬的呼吸法是？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', '伊黑小芭內所屬的呼吸法是？', NULL, '蛇之呼吸', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '伊黑小芭內所屬的呼吸法是？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', '不死川實彌所屬的呼吸法是？', NULL, '風之呼吸', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '不死川實彌所屬的呼吸法是？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', '時透無一郎所屬的呼吸法是？', NULL, '霞之呼吸', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '時透無一郎所屬的呼吸法是？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', '宇髓天元所屬的呼吸法是？', NULL, '音之呼吸', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '宇髓天元所屬的呼吸法是？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', '煉獄杏壽郎所屬的呼吸法是？', NULL, '炎之呼吸', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '煉獄杏壽郎所屬的呼吸法是？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', '我妻善逸所屬的呼吸法是？', NULL, '雷之呼吸', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '我妻善逸所屬的呼吸法是？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', '嘴平伊之助自創的呼吸法是？', NULL, '獸之呼吸', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '嘴平伊之助自創的呼吸法是？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', '鬼殺隊最終首領（當主）的姓氏是？', NULL, '產屋敷', '["產屋敷家"]', 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '鬼殺隊最終首領（當主）的姓氏是？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', '鬼滅之刃中所有鬼的始祖、最終大反派是誰？', NULL, '鬼舞辻無慘', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '鬼滅之刃中所有鬼的始祖、最終大反派是誰？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', '鬼舞辻無慘麾下最精銳的鬼族組織稱為？', NULL, '十二鬼月', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '鬼舞辻無慘麾下最精銳的鬼族組織稱為？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', '十二鬼月中戰力最強、編號最前的一群稱為？', NULL, '上弦', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '十二鬼月中戰力最強、編號最前的一群稱為？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', '十二鬼月中戰力相對較弱的一群稱為？', NULL, '下弦', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '十二鬼月中戰力相對較弱的一群稱為？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', '傳說中創立「日之呼吸」、被視為所有呼吸法起源的劍士是？', NULL, '繼國緣壹', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '傳說中創立「日之呼吸」、被視為所有呼吸法起源的劍士是？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', '上弦之壹「黑死牟」的人類時期本名是？', NULL, '繼國巖勝', '["巖勝"]', 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '上弦之壹「黑死牟」的人類時期本名是？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', '上弦之陸由墮姬與哪位鬼組成搭檔？', NULL, '妓夫太郎', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '上弦之陸由墮姬與哪位鬼組成搭檔？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', '鬼殺隊士制服的主要顏色是？', NULL, '黑色', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '鬼殺隊士制服的主要顏色是？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', '鬼殺隊新進隊士必須通過的入隊考驗稱為？', NULL, '最終選別', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '鬼殺隊新進隊士必須通過的入隊考驗稱為？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', '「最終選別」的地點是一座長滿什麼花的山？', NULL, '藤花', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '「最終選別」的地點是一座長滿什麼花的山？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', '竈門炭治郎的師父、教導他呼吸法與劍術的隱居劍士是？', NULL, '鱗瀧左近次', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '竈門炭治郎的師父、教導他呼吸法與劍術的隱居劍士是？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', '教導我妻善逸的師父是誰？', NULL, '桑島慈悟郎', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '教導我妻善逸的師父是誰？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', '竈門禰豆子變成鬼後，用來壓抑衝動、防止咬人的道具是？', NULL, '竹筒', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '竈門禰豆子變成鬼後，用來壓抑衝動、防止咬人的道具是？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', '竈門禰豆子作為鬼的特殊能力（血鬼術）稱為？', NULL, '爆血', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '竈門禰豆子作為鬼的特殊能力（血鬼術）稱為？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', '胡蝶忍因力氣不足以斬首鬼，因此改用哪種方式討伐鬼？', NULL, '藤花之毒', '["毒"]', 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '胡蝶忍因力氣不足以斬首鬼，因此改用哪種方式討伐鬼？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', '鬼滅之刃的故事時代背景設定為日本的？', NULL, '大正時代', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '鬼滅之刃的故事時代背景設定為日本的？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', '宇髓天元原本的職業身分是？', NULL, '忍者', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '宇髓天元原本的職業身分是？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', '宇髓天元共有幾位妻子？', NULL, '三位', '["3位","3"]', 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '宇髓天元共有幾位妻子？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', '冨岡義勇與竈門炭治郎最初相遇，起因是義勇發現了變成鬼的誰？', NULL, '竈門禰豆子', '["禰豆子"]', 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '冨岡義勇與竈門炭治郎最初相遇，起因是義勇發現了變成鬼的誰？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', '不死川實彌的弟弟、同樣加入鬼殺隊的角色是？', NULL, '不死川玄彌', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '不死川實彌的弟弟、同樣加入鬼殺隊的角色是？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', '時透無一郎是史上最年輕晉升的柱，他失去了大部分關於過去的什麼？', NULL, '記憶', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '時透無一郎是史上最年輕晉升的柱，他失去了大部分關於過去的什麼？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', '上弦之肆「半天狗」的血鬼術特色是能夠分裂出多個？', NULL, '分身', '["情緒分身","化身"]', 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '上弦之肆「半天狗」的血鬼術特色是能夠分裂出多個？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', '上弦之伍「玉壺」的血鬼術與哪種容器意象密切相關？', NULL, '花瓶', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '上弦之伍「玉壺」的血鬼術與哪種容器意象密切相關？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', '上弦之貳「童磨」平時在人間偽裝成什麼身分？', NULL, '教主', '["教團教主"]', 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '上弦之貳「童磨」平時在人間偽裝成什麼身分？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', '猗窩座作戰時堅持不對什麼樣的人出手？', NULL, '女性', '["女人","婦女"]', 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '猗窩座作戰時堅持不對什麼樣的人出手？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', '鬼殺隊中負責在戰後救助傷患、處理善後的非戰鬥人員稱為？', NULL, '隱', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '鬼殺隊中負責在戰後救助傷患、處理善後的非戰鬥人員稱為？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', '鬼殺隊中負責訓練新人直到能獨當一面的資深角色稱為？', NULL, '育手', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '鬼殺隊中負責訓練新人直到能獨當一面的資深角色稱為？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', '竈門炭治郎的招牌武器類型是？', NULL, '日輪刀', '["刀","太刀"]', 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '竈門炭治郎的招牌武器類型是？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', '竈門炭治郎的日輪刀刀身顏色是？', NULL, '黑色', '["黑刀"]', 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '竈門炭治郎的日輪刀刀身顏色是？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', '竈門一家原本以販賣什麼維生？', NULL, '木炭', '["炭","燒炭"]', 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '竈門一家原本以販賣什麼維生？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', '鬼滅之刃的故事最初是以什麼形式連載？', NULL, '漫畫', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '鬼滅之刃的故事最初是以什麼形式連載？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', '我妻善逸在戰鬥前常因為害怕而做出什麼反應？', NULL, '昏睡', '["昏倒"]', 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '我妻善逸在戰鬥前常因為害怕而做出什麼反應？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', '竈門禰豆子的體型在戰鬥或藏匿時可以做到什麼變化？', NULL, '縮小', '["變小","縮小身體"]', 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '竈門禰豆子的體型在戰鬥或藏匿時可以做到什麼變化？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', '鬼殺隊士配戴的日輪刀，主要透過吸收什麼來對鬼造成致命傷？', NULL, '陽光', '["太陽光","日光"]', 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '鬼殺隊士配戴的日輪刀，主要透過吸收什麼來對鬼造成致命傷？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', '鬼滅之刃的原作者是？', NULL, '吾峠呼世晴', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '鬼滅之刃的原作者是？');

COMMIT;
