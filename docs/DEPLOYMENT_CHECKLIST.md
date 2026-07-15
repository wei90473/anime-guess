# AGQ 部署前檢查清單（Deployment Checklist）

## 環境需求

| 項目 | 建議版本 | 最低版本 | 說明 |
|---|---|---|---|
| PHP | 8.x | 7.4（已 EOL，不建議正式環境） | 需啟用 `pdo_mysql`、`mbstring`、`json` 擴充 |
| MySQL | 8.0 | 5.7 | 建議 8.0，charset=utf8mb4 |
| Web Server | Nginx / Apache | — | `public/` 為 document root |
| HTTPS | 必須 | — | 正式環境必須 HTTPS，session cookie secure 依此生效 |

### PHP 擴充確認指令
```bash
php -m | grep -E "pdo_mysql|mbstring|json"
```
三個擴充都應出現在輸出中。

---

## 一、Web Server 設定

### Document Root
```
/path/to/anime-guess/public/
```

**Nginx 範例**
```nginx
root /path/to/anime-guess/public;
index index.php;

location / {
    try_files $uri $uri/ /index.php$is_args$args;
}

location ~ \.php$ {
    fastcgi_pass unix:/run/php/php8.x-fpm.sock;
    fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
    include fastcgi_params;
}
```

**Apache 範例**（需啟用 `mod_rewrite`）
```apache
DocumentRoot /path/to/anime-guess/public
<Directory /path/to/anime-guess/public>
    AllowOverride All
    Require all granted
</Directory>
```

`public/.htaccess` 已包含必要的 rewrite 規則（將所有非靜態檔案/目錄的請求轉向 `index.php`）：
```apache
Options -MultiViews
RewriteEngine On
RewriteCond %{REQUEST_FILENAME} !-f
RewriteCond %{REQUEST_FILENAME} !-d
RewriteRule ^ index.php [QSA,L]
```
確認 `public/.htaccess` 存在且 Apache `mod_rewrite` 已啟用；若缺少此檔案，pretty URL 路由（`/works/1`、`/quiz/{token}` 等）將回傳 404。

---

## 二、環境設定（config/.env）

1. 複製範本：
```bash
cp config/.env.example config/.env
```

2. 填入以下設定：
```env
APP_ENV=production          # 必須設為 production 才會啟用 session cookie secure
APP_URL=https://your-domain.com
APP_TIMEZONE=Asia/Taipei

DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=your_production_db
DB_USERNAME=your_db_user
DB_PASSWORD=your_strong_password

SESSION_NAME=anime_guess_session
```

> **安全提醒**：`config/.env` 不可放在 web root 對外可存取位置；`.gitignore` 已排除此檔案，請勿 commit。

---

## 三、Session Cookie Secure（已完成）

`src/Support/Session.php` 已完成最小修正（TASK-AGQ-017 sub-task 7）：

```php
session_set_cookie_params([
    'httponly' => true,
    'samesite' => 'Lax',
    'secure'   => Env::get('APP_ENV') === 'production',
]);
```

正式環境設定 `APP_ENV=production` 後，session cookie 會自動帶 `Secure` 旗標，防止 cookie 透過 HTTP 傳輸。

---

## 四、Composer 依賴安裝

```bash
cd /path/to/anime-guess
composer install --no-dev --optimize-autoloader
```

> 本專案無外部 Composer 套件，此步驟主要建立 autoloader。

---

## 五、Migration 執行順序

依序執行 12 個 migration（**必須照編號順序**，檔案名稱前綴已確保順序）：

```bash
php database/migrate.php
```

`migrate.php` 會自動跳過已套用的 migration（`schema_migrations` 表追蹤），可安全重複執行。

**Migration 檔案清單與依賴關係：**

| 編號 | 檔案 | 依賴 |
|---|---|---|
| 0001 | `create_anime_works_table.sql` | 無 |
| 0002 | `create_admin_users_table.sql` | 無 |
| 0003 | `create_questions_table.sql` | 0001 |
| 0004 | `create_quiz_sessions_table.sql` | 0001 |
| 0005 | `create_quiz_session_questions_table.sql` | 0003, 0004 |
| 0006 | `create_banned_words_table.sql` | 無 |
| 0007 | `add_difficulty_to_questions.sql` | 0003 |
| 0008 | `add_difficulty_score_to_questions.sql` | 0007 |
| 0009 | `expand_difficulty_enum_extreme.sql` | 0008 |
| 0010 | `create_question_difficulty_adjustments_table.sql` | 0001, 0003 |
| 0011 | `create_submission_attempts_table.sql` | 無 |
| 0012 | `create_question_feedbacks_table.sql` | 0001, 0003 |

---

## 六、Seed 執行（首次部署）

依序執行：

```bash
# 1. 建立後台管理員帳號（用強密碼）
php database/seeds/0001_seed_admin_user.php <username> <strong-password>
# 例：php database/seeds/0001_seed_admin_user.php admin MyStr0ng@Pass2026

# 2. 匯入禁用字詞
php database/seeds/0002_seed_banned_words.php

# 3. 匯入題庫（需指定資料庫連線）
mysql -u <user> -p<password> --default-character-set=utf8mb4 <database> < database/seeds/0003_seed_tw_external_test_questions.sql
mysql -u <user> -p<password> --default-character-set=utf8mb4 <database> < database/seeds/0004_seed_expand_questions.sql
mysql -u <user> -p<password> --default-character-set=utf8mb4 <database> < database/seeds/0005_seed_expand_other_works_to_50.sql
```

> **注意**：SQL seed 匯入時必須加 `--default-character-set=utf8mb4`，否則中文字元可能出現錯誤（實測已驗證）。

**後台帳密安全提醒：**
- 正式環境請使用強密碼（12 字元以上，含大小寫、數字、符號）
- 不可使用測試帳密（如 `testadmin` / `TestPass2026!`）
- 不可 commit 帳密到 git

---

## 七、PHP 錯誤顯示設定

正式環境 `php.ini` 應設定：
```ini
display_errors = Off
log_errors = On
error_log = /path/to/anime-guess/storage/logs/php-error.log
```

確認 `storage/logs/` 目錄存在且 web server 使用者有寫入權限：
```bash
mkdir -p storage/logs
chmod 775 storage/logs
chown www-data:www-data storage/logs  # 依實際 web server 使用者調整
```

---

## 八、部署後驗證（Quick Smoke Test）

| 步驟 | 網址 | 預期結果 |
|---|---|---|
| 首頁 | `/` | 10 款作品顯示正常 |
| 作品介紹 | `/works/1` | 頁面正常，可點「開始作答」 |
| 開始作答 | POST `/works/1/start` | 重導向到 `/quiz/{token}` |
| 答題 | `/quiz/{token}` | 題目正常顯示 |
| 結果頁 | `/quiz/{token}/result` | 成績正常顯示，回饋 CTA 出現 |
| 後台登入 | `/admin/login` | 輸入帳密後重導向 `/admin` |
| 後台 Dashboard | `/admin` | 正常顯示（需 HTTPS，否則 session cookie secure 可能造成無法登入） |

---

## 九、已知已解決的部署議題

| 議題 | 狀態 |
|---|---|
| Session cookie 缺少 `secure` 旗標 | ✅ 已修正（TASK-AGQ-017，設 `APP_ENV=production` 即生效） |
| SQL seed 中文字元需 `--default-character-set=utf8mb4` | ✅ 已文件化 |
| Migration 可重複執行（idempotent） | ✅ `schema_migrations` 表追蹤已套用 migration，runner 自動跳過；`CREATE TABLE` 類 migration 加 `IF NOT EXISTS`，`ALTER TABLE` 類（0007~0009）由 runner 追蹤保護，合計形成完整 idempotent 保護 |
