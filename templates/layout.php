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
<?php /* header/footer/nav partials 由 AGQ-011 補齊 */ ?>
<main>
<?= $content ?? '' ?>
</main>
</body>
</html>
