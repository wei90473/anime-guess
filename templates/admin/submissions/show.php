<?php

declare(strict_types=1);

/**
 * @var array $submission
 * @var array $choices
 * @var array $acceptedAnswers
 * @var array $flags
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

$flagLabels = [
    'possible_duplicate' => '疑似重複題目',
    'no_alt_answers' => '填字題未提供替代答案',
    'very_short_answer' => '正解過短',
];

$isPending = $submission['status'] === 'pending';

$nickname = $submission['submitted_nickname'] !== null && $submission['submitted_nickname'] !== ''
    ? (string) $submission['submitted_nickname']
    : '（無）';

?>
<div class="admin-submission-show">
    <h1>投稿詳情</h1>

    <p><a href="/admin/submissions">返回列表</a></p>

    <table class="admin-table" border="1" cellpadding="6" cellspacing="0">
        <tr>
            <th>作品</th>
            <td><?= htmlspecialchars((string) $submission['work_title'], ENT_QUOTES, 'UTF-8') ?></td>
        </tr>
        <tr>
            <th>題型</th>
            <td><?= htmlspecialchars($typeLabels[$submission['type']] ?? $submission['type'], ENT_QUOTES, 'UTF-8') ?></td>
        </tr>
        <tr>
            <th>難易度</th>
            <td><?= htmlspecialchars($difficultyLabels[$submission['difficulty']] ?? (string) $submission['difficulty'], ENT_QUOTES, 'UTF-8') ?></td>
        </tr>
        <tr>
            <th>題目內容</th>
            <td><?= htmlspecialchars((string) $submission['prompt'], ENT_QUOTES, 'UTF-8') ?></td>
        </tr>
        <?php if ($submission['type'] === 'multiple_choice'): ?>
            <tr>
                <th>選項</th>
                <td>
                    <ul>
                        <?php foreach ($choices as $choice): ?>
                            <?php $isCorrect = (string) $choice === (string) $submission['correct_answer']; ?>
                            <li<?= $isCorrect ? ' style="font-weight:bold;color:green;"' : '' ?>>
                                <?= htmlspecialchars((string) $choice, ENT_QUOTES, 'UTF-8') ?>
                                <?= $isCorrect ? '（正確答案）' : '' ?>
                            </li>
                        <?php endforeach; ?>
                    </ul>
                </td>
            </tr>
        <?php else: ?>
            <tr>
                <th>正確答案</th>
                <td><?= htmlspecialchars((string) $submission['correct_answer'], ENT_QUOTES, 'UTF-8') ?></td>
            </tr>
            <tr>
                <th>替代答案</th>
                <td>
                    <?php if (empty($acceptedAnswers)): ?>
                        （無）
                    <?php else: ?>
                        <ul>
                            <?php foreach ($acceptedAnswers as $answer): ?>
                                <li><?= htmlspecialchars((string) $answer, ENT_QUOTES, 'UTF-8') ?></li>
                            <?php endforeach; ?>
                        </ul>
                    <?php endif; ?>
                </td>
            </tr>
        <?php endif; ?>
        <tr>
            <th>投稿者暱稱</th>
            <td><?= htmlspecialchars($nickname, ENT_QUOTES, 'UTF-8') ?></td>
        </tr>
        <tr>
            <th>警示</th>
            <td>
                <?php if (empty($flags)): ?>
                    （無）
                <?php else: ?>
                    <ul>
                        <?php foreach ($flags as $flag): ?>
                            <li><?= htmlspecialchars($flagLabels[$flag] ?? (string) $flag, ENT_QUOTES, 'UTF-8') ?></li>
                        <?php endforeach; ?>
                    </ul>
                <?php endif; ?>
            </td>
        </tr>
        <tr>
            <th>狀態</th>
            <td><?= htmlspecialchars($statusLabels[$submission['status']] ?? $submission['status'], ENT_QUOTES, 'UTF-8') ?></td>
        </tr>
        <?php if (!$isPending): ?>
            <tr>
                <th>審核時間</th>
                <td><?= htmlspecialchars((string) ($submission['reviewed_at'] ?? ''), ENT_QUOTES, 'UTF-8') ?></td>
            </tr>
            <?php if ($submission['status'] === 'rejected'): ?>
                <tr>
                    <th>拒絕原因</th>
                    <td><?= htmlspecialchars((string) ($submission['rejection_reason'] ?? ''), ENT_QUOTES, 'UTF-8') ?></td>
                </tr>
            <?php endif; ?>
        <?php endif; ?>
    </table>

    <?php if ($isPending): ?>
        <form method="post" action="/admin/submissions/<?= (int) $submission['id'] ?>/approve" style="display:inline">
            <?= Csrf::inputHtml() ?>
            <button type="submit">核准</button>
        </form>

        <form method="post" action="/admin/submissions/<?= (int) $submission['id'] ?>/reject"
            onsubmit="return confirm('確定要拒絕並刪除此投稿？此動作無法復原');" style="display:inline">
            <?= Csrf::inputHtml() ?>
            <button type="submit">拒絕（將刪除此投稿）</button>
        </form>
    <?php endif; ?>
</div>
