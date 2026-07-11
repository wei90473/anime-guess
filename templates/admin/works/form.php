<?php

declare(strict_types=1);

/**
 * @var array|null $work
 * @var array $errors
 * @var array $old
 */

use App\Support\Csrf;

$isEdit = $work !== null;
$title = $old['title'] ?? ($work['title'] ?? '');
$description = $old['description'] ?? ($work['description'] ?? '');
$coverImagePath = $old['cover_image_path'] ?? ($work['cover_image_path'] ?? '');
$action = $isEdit ? '/admin/works/' . (int) $work['id'] : '/admin/works';

?>
<div class="admin-work-form">
    <h1><?= $isEdit ? '編輯作品' : '新增作品' ?></h1>

    <?php if (!empty($errors)): ?>
        <ul class="admin-error">
            <?php foreach ($errors as $error): ?>
                <li><?= htmlspecialchars($error, ENT_QUOTES, 'UTF-8') ?></li>
            <?php endforeach; ?>
        </ul>
    <?php endif; ?>

    <form method="post" action="<?= htmlspecialchars($action, ENT_QUOTES, 'UTF-8') ?>">
        <?= Csrf::inputHtml() ?>

        <label for="title">作品名稱</label>
        <input type="text" id="title" name="title" maxlength="150" required
               value="<?= htmlspecialchars((string) $title, ENT_QUOTES, 'UTF-8') ?>">

        <label>Slug</label>
        <?php if ($isEdit): ?>
            <input type="text" value="<?= htmlspecialchars((string) $work['slug'], ENT_QUOTES, 'UTF-8') ?>" readonly>
        <?php else: ?>
            <p>儲存後自動產生</p>
        <?php endif; ?>

        <label for="description">簡介</label>
        <textarea id="description" name="description" rows="4"><?= htmlspecialchars((string) $description, ENT_QUOTES, 'UTF-8') ?></textarea>

        <label for="cover_image_path">封面圖片路徑（選填）</label>
        <input type="text" id="cover_image_path" name="cover_image_path"
               value="<?= htmlspecialchars((string) $coverImagePath, ENT_QUOTES, 'UTF-8') ?>">

        <button type="submit"><?= $isEdit ? '儲存' : '新增' ?></button>
    </form>

    <p><a href="/admin/works">返回作品列表</a></p>
</div>
