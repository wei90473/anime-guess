START TRANSACTION;

INSERT INTO anime_works (title, slug, description, is_active)
VALUES
('鬼滅之刃', 'demon-slayer', '台灣市場 MVP 外測題庫：鬼滅之刃。', 1),
('咒術迴戰', 'jujutsu-kaisen', '台灣市場 MVP 外測題庫：咒術迴戰。', 1),
('航海王', 'one-piece', '台灣市場 MVP 外測題庫：航海王。', 1),
('火影忍者', 'naruto', '台灣市場 MVP 外測題庫：火影忍者。', 1),
('進擊的巨人', 'attack-on-titan', '台灣市場 MVP 外測題庫：進擊的巨人。', 1),
('SPY×FAMILY 間諜家家酒', 'spy-family', '台灣市場 MVP 外測題庫：SPY×FAMILY 間諜家家酒。', 1),
('死亡筆記本', 'death-note', '台灣市場 MVP 外測題庫：死亡筆記本。', 1),
('葬送的芙莉蓮', 'frieren', '台灣市場 MVP 外測題庫：葬送的芙莉蓮。', 1),
('膽大黨', 'dandadan', '台灣市場 MVP 外測題庫：膽大黨。', 1),
('我獨自升級', 'solo-leveling', '台灣市場 MVP 外測題庫：我獨自升級。', 1)
ON DUPLICATE KEY UPDATE
    title = VALUES(title),
    description = VALUES(description),
    is_active = VALUES(is_active);

INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', '炭治郎使用的主要呼吸法是？', '["水之呼吸","雷之呼吸","炎之呼吸","音之呼吸"]', '水之呼吸', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '炭治郎使用的主要呼吸法是？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', '禰豆子是炭治郎的？', '["妹妹","姐姐","同學","師父"]', '妹妹', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '禰豆子是炭治郎的？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', '鬼殺隊中使用雷之呼吸的角色是？', '["我妻善逸","嘴平伊之助","富岡義勇","煉獄杏壽郎"]', '我妻善逸', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '鬼殺隊中使用雷之呼吸的角色是？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', '鬼滅之刃中，鬼殺隊的敵人主要是？', '["鬼","咒靈","巨人","海賊"]', '鬼', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '鬼滅之刃中，鬼殺隊的敵人主要是？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', '炭治郎的妹妹叫什麼名字？', NULL, '禰豆子', '["竈門禰豆子","祢豆子"]', 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'demon-slayer' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '炭治郎的妹妹叫什麼名字？');

INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', '虎杖悠仁吞下的是誰的手指？', '["兩面宿儺","五條悟","伏黑惠","夏油傑"]', '兩面宿儺', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'jujutsu-kaisen' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '虎杖悠仁吞下的是誰的手指？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', '咒術迴戰中，被稱為最強咒術師的是誰？', NULL, '五條悟', '["五條","悟"]', 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'jujutsu-kaisen' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '咒術迴戰中，被稱為最強咒術師的是誰？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', '五條悟常遮住哪個部位？', '["眼睛","嘴巴","耳朵","左手"]', '眼睛', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'jujutsu-kaisen' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '五條悟常遮住哪個部位？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', '伏黑惠使用的術式常召喚什麼？', '["式神","巨人","寶可夢","刀劍"]', '式神', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'jujutsu-kaisen' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '伏黑惠使用的術式常召喚什麼？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', '虎杖悠仁體內寄宿的詛咒之王是？', NULL, '兩面宿儺', '["宿儺"]', 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'jujutsu-kaisen' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '虎杖悠仁體內寄宿的詛咒之王是？');

INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', '魯夫想成為什麼？', '["海賊王","火影","死神","獵人"]', '海賊王', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'one-piece' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '魯夫想成為什麼？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', '草帽海賊團的船長是誰？', '["魯夫","索隆","香吉士","娜美"]', '魯夫', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'one-piece' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '草帽海賊團的船長是誰？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', '索隆在草帽海賊團中的主要定位是？', '["劍士","廚師","航海士","船醫"]', '劍士', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'one-piece' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '索隆在草帽海賊團中的主要定位是？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', '娜美在草帽海賊團中的主要職務是？', '["航海士","船長","狙擊手","考古學家"]', '航海士', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'one-piece' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '娜美在草帽海賊團中的主要職務是？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', '魯夫吃下的惡魔果實原本常被稱為什麼果實？', NULL, '橡膠果實', '["橡膠"]', 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'one-piece' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '魯夫吃下的惡魔果實原本常被稱為什麼果實？');

INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', '鳴人最想成為村子的什麼？', '["火影","隊長","忍刀七人眾","曉成員"]', '火影', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'naruto' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '鳴人最想成為村子的什麼？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', '宇智波佐助所屬的家族是？', NULL, '宇智波', '["宇智波一族"]', 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'naruto' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '宇智波佐助所屬的家族是？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', '鳴人體內封印的是哪一隻尾獸？', '["九尾","一尾","八尾","三尾"]', '九尾', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'naruto' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '鳴人體內封印的是哪一隻尾獸？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', '卡卡西所屬的忍村是？', '["木葉忍者村","砂隱村","霧隱村","雲隱村"]', '木葉忍者村', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'naruto' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '卡卡西所屬的忍村是？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', '鳴人的招牌忍術之一，能製造分身的是？', NULL, '影分身之術', '["影分身"]', 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'naruto' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '鳴人的招牌忍術之一，能製造分身的是？');

INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', '艾連最初居住的城市被什麼威脅？', '["巨人","吸血鬼","咒靈","惡魔"]', '巨人', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'attack-on-titan' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '艾連最初居住的城市被什麼威脅？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', '調查兵團的象徵常被稱為？', '["自由之翼","火之意志","草帽旗","黑色教團"]', '自由之翼', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'attack-on-titan' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '調查兵團的象徵常被稱為？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', '進擊的巨人中，人類主要住在哪種建築保護內？', '["高牆","地下城","天空島","結界塔"]', '高牆', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'attack-on-titan' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '進擊的巨人中，人類主要住在哪種建築保護內？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', '米卡莎與艾連的關係較接近？', '["家人/青梅竹馬","老師與學生","敵人","陌生人"]', '家人/青梅竹馬', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'attack-on-titan' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '米卡莎與艾連的關係較接近？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', '進擊的巨人主角艾連的姓氏是？', NULL, '葉卡', '["葉卡 Yeager","耶格爾","葉卡爾"]', 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'attack-on-titan' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '進擊的巨人主角艾連的姓氏是？');

INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', '安妮亞擁有什麼能力？', '["讀心","瞬間移動","變身","操控火焰"]', '讀心', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'spy-family' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '安妮亞擁有什麼能力？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', '洛伊德的間諜代號是？', '["黃昏","黎明","白夜","影"]', '黃昏', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'spy-family' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '洛伊德的間諜代號是？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', '約兒表面上的身分是？', '["市政府職員","老師","醫生","偶像"]', '市政府職員', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'spy-family' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '約兒表面上的身分是？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', '安妮亞最喜歡的食物之一是？', '["花生","拉麵","壽司","咖哩"]', '花生', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'spy-family' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '安妮亞最喜歡的食物之一是？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', '佛傑家的女兒叫什麼名字？', NULL, '安妮亞', '["安妮亞佛傑","安妮亞·佛傑"]', 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'spy-family' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '佛傑家的女兒叫什麼名字？');

INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', '夜神月撿到的是什麼筆記本？', '["死亡筆記本","友人帳","魔法書","航海日誌"]', '死亡筆記本', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'death-note' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '夜神月撿到的是什麼筆記本？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', '與夜神月鬥智的名偵探代號是？', NULL, 'L', '["艾爾"]', 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'death-note' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '與夜神月鬥智的名偵探代號是？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', '死亡筆記本中，路克的身分是？', '["死神","警察","偵探","老師"]', '死神', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'death-note' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '死亡筆記本中，路克的身分是？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', '死亡筆記本殺人的基本條件之一是寫下對方的？', '["名字","住址","電話","生日"]', '名字', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'death-note' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '死亡筆記本殺人的基本條件之一是寫下對方的？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', '夜神月使用死亡筆記本後被大眾稱為？', NULL, '奇樂', '["基拉","Kira","奇拉"]', 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'death-note' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '夜神月使用死亡筆記本後被大眾稱為？');

INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', '芙莉蓮的種族是？', '["精靈","人類","矮人","魔族"]', '精靈', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'frieren' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '芙莉蓮的種族是？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', '芙莉蓮曾經所屬的隊伍打倒了誰？', NULL, '魔王', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'frieren' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '芙莉蓮曾經所屬的隊伍打倒了誰？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', '芙莉蓮擅長使用什麼？', '["魔法","忍術","咒術","惡魔果實"]', '魔法', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'frieren' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '芙莉蓮擅長使用什麼？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', '葬送的芙莉蓮故事開始時，勇者隊伍已經？', '["打倒魔王","剛出發","全員失憶","加入軍隊"]', '打倒魔王', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'frieren' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '葬送的芙莉蓮故事開始時，勇者隊伍已經？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', '芙莉蓮的弟子叫什麼名字？', NULL, '費倫', '["菲倫","Fern"]', 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'frieren' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '芙莉蓮的弟子叫什麼名字？');

INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', '膽大黨的故事主要混合了哪兩種元素？', '["靈異與外星人","料理與運動","偵探與推理","偶像與音樂"]', '靈異與外星人', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'dandadan' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '膽大黨的故事主要混合了哪兩種元素？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', '膽大黨女主角之一常被稱為？', NULL, '綾瀨桃', '["桃","桃醬"]', 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'dandadan' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '膽大黨女主角之一常被稱為？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', '膽大黨中常出現的題材包含幽靈與什麼？', '["外星人","海賊","忍者","魔法學校"]', '外星人', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'dandadan' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '膽大黨中常出現的題材包含幽靈與什麼？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', '高倉健在作品中也常被稱為？', '["厄卡倫","魯夫","五條","夜神月"]', '厄卡倫', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'dandadan' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '高倉健在作品中也常被稱為？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', '膽大黨男主角常用的暱稱是？', NULL, '厄卡倫', '["奧卡倫","Okarun"]', 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'dandadan' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '膽大黨男主角常用的暱稱是？');

INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', '成振宇原本被稱為什麼等級的獵人？', '["E級","S級","A級","國家級"]', 'E級', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'solo-leveling' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '成振宇原本被稱為什麼等級的獵人？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', '我獨自升級主角的名字是？', NULL, '成振宇', '["水篠旬","旬"]', 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'solo-leveling' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '我獨自升級主角的名字是？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', '我獨自升級中，主角的能力成長方式接近？', '["像遊戲系統升級","靠惡魔果實","靠忍術修煉","靠死亡筆記本"]', '像遊戲系統升級', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'solo-leveling' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '我獨自升級中，主角的能力成長方式接近？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'multiple_choice', '成振宇後來與哪種軍團能力密切相關？', '["影子軍團","巨人軍團","海賊艦隊","忍者聯軍"]', '影子軍團', NULL, 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'solo-leveling' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '成振宇後來與哪種軍團能力密切相關？');
INSERT INTO questions (anime_work_id, type, prompt, choices_json, correct_answer, accepted_answers_json, origin, status, is_active)
SELECT w.id, 'fill_blank', '我獨自升級中，主角原本是最低等級的什麼？', NULL, '獵人', '["E級獵人"]', 'admin', 'approved', 1 FROM anime_works w WHERE w.slug = 'solo-leveling' AND NOT EXISTS (SELECT 1 FROM questions q WHERE q.anime_work_id = w.id AND q.prompt = '我獨自升級中，主角原本是最低等級的什麼？');

COMMIT;