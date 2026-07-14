<?php

declare(strict_types=1);

/**
 * @var array $questions
 * @var array $works
 * @var array $filters
 */

use App\Support\Csrf;

$typeLabels = [
    'multiple_choice' => '選擇題',
    'fill_blank' => '填字題',
];

$difficultyLabels = [
    'easy' => '簡單',
    'normal' => '普通',
    'hard' => '困難',
    'extreme' => '極難',
];

$statusLabels = [
    'pending' => '待審',
    'approved' => '已核准',
    'rejected' => '已拒絕',
];

?>
<div class="admin-questions">
    <h1>題目管理</h1>

    <p><a href="/admin/questions/create">新增題目</a></p>

    <form method="get" action="/admin/questions" class="admin-filters">
        <label for="filter_work_id">依作品篩選</label>
        <select id="filter_work_id" name="work_id">
            <option value="">全部作品</option>
            <?php foreach ($works as $work): ?>
                <option value="<?= (int) $work['id'] ?>"<?= (string) $filters['work_id'] === (string) $work['id'] ? ' selected' : '' ?>>
                    <?= htmlspecialchars($work['title'], ENT_QUOTES, 'UTF-8') ?>
                </option>
            <?php endforeach; ?>
        </select>

        <label for="filter_status">依狀態篩選</label>
        <select id="filter_status" name="status">
            <option value="">全部狀態</option>
            <?php foreach ($statusLabels as $value => $label): ?>
                <option value="<?= htmlspecialchars($value, ENT_QUOTES, 'UTF-8') ?>"<?= $filters['status'] === $value ? ' selected' : '' ?>>
                    <?= htmlspecialchars($label, ENT_QUOTES, 'UTF-8') ?>
                </option>
            <?php endforeach; ?>
        </select>

        <button type="submit">篩選</button>
    </form>

    <table class="admin-table" border="1" cellpadding="6" cellspacing="0">
        <thead>
        <tr>
            <th>ID</th>
            <th>作品</th>
            <th>題型</th>
            <th>難易度</th>
            <th>題目內容</th>
            <th>狀態</th>
            <th>上下架</th>
            <th>建立時間</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <?php if (empty($questions)): ?>
            <tr>
                <td colspan="9">尚無題目</td>
            </tr>
        <?php endif; ?>
        <?php foreach ($questions as $question): ?>
            <?php
            $isActive = (int) $question['is_active'] === 1;
            $prompt = $question['prompt'];
            $promptShort = mb_strlen($prompt, 'UTF-8') > 50 ? mb_substr($prompt, 0, 50, 'UTF-8') . '…' : $prompt;
            ?>
            <tr<?= $isActive ? '' : ' style="color:#999;text-decoration:line-through;"' ?>>
                <td><?= (int) $question['id'] ?></td>
                <td><?= htmlspecialchars($question['work_title'], ENT_QUOTES, 'UTF-8') ?></td>
                <td><?= htmlspecialchars($typeLabels[$question['type']] ?? $question['type'], ENT_QUOTES, 'UTF-8') ?></td>
                <td><?= htmlspecialchars($difficultyLabels[$question['difficulty']] ?? $question['difficulty'], ENT_QUOTES, 'UTF-8') ?></td>
                <td><?= htmlspecialchars($promptShort, ENT_QUOTES, 'UTF-8') ?></td>
                <td><?= htmlspecialchars($statusLabels[$question['status']] ?? $question['status'], ENT_QUOTES, 'UTF-8') ?></td>
                <td><?= $isActive ? '上架' : '下架' ?></td>
                <td><?= htmlspecialchars($question['created_at'], ENT_QUOTES, 'UTF-8') ?></td>
                <td>
                    <a href="/admin/questions/<?= (int) $question['id'] ?>/edit">編輯</a>
                    <form method="post" action="/admin/questions/<?= (int) $question['id'] ?>/toggle" style="display:inline">
                        <?= Csrf::inputHtml() ?>
                        <button type="submit"><?= $isActive ? '下架' : '上架' ?></button>
                    </form>
                </td>
            </tr>
        <?php endforeach; ?>
        </tbody>
    </table>
</div>
