-- 依賴順序：此 seed 可在 0001_seed_admin_user.php + migration 建立 schema 後獨立執行
-- 修正版：已依 TASK-AGQ-018-fix-reviewer.md 完整 fact-check 修正（P1/P2 全修正）

START TRANSACTION;

-- ============================================================
-- 新增作品
-- ============================================================

INSERT INTO anime_works (title, slug, description, is_active)
VALUES
('排球少年!!', 'haikyu', '台灣市場外測題庫：排球少年!!', 1),
('中華一番！', 'chuuka-ichiban', '台灣市場外測題庫：中華一番！', 1)
ON DUPLICATE KEY UPDATE
    title = VALUES(title),
    description = VALUES(description),
    is_active = VALUES(is_active);

-- ============================================================
-- 排球少年!!（haikyu）easy 12 題（6 MC + 6 FB）
-- ============================================================

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', 'easy', 16, '排球少年!!的主角日向翔陽就讀於哪所高中？', '["烏野高校","青葉城西高校","音駒高校","白鳥澤學園高校"]', '烏野高校', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'haikyu' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '排球少年!!的主角日向翔陽就讀於哪所高中？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', 'easy', 16, '影山飛雄在烏野排球隊擔任的位置是？', '["舉球員","攻擊手","自由球員","攔網手"]', '舉球員', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'haikyu' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '影山飛雄在烏野排球隊擔任的位置是？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', 'easy', 16, '排球少年!!的故事主要圍繞哪項運動？', '["排球","籃球","棒球","足球"]', '排球', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'haikyu' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '排球少年!!的故事主要圍繞哪項運動？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', 'easy', 16, '烏野高校排球隊的自由球員是誰？', '["西谷夕","田中龍之介","澤村大地","東峰旭"]', '西谷夕', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'haikyu' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '烏野高校排球隊的自由球員是誰？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', 'easy', 16, '日向翔陽入隊前憧憬的「小巨人」曾就讀哪所學校？', '["烏野高校","青葉城西","音駒高校","伊達工業"]', '烏野高校', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'haikyu' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '日向翔陽入隊前憧憬的「小巨人」曾就讀哪所學校？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', 'easy', 16, '烏野排球隊的隊長是誰？', '["澤村大地","東峰旭","菅原孝支","西谷夕"]', '澤村大地', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'haikyu' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '烏野排球隊的隊長是誰？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', 'easy', 16, '日向翔陽與影山飛雄合力開發的招牌高速攻擊戰術稱為什麼？', NULL, '怪人快攻', '["怪物快攻","鬼速快攻"]', 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'haikyu' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '日向翔陽與影山飛雄合力開發的招牌高速攻擊戰術稱為什麼？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', 'easy', 16, '烏野排球部的主要舉球員叫什麼名字？', NULL, '影山飛雄', '["影山"]', 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'haikyu' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '烏野排球部的主要舉球員叫什麼名字？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', 'easy', 16, '烏野高校排球隊的王牌主攻手（外號「玻璃心的王牌」）是誰？', NULL, '東峰旭', '["東峰"]', 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'haikyu' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '烏野高校排球隊的王牌主攻手（外號「玻璃心的王牌」）是誰？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', 'easy', 16, '排球少年!!中，烏野高校隊服的主要顏色是什麼？', NULL, '黑色與橘色', '["黑橘","黑色","橘色"]', 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'haikyu' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '排球少年!!中，烏野高校隊服的主要顏色是什麼？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', 'easy', 16, '菅原孝支在烏野排球隊擔任什麼位置？', NULL, '副舉球員', '["舉球員","備用舉球員"]', 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'haikyu' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '菅原孝支在烏野排球隊擔任什麼位置？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', 'easy', 16, '日向翔陽就讀的中學名稱是？', NULL, '雪之丘中學', '["雪丘中學","雪之丘"]', 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'haikyu' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '日向翔陽就讀的中學名稱是？');

-- 排球少年!!（haikyu）normal 24 題（13 MC + 11 FB）

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', 'normal', 50, '青葉城西高校排球隊的舉球員是誰？', '["及川徹","岩泉一","松川一静","花卷貴大"]', '及川徹', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'haikyu' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '青葉城西高校排球隊的舉球員是誰？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', 'normal', 50, '音駒高校排球隊的舉球員是誰？', '["孤爪研磨","夜久衛輔","黑尾鐵朗","犬岡走"]', '孤爪研磨', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'haikyu' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '音駒高校排球隊的舉球員是誰？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', 'normal', 50, '白鳥澤學園高校排球隊的王牌攻擊手是誰？', '["牛島若利","白布賢二郎","天童覚","五色工"]', '牛島若利', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'haikyu' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '白鳥澤學園高校排球隊的王牌攻擊手是誰？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', 'normal', 50, '烏野高校排球隊的指導老師（監督）是誰？', '["武田一鐵","烏養繫心","澤村大地","菅原孝支"]', '武田一鐵', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'haikyu' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '烏野高校排球隊的指導老師（監督）是誰？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', 'normal', 50, '烏野高校排球隊的教練（前任監督之孫）是誰？', '["烏養繫心","武田一鐵","澤村大地","西谷夕"]', '烏養繫心', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'haikyu' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '烏野高校排球隊的教練（前任監督之孫）是誰？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', 'normal', 50, '日向翔陽的背號是幾號？', '["10號","1號","5號","15號"]', '10號', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'haikyu' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '日向翔陽的背號是幾號？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', 'normal', 50, '山口忠在烏野排球隊中主要使用哪種發球技術？', '["跳躍浮球發球","後排攻擊","快攻","攔網"]', '跳躍浮球發球', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'haikyu' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '山口忠在烏野排球隊中主要使用哪種發球技術？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', 'normal', 50, '月島螢在烏野排球隊中最擅長的技術是？', '["攔網","發球","快攻","自由接球"]', '攔網', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'haikyu' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '月島螢在烏野排球隊中最擅長的技術是？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', 'normal', 50, '及川徹最具代表性的強力發球稱為？', '["超強跳躍發球","浮球發球","後排攻擊","勾球"]', '超強跳躍發球', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'haikyu' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '及川徹最具代表性的強力發球稱為？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', 'normal', 50, '稻荷崎高校排球隊的主要特色戰術是？', '["花式二傳","鐵壁攔網","快攻連續","後排強攻"]', '花式二傳', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'haikyu' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '稻荷崎高校排球隊的主要特色戰術是？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', 'normal', 50, '故事中以「貓vs烏鴉」為象徵的著名對決，是哪兩隊之間的比賽？', '["音駒vs烏野","青葉城西vs烏野","白鳥澤vs烏野","稻荷崎vs烏野"]', '音駒vs烏野', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'haikyu' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '故事中以「貓vs烏鴉」為象徵的著名對決，是哪兩隊之間的比賽？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', 'normal', 50, '影山飛雄在中學時因何種原因被隊友稱為「球場獨裁者」？', '["強迫隊友配合自己的節奏","在場外指揮","使用違規技術","獨包全場得分"]', '強迫隊友配合自己的節奏', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'haikyu' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '影山飛雄在中學時因何種原因被隊友稱為「球場獨裁者」？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', 'normal', 50, '烏野高校排球隊參加的縣代表大會，其所在縣名稱是？', '["宮城縣","岩手縣","福島縣","山形縣"]', '宮城縣', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'haikyu' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '烏野高校排球隊參加的縣代表大會，其所在縣名稱是？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', 'normal', 50, '青葉城西高校排球隊的主力攻擊手（及川徹的長年搭檔）是誰？', NULL, '岩泉一', '["岩泉"]', 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'haikyu' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '青葉城西高校排球隊的主力攻擊手（及川徹的長年搭檔）是誰？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', 'normal', 50, '影山飛雄在中學時就讀哪所學校？', NULL, '北川第一中學', '["北川第一","北川"]', 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'haikyu' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '影山飛雄在中學時就讀哪所學校？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', 'normal', 50, '日向翔陽的背號數字是幾號？', NULL, '10', '["10號"]', 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'haikyu' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '日向翔陽的背號數字是幾號？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', 'normal', 50, '月島螢的哥哥叫什麼名字？', NULL, '月島明光', '["月島明"]', 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'haikyu' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '月島螢的哥哥叫什麼名字？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', 'normal', 50, '田中龍之介的姐姐叫什麼名字？', NULL, '田中冴子', '["冴子","田中"]', 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'haikyu' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '田中龍之介的姐姐叫什麼名字？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', 'normal', 50, '烏野與音駒高校的校際對決，在劇中俗稱為什麼？', NULL, '垃圾桶決戰', '["垃圾場決戰"]', 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'haikyu' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '烏野與音駒高校的校際對決，在劇中俗稱為什麼？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', 'normal', 50, '白鳥澤學園排球隊的先發舉球員是誰？', NULL, '白布賢二郎', '["白布"]', 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'haikyu' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '白鳥澤學園排球隊的先發舉球員是誰？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', 'normal', 50, '伊達工業高校排球隊以「鐵壁攔網」著稱，其代表球員之一是誰？', NULL, '青根高伸', '["青根"]', 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'haikyu' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '伊達工業高校排球隊以「鐵壁攔網」著稱，其代表球員之一是誰？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', 'normal', 50, '排球少年!!中，春高排球全國大賽的會場所在城市是？', NULL, '東京', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'haikyu' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '排球少年!!中，春高排球全國大賽的會場所在城市是？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', 'normal', 50, '音駒高校排球部的指導老師名叫？', NULL, '貓又育史', '["貓又"]', 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'haikyu' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '音駒高校排球部的指導老師名叫？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', 'normal', 50, '稻荷崎高校排球隊的隊長是誰？', NULL, '北信介', '["北"]', 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'haikyu' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '稻荷崎高校排球隊的隊長是誰？');

-- 排球少年!!（haikyu）hard 12 題（6 MC + 6 FB）

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', 'hard', 78, '孤爪研磨高中畢業後選擇的主要職業方向是？', '["遊戲實況主","加入MSBY黑胡椒","加入Schweiden Adlers","赴海外打職業排球"]', '遊戲實況主', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'haikyu' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '孤爪研磨高中畢業後選擇的主要職業方向是？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', 'hard', 78, '影山飛雄高中畢業後加入哪支職業排球隊？', '["Schweiden Adlers","MSBY黑胡椒","EJP雅典娜","巴西俱樂部隊"]', 'Schweiden Adlers', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'haikyu' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '影山飛雄高中畢業後加入哪支職業排球隊？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', 'hard', 78, '宮侑（稻荷崎雙胞胎之一）在球隊中擔任的位置是？', '["舉球員","攻擊手","自由球員","攔網手"]', '舉球員', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'haikyu' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '宮侑（稻荷崎雙胞胎之一）在球隊中擔任的位置是？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', 'hard', 78, '木兔光太郎在梟谷學園高校擔任什麼位置？', '["主攻手","舉球員","自由球員","副攻手"]', '主攻手', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'haikyu' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '木兔光太郎在梟谷學園高校擔任什麼位置？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', 'hard', 78, '排球少年!!原作漫畫在哪本雜誌連載？', '["週刊少年JUMP","週刊少年Magazine","週刊少年Sunday","月刊少年ACE"]', '週刊少年JUMP', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'haikyu' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '排球少年!!原作漫畫在哪本雜誌連載？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', 'hard', 78, '梟谷學園高校的明星舉球員是誰？', '["赤葦京治","木兔光太郎","孤爪研磨","犬岡走"]', '赤葦京治', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'haikyu' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '梟谷學園高校的明星舉球員是誰？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', 'hard', 78, '排球少年!!原作漫畫作者的姓名是？', NULL, '古舘春一', '["古舘"]', 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'haikyu' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '排球少年!!原作漫畫作者的姓名是？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', 'hard', 78, '音駒高校排球隊的隊長（主力第三年球員）名叫？', NULL, '黑尾鐵朗', '["黑尾"]', 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'haikyu' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '音駒高校排球隊的隊長（主力第三年球員）名叫？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', 'hard', 78, '天童覚在白鳥澤排球隊的位置是？', NULL, '副攻手', '["中間攔網","攔網手"]', 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'haikyu' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '天童覚在白鳥澤排球隊的位置是？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', 'hard', 78, '宮城縣代表決賽中，烏野擊敗哪所學校取得全國大賽資格？', NULL, '白鳥澤學園', '["白鳥澤"]', 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'haikyu' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '宮城縣代表決賽中，烏野擊敗哪所學校取得全國大賽資格？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', 'hard', 78, '月島螢在宮城縣代表決賽（對白鳥澤）中，成功攔截了哪位王牌選手的關鍵扣球？', NULL, '牛島若利', '["牛島"]', 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'haikyu' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '月島螢在宮城縣代表決賽（對白鳥澤）中，成功攔截了哪位王牌選手的關鍵扣球？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', 'hard', 78, '日向翔陽高中畢業後，首先前往哪個國家的沙灘排球隊磨練技術？', NULL, '巴西', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'haikyu' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '日向翔陽高中畢業後，首先前往哪個國家的沙灘排球隊磨練技術？');

-- 排球少年!!（haikyu）extreme 2 題（1 MC + 1 FB）

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', 'extreme', 95, '排球少年!!故事結局中，日向翔陽最終效力於哪支日本職業排球隊？', '["MSBY黑胡椒","Schweiden Adlers","EJP雅典娜","巴西俱樂部隊"]', 'MSBY黑胡椒', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'haikyu' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '排球少年!!故事結局中，日向翔陽最終效力於哪支日本職業排球隊？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', 'extreme', 95, '故事末章，影山飛雄與日向翔陽在日本職業排球聯賽正式對決，這個聯賽的名稱是？', NULL, 'V聯賽', '["V.League","日本V聯賽","V-League"]', 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'haikyu' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '故事末章，影山飛雄與日向翔陽在日本職業排球聯賽正式對決，這個聯賽的名稱是？');

-- ============================================================
-- 中華一番！（chuuka-ichiban）easy 12 題（6 MC + 6 FB）
-- ============================================================

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', 'easy', 16, '中華一番！的主角叫什麼名字？', '["劉昴星","梅麗","四郎","凱由"]', '劉昴星', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'chuuka-ichiban' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '中華一番！的主角叫什麼名字？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', 'easy', 16, '中華一番！的故事背景設定在中國哪個朝代？', '["清朝","明朝","唐朝","宋朝"]', '清朝', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'chuuka-ichiban' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '中華一番！的故事背景設定在中國哪個朝代？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', 'easy', 16, '中華一番！的主要料理類型是？', '["中式料理","法式料理","日式料理","義式料理"]', '中式料理', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'chuuka-ichiban' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '中華一番！的主要料理類型是？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', 'easy', 16, '中華一番！中，劉昴星的主要對手組織稱為？', '["黑暗料理界","料理評議會","料理大道","廚王會"]', '黑暗料理界', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'chuuka-ichiban' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '中華一番！中，劉昴星的主要對手組織稱為？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', 'easy', 16, '劉昴星的母親留下的特殊廚具是哪種類型的鍋具？', '["中華鍋","蒸籠","砂鍋","鐵板"]', '中華鍋', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'chuuka-ichiban' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '劉昴星的母親留下的特殊廚具是哪種類型的鍋具？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', 'easy', 16, '中華一番！的原作漫畫作者是誰？', '["小川悦司","古舘春一","荒木飛呂彥","富堅義博"]', '小川悦司', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'chuuka-ichiban' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '中華一番！的原作漫畫作者是誰？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', 'easy', 16, '劉昴星母親傳承下來的特殊廚具完整名稱是？', NULL, '特級中華鍋', '["中華鍋","神鍋"]', 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'chuuka-ichiban' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '劉昴星母親傳承下來的特殊廚具完整名稱是？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', 'easy', 16, '劉昴星母親的暱稱是？', NULL, '阿貝', '["阿貝媽媽"]', 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'chuuka-ichiban' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '劉昴星母親的暱稱是？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', 'easy', 16, '劉昴星母親阿貝在四川省所創辦的餐廳名稱是？', NULL, '菊下樓', '["菊下楼"]', 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'chuuka-ichiban' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '劉昴星母親阿貝在四川省所創辦的餐廳名稱是？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', 'easy', 16, '劉昴星在故事早期前往哪座城市向周瑜拜師學藝？', NULL, '廣州', '["廣州市"]', 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'chuuka-ichiban' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '劉昴星在故事早期前往哪座城市向周瑜拜師學藝？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', 'easy', 16, '劉昴星在台灣版動畫中最廣為人知的暱稱是什麼？', NULL, '小當家', '["劉昴星"]', 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'chuuka-ichiban' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '劉昴星在台灣版動畫中最廣為人知的暱稱是什麼？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', 'easy', 16, '劉昴星廣州修行所在的餐廳名稱是？', NULL, '南鮮酒家', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'chuuka-ichiban' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '劉昴星廣州修行所在的餐廳名稱是？');

-- 中華一番！（chuuka-ichiban）normal 24 題（12 MC + 12 FB）

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', 'normal', 50, '黑暗料理界的最高領袖是誰？', '["凱由","大長老","黑暗料理王","料理惡魔"]', '凱由', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'chuuka-ichiban' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '黑暗料理界的最高領袖是誰？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', 'normal', 50, '劉昴星最擅長的料理菜系是？', '["四川料理","廣東料理","北京料理","浙江料理"]', '四川料理', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'chuuka-ichiban' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '劉昴星最擅長的料理菜系是？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', 'normal', 50, '劉昴星在故事早期前往廣州是為了什麼目的？', '["在南鮮酒家修行","尋找失蹤父親","挑戰黑暗料理界","尋找特級食材"]', '在南鮮酒家修行', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'chuuka-ichiban' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '劉昴星在故事早期前往廣州是為了什麼目的？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', 'normal', 50, '四川料理以什麼口味最著稱？', '["麻辣","清淡","酸甜","鹹鮮"]', '麻辣', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'chuuka-ichiban' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '四川料理以什麼口味最著稱？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', 'normal', 50, '中華一番！1997年版動畫，其英文片名是？', '["Cooking Master Boy","Chinese Chef Boy","Cuisine Battle","Master of Wok"]', 'Cooking Master Boy', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'chuuka-ichiban' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '中華一番！1997年版動畫，其英文片名是？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', 'normal', 50, '凱由所領導的黑暗料理界，其主要目標是？', '["控制整個料理界","培養最強廚師","消滅特級廚師","統一全國餐廳"]', '控制整個料理界', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'chuuka-ichiban' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '凱由所領導的黑暗料理界，其主要目標是？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', 'normal', 50, '梅麗在故事中與劉昴星的關係是？', '["同伴兼摯友","師父","競爭對手","黑暗料理界成員"]', '同伴兼摯友', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'chuuka-ichiban' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '梅麗在故事中與劉昴星的關係是？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', 'normal', 50, '四川料理在中國八大菜系中的簡稱是？', '["川菜","粵菜","魯菜","淮揚菜"]', '川菜', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'chuuka-ichiban' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '四川料理在中國八大菜系中的簡稱是？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', 'normal', 50, '中華一番！的原作漫畫在哪本雜誌連載？', '["週刊少年Magazine","週刊少年JUMP","月刊少年ACE","週刊少年Sunday"]', '週刊少年Magazine', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'chuuka-ichiban' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '中華一番！的原作漫畫在哪本雜誌連載？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', 'normal', 50, '劉昴星成為特級廚師時的年齡是幾歲？', '["13歲","15歲","12歲","16歲"]', '13歲', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'chuuka-ichiban' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '劉昴星成為特級廚師時的年齡是幾歲？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', 'normal', 50, '故事中「特級廚師」的考核主要形式是什麼？', '["料理對決","筆試加實作","多輪試菜","食材識別"]', '料理對決', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'chuuka-ichiban' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '故事中「特級廚師」的考核主要形式是什麼？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', 'normal', 50, '劉昴星在料理對決中最核心的廚藝技巧是以什麼著稱？', '["火候與刀工的精湛結合","僅靠稀有食材","全靠秘方醬料","超快速完成"]', '火候與刀工的精湛結合', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'chuuka-ichiban' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '劉昴星在料理對決中最核心的廚藝技巧是以什麼著稱？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', 'normal', 50, '劉昴星在廣州學藝期間，對他指導意義深遠的師父是誰？', NULL, '周瑜', '["周瑜師傅"]', 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'chuuka-ichiban' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '劉昴星在廣州學藝期間，對他指導意義深遠的師父是誰？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', 'normal', 50, '劉昴星旅途中最主要的女性同伴叫什麼名字？', NULL, '梅麗', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'chuuka-ichiban' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '劉昴星旅途中最主要的女性同伴叫什麼名字？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', 'normal', 50, '凱由率領的黑暗料理界旗下五名精英將領的統稱是？', NULL, '五虎星', '["黑暗料理界五虎星"]', 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'chuuka-ichiban' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '凱由率領的黑暗料理界旗下五名精英將領的統稱是？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', 'normal', 50, '料理對決後，品嚐到劉昴星美食而感動落淚的場面，被台灣觀眾俗稱為什麼？', NULL, '昇天', '["升天","昇仙"]', 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'chuuka-ichiban' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '料理對決後，品嚐到劉昴星美食而感動落淚的場面，被台灣觀眾俗稱為什麼？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', 'normal', 50, '劉昴星的特級中華鍋是由誰傳承給他的？', NULL, '阿貝', '["母親阿貝","母親"]', 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'chuuka-ichiban' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '劉昴星的特級中華鍋是由誰傳承給他的？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', 'normal', 50, '四川料理帶來「麻」感的代表性香料是？', NULL, '花椒', '["花椒粒","花椒粉"]', 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'chuuka-ichiban' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '四川料理帶來「麻」感的代表性香料是？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', 'normal', 50, '劉昴星旅途中的男性同伴之一叫什麼名字？', NULL, '四郎', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'chuuka-ichiban' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '劉昴星旅途中的男性同伴之一叫什麼名字？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', 'normal', 50, '劉昴星母親阿貝所創辦的菊下樓餐廳位於四川省哪個城市？', NULL, '成都', '["成都市","四川成都"]', 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'chuuka-ichiban' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '劉昴星母親阿貝所創辦的菊下樓餐廳位於四川省哪個城市？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', 'normal', 50, '劉昴星的目標頭銜（台灣版正式稱謂）是？', NULL, '特級廚師', '["超廚"]', 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'chuuka-ichiban' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '劉昴星的目標頭銜（台灣版正式稱謂）是？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', 'normal', 50, '料理對決中，由哪類人士負責品嚐並裁定勝負？', NULL, '評審', '["評委","食評家","評審委員"]', 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'chuuka-ichiban' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '料理對決中，由哪類人士負責品嚐並裁定勝負？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', 'normal', 50, '2019年推出的新版中華一番！動畫名稱是？', NULL, '真・中華一番!', '["真中華一番","真・中華一番"]', 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'chuuka-ichiban' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '2019年推出的新版中華一番！動畫名稱是？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', 'normal', 50, '劉昴星廣州修行時所在的南鮮酒家，位於中國哪個省份？', NULL, '廣東省', '["廣東"]', 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'chuuka-ichiban' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '劉昴星廣州修行時所在的南鮮酒家，位於中國哪個省份？');

-- 中華一番！（chuuka-ichiban）hard 12 題（6 MC + 6 FB）

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', 'hard', 78, '2019年的新版中華一番！動畫，其日文正式片名是？', '["真・中華一番!","中華一番！改","新中華一番!","中華一番！2019"]', '真・中華一番!', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'chuuka-ichiban' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '2019年的新版中華一番！動畫，其日文正式片名是？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', 'hard', 78, '中華一番！原作漫畫的首次連載年份約是哪段時期？', '["1995年至1999年","2000年至2005年","1990年至1994年","2005年至2010年"]', '1995年至1999年', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'chuuka-ichiban' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '中華一番！原作漫畫的首次連載年份約是哪段時期？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', 'hard', 78, '凱由在故事中的角色定位是？', '["黑暗料理界最高領袖","五虎星成員","廣州廚師學校校長","劉昴星的師父"]', '黑暗料理界最高領袖', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'chuuka-ichiban' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '凱由在故事中的角色定位是？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', 'hard', 78, '劉昴星母親阿貝所創辦的菊下樓，位於中國哪個省份？', '["四川省","廣東省","北京市","浙江省"]', '四川省', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'chuuka-ichiban' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '劉昴星母親阿貝所創辦的菊下樓，位於中國哪個省份？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', 'hard', 78, '中華一番！原作（小川悦司版）漫畫共出版幾冊單行本？', '["17冊","27冊","24冊","12冊"]', '17冊', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'chuuka-ichiban' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '中華一番！原作（小川悦司版）漫畫共出版幾冊單行本？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', 'hard', 78, '黑暗料理界試圖壓制正統料理界的主要手段之一是？', '["操控稀有食材的供應","暗殺所有特級廚師","散播謠言破壞聲譽","收買所有評審"]', '操控稀有食材的供應', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'chuuka-ichiban' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '黑暗料理界試圖壓制正統料理界的主要手段之一是？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', 'hard', 78, '2019年新版中華一番！動畫的完整日文片名是？', NULL, '真・中華一番!', '["真中華一番","真・中華一番"]', 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'chuuka-ichiban' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '2019年新版中華一番！動畫的完整日文片名是？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', 'hard', 78, '中華一番！原作漫畫約在哪一年結束連載？', NULL, '1999年', '["1999"]', 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'chuuka-ichiban' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '中華一番！原作漫畫約在哪一年結束連載？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', 'hard', 78, '中華一番！中，「特級廚師」的台灣正式用語是什麼？', NULL, '特級廚師', '["超廚"]', 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'chuuka-ichiban' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '中華一番！中，「特級廚師」的台灣正式用語是什麼？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', 'hard', 78, '凱由領導的黑暗料理界旗下五名精英將領，其統稱是（繁體中文）？', NULL, '五虎星', '["黑暗料理界五虎星"]', 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'chuuka-ichiban' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '凱由領導的黑暗料理界旗下五名精英將領，其統稱是（繁體中文）？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', 'hard', 78, '菊下樓餐廳位於四川省的哪個城市（劉昴星的家鄉城市）？', NULL, '成都', '["成都市"]', 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'chuuka-ichiban' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '菊下樓餐廳位於四川省的哪個城市（劉昴星的家鄉城市）？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', 'hard', 78, '劉昴星在廣州南鮮酒家拜師的周瑜，在酒家擔任什麼職位？', NULL, '副料理長', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'chuuka-ichiban' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '劉昴星在廣州南鮮酒家拜師的周瑜，在酒家擔任什麼職位？');

-- 中華一番！（chuuka-ichiban）extreme 2 題（1 MC + 1 FB）

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', 'extreme', 95, '中華一番！1997年版動畫共播出幾集？', '["52集","26集","48集","65集"]', '52集', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'chuuka-ichiban' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '中華一番！1997年版動畫共播出幾集？');

INSERT INTO questions (anime_work_id, type, difficulty, difficulty_score, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', 'extreme', 95, '小川悦司在中華一番！完結後，以劉昴星為主角推出的續篇漫畫名稱是？', NULL, '真・中華一番!', '["真中華一番","真・中華一番"]', 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'chuuka-ichiban' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '小川悦司在中華一番！完結後，以劉昴星為主角推出的續篇漫畫名稱是？');

COMMIT;
