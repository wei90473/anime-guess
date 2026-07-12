<?php
/**
 * @var string $title
 * @var string $content
 */
?>
<!DOCTYPE html>
<html lang="zh-Hant">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><?= htmlspecialchars($title ?? 'Anime Guess', ENT_QUOTES, 'UTF-8') ?></title>
    <link rel="stylesheet" href="/assets/css/app.css">
</head>
<body>
<header class="site-header">
    <a href="/" class="site-header-title">Anime Guess</a>
    <nav class="site-nav">
        <a href="/">首頁</a>
        <a href="/submit">投稿題目</a>
    </nav>
</header>
<main>
<?= $content ?? '' ?>
</main>
</body>
</html>
