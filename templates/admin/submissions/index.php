<?php

declare(strict_types=1);

/**
 * @var array $submissions
 */

$typeLabels = [
    'multiple_choice' => '選擇題',
    'fill_blank' => '填字題',
];

$flagLabels = [
    'possible_duplicate' => '⚠ 疑似重複',
    'no_alt_answers' => '⚠ 無替代答案',
    'very_short_answer' => '⚠ 正解過短',
];

?>
<div class="admin-submissions">
    <h1>投稿審核</h1>

    <p>待審投稿數量：<?= count($submissions) ?></p>

    <?php if (empty($submissions)): ?>
        <p>目前沒有待審投稿</p>
    <?php else: ?>
        <table class="admin-table" border="1" cellpadding="6" cellspacing="0">
            <thead>
            <tr>
                <th>ID</th>
                <th>作品</th>
                <th>題型</th>
                <th>題目內容</th>
                <th>投稿者</th>
                <th>警示</th>
                <th>投稿時間</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <?php foreach ($submissions as $submission): ?>
                <?php
                $prompt = (string) $submission['prompt'];
                $promptShort = mb_strlen($prompt, 'UTF-8') > 60 ? mb_substr($prompt, 0, 60, 'UTF-8') . '…' : $prompt;

                $flags = [];
                if (!empty($submission['filter_flags'])) {
                    $decoded = json_decode((string) $submission['filter_flags'], true);
                    $flags = is_array($decoded) ? $decoded : [];
                }

                $nickname = $submission['submitted_nickname'] !== null && $submission['submitted_nickname'] !== ''
                    ? (string) $submission['submitted_nickname']
                    : '（匿名）';
                ?>
                <tr>
                    <td><?= (int) $submission['id'] ?></td>
                    <td><?= htmlspecialchars((string) $submission['work_title'], ENT_QUOTES, 'UTF-8') ?></td>
                    <td><?= htmlspecialchars($typeLabels[$submission['type']] ?? $submission['type'], ENT_QUOTES, 'UTF-8') ?></td>
                    <td><?= htmlspecialchars($promptShort, ENT_QUOTES, 'UTF-8') ?></td>
                    <td><?= htmlspecialchars($nickname, ENT_QUOTES, 'UTF-8') ?></td>
                    <td>
                        <?php foreach ($flags as $flag): ?>
                            <span class="admin-flag-tag"><?= htmlspecialchars($flagLabels[$flag] ?? ('⚠ ' . $flag), ENT_QUOTES, 'UTF-8') ?></span>
                        <?php endforeach; ?>
                    </td>
                    <td><?= htmlspecialchars((string) $submission['created_at'], ENT_QUOTES, 'UTF-8') ?></td>
                    <td><a href="/admin/submissions/<?= (int) $submission['id'] ?>">查看詳情</a></td>
                </tr>
            <?php endforeach; ?>
            </tbody>
        </table>
    <?php endif; ?>
</div>
