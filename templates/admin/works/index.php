<?php

declare(strict_types=1);

/**
 * @var array $works
 */

use App\Support\Csrf;

?>
<div class="admin-works">
    <h1>作品管理</h1>

    <p><a href="/admin/works/create">新增作品</a></p>

    <table class="admin-table" border="1" cellpadding="6" cellspacing="0">
        <thead>
        <tr>
            <th>ID</th>
            <th>名稱</th>
            <th>Slug</th>
            <th>狀態</th>
            <th>建立時間</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <?php if (empty($works)): ?>
            <tr>
                <td colspan="6">尚無作品</td>
            </tr>
        <?php endif; ?>
        <?php foreach ($works as $work): ?>
            <?php $isActive = (int) $work['is_active'] === 1; ?>
            <tr<?= $isActive ? '' : ' style="color:#999;text-decoration:line-through;"' ?>>
                <td><?= (int) $work['id'] ?></td>
                <td><?= htmlspecialchars($work['title'], ENT_QUOTES, 'UTF-8') ?></td>
                <td><?= htmlspecialchars($work['slug'], ENT_QUOTES, 'UTF-8') ?></td>
                <td><?= $isActive ? '上架' : '下架' ?></td>
                <td><?= htmlspecialchars($work['created_at'], ENT_QUOTES, 'UTF-8') ?></td>
                <td>
                    <a href="/admin/works/<?= (int) $work['id'] ?>/edit">編輯</a>
                    <form method="post" action="/admin/works/<?= (int) $work['id'] ?>/toggle" style="display:inline">
                        <?= Csrf::inputHtml() ?>
                        <button type="submit"><?= $isActive ? '下架' : '上架' ?></button>
                    </form>
                </td>
            </tr>
        <?php endforeach; ?>
        </tbody>
    </table>
</div>
