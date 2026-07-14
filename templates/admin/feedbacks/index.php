<?php

declare(strict_types=1);

/**
 * @var array $feedbacks
 * @var array $works
 * @var array $filters
 */

$feedbackTypeLabels = [
    'wrong_answer'       => '答案錯誤',
    'unclear_prompt'     => '題目敘述不清',
    'bad_choices'        => '選項有問題',
    'difficulty_mismatch' => '難易度不準',
    'other'              => '其他',
];

$statusLabels = [
    'open'     => '未處理',
    'resolved' => '已處理',
    'ignored'  => '已忽略',
];

$difficultyLabels = [
    'easy'    => '簡單',
    'normal'  => '普通',
    'hard'    => '困難',
    'extreme' => '極難',
];

?>
<div class="admin-feedbacks">
    <h1>題目回饋</h1>

    <form method="get" action="/admin/feedbacks" class="admin-filter-form">
        <label>作品：
            <select name="work_id">
                <option value="">全部</option>
                <?php foreach ($works as $work): ?>
                    <option value="<?= (int) $work['id'] ?>"
                        <?= (string) ($filters['work_id'] ?? '') === (string) $work['id'] ? 'selected' : '' ?>>
                        <?= htmlspecialchars((string) $work['title'], ENT_QUOTES, 'UTF-8') ?>
                    </option>
                <?php endforeach; ?>
            </select>
        </label>
        <label>狀態：
            <select name="status">
                <option value="">全部</option>
                <?php foreach ($statusLabels as $val => $label): ?>
                    <option value="<?= htmlspecialchars($val, ENT_QUOTES, 'UTF-8') ?>"
                        <?= ($filters['status'] ?? '') === $val ? 'selected' : '' ?>>
                        <?= htmlspecialchars($label, ENT_QUOTES, 'UTF-8') ?>
                    </option>
                <?php endforeach; ?>
            </select>
        </label>
        <label>回饋類型：
            <select name="feedback_type">
                <option value="">全部</option>
                <?php foreach ($feedbackTypeLabels as $val => $label): ?>
                    <option value="<?= htmlspecialchars($val, ENT_QUOTES, 'UTF-8') ?>"
                        <?= ($filters['feedback_type'] ?? '') === $val ? 'selected' : '' ?>>
                        <?= htmlspecialchars($label, ENT_QUOTES, 'UTF-8') ?>
                    </option>
                <?php endforeach; ?>
            </select>
        </label>
        <button type="submit">篩選</button>
    </form>

    <p>回饋筆數：<?= count($feedbacks) ?></p>

    <?php if (empty($feedbacks)): ?>
        <p>目前沒有回饋資料</p>
    <?php else: ?>
        <table class="admin-table" border="1" cellpadding="6" cellspacing="0">
            <thead>
            <tr>
                <th>ID</th>
                <th>作品</th>
                <th>題目</th>
                <th>目前難易度</th>
                <th>回饋類型</th>
                <th>建議難易度</th>
                <th>回饋內容</th>
                <th>狀態</th>
                <th>時間</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <?php foreach ($feedbacks as $feedback): ?>
                <?php
                $prompt = (string) $feedback['prompt'];
                $promptShort = mb_strlen($prompt, 'UTF-8') > 50
                    ? mb_substr($prompt, 0, 50, 'UTF-8') . '…'
                    : $prompt;
                ?>
                <tr>
                    <td><?= (int) $feedback['id'] ?></td>
                    <td><?= htmlspecialchars((string) $feedback['work_title'], ENT_QUOTES, 'UTF-8') ?></td>
                    <td>
                        <a href="/admin/questions/<?= (int) $feedback['question_id'] ?>/edit">
                            <?= htmlspecialchars($promptShort, ENT_QUOTES, 'UTF-8') ?>
                        </a>
                    </td>
                    <td><?= htmlspecialchars($difficultyLabels[$feedback['difficulty']] ?? (string) $feedback['difficulty'], ENT_QUOTES, 'UTF-8') ?></td>
                    <td><?= htmlspecialchars($feedbackTypeLabels[$feedback['feedback_type']] ?? (string) $feedback['feedback_type'], ENT_QUOTES, 'UTF-8') ?></td>
                    <td><?= $feedback['suggested_difficulty'] !== null
                        ? htmlspecialchars($difficultyLabels[$feedback['suggested_difficulty']] ?? (string) $feedback['suggested_difficulty'], ENT_QUOTES, 'UTF-8')
                        : '—' ?></td>
                    <td><?= $feedback['message'] !== null
                        ? htmlspecialchars((string) $feedback['message'], ENT_QUOTES, 'UTF-8')
                        : '（無）' ?></td>
                    <td><?= htmlspecialchars($statusLabels[$feedback['status']] ?? (string) $feedback['status'], ENT_QUOTES, 'UTF-8') ?></td>
                    <td><?= htmlspecialchars((string) $feedback['created_at'], ENT_QUOTES, 'UTF-8') ?></td>
                    <td>
                        <form method="post" action="/admin/feedbacks/<?= (int) $feedback['id'] ?>/status" style="display:inline;">
                            <?= \App\Support\Csrf::inputHtml() ?>
                            <input type="hidden" name="work_id" value="<?= htmlspecialchars((string) ($filters['work_id'] ?? ''), ENT_QUOTES, 'UTF-8') ?>">
                            <input type="hidden" name="filter_status" value="<?= htmlspecialchars((string) ($filters['status'] ?? ''), ENT_QUOTES, 'UTF-8') ?>">
                            <input type="hidden" name="feedback_type" value="<?= htmlspecialchars((string) ($filters['feedback_type'] ?? ''), ENT_QUOTES, 'UTF-8') ?>">
                            <select name="status">
                                <option value="open" <?= $feedback['status'] === 'open' ? 'selected' : '' ?>>未處理</option>
                                <option value="resolved" <?= $feedback['status'] === 'resolved' ? 'selected' : '' ?>>已處理</option>
                                <option value="ignored" <?= $feedback['status'] === 'ignored' ? 'selected' : '' ?>>已忽略</option>
                            </select>
                            <button type="submit">更新</button>
                        </form>
                    </td>
                </tr>
            <?php endforeach; ?>
            </tbody>
        </table>
    <?php endif; ?>
</div>
