<?php

declare(strict_types=1);

/**
 * @var int $pendingSubmissions
 * @var int $totalWorks
 * @var int $approvedQuestions
 */

use App\Support\Csrf;

?>
<div class="admin-dashboard">
    <h1>管理後台</h1>

    <ul class="admin-stats">
        <li>待審投稿：<strong><?= (int) $pendingSubmissions ?></strong></li>
        <li>作品總數：<strong><?= (int) $totalWorks ?></strong></li>
        <li>已核准題目總數：<strong><?= (int) $approvedQuestions ?></strong></li>
    </ul>

    <nav class="admin-nav">
        <a href="/admin/works">作品管理</a>
        <a href="/admin/questions">題目管理</a>
        <a href="/admin/submissions">投稿審核</a>
    </nav>

    <form method="post" action="/admin/logout">
        <?= Csrf::inputHtml() ?>
        <button type="submit">登出</button>
    </form>
</div>
