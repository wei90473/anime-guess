<?php

declare(strict_types=1);

/**
 * @var array $session
 * @var array $questions
 */

?>
<div class="quiz-result">
    <h1>作答結果</h1>

    <?php
    $correctCount = 0;
    foreach ($questions as $item) {
        if (!empty($item['is_correct'])) {
            $correctCount++;
        }
    }
    $total = count($questions);
    ?>
    <p class="quiz-result-score">答對 <?= (int) $correctCount ?> / <?= (int) $total ?> 題</p>

    <ul class="quiz-result-list">
        <?php foreach ($questions as $index => $item): ?>
            <li class="quiz-result-item <?= !empty($item['is_correct']) ? 'is-correct' : 'is-wrong' ?>">
                <p class="quiz-result-prompt">第 <?= (int) $index + 1 ?> 題：<?= htmlspecialchars((string) $item['prompt'], ENT_QUOTES, 'UTF-8') ?></p>
                <p class="quiz-result-answer">你的答案：<?= htmlspecialchars((string) ($item['player_answer'] ?? ''), ENT_QUOTES, 'UTF-8') ?></p>
                <p class="quiz-result-correct">正確答案：<?= htmlspecialchars((string) $item['correct_answer'], ENT_QUOTES, 'UTF-8') ?></p>
                <p class="quiz-result-mark"><?= !empty($item['is_correct']) ? '答對' : '答錯' ?></p>
            </li>
        <?php endforeach; ?>
    </ul>

    <p class="quiz-result-actions">
        <a href="/works/<?= (int) $session['anime_work_id'] ?>">再玩一次</a>
        &nbsp;|&nbsp;
        <a href="/">回首頁</a>
    </p>
</div>
