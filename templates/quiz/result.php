<?php

declare(strict_types=1);

/**
 * @var array $session
 * @var array $questions
 * @var array $summary
 */

?>
<div class="quiz-result">
    <h1>作答結果</h1>

    <?php if (!empty($_GET['feedback'])): ?>
        <p class="quiz-feedback-thanks">感謝回饋，我們會盡快處理。</p>
    <?php endif; ?>

    <p class="quiz-result-score">答對 <?= (int) $summary['correct_count'] ?> / <?= (int) $summary['total'] ?> 題（<?= (int) $summary['percent'] ?>%）</p>

    <div class="quiz-result-bar-track">
        <div class="quiz-result-bar-fill" style="width: <?= (int) $summary['percent'] ?>%;"></div>
    </div>

    <p class="quiz-result-praise"><?= htmlspecialchars((string) $summary['praise'], ENT_QUOTES, 'UTF-8') ?></p>

    <ul class="quiz-result-list">
        <?php foreach ($questions as $index => $item): ?>
            <li class="quiz-result-item <?= !empty($item['is_correct']) ? 'is-correct' : 'is-wrong' ?>">
                <p class="quiz-result-prompt">第 <?= (int) $index + 1 ?> 題：<?= htmlspecialchars((string) $item['prompt'], ENT_QUOTES, 'UTF-8') ?></p>
                <p class="quiz-result-answer">你的答案：<?= htmlspecialchars((string) ($item['player_answer'] ?? ''), ENT_QUOTES, 'UTF-8') ?></p>
                <p class="quiz-result-correct">正確答案：<?= htmlspecialchars((string) $item['correct_answer'], ENT_QUOTES, 'UTF-8') ?></p>
                <p class="quiz-result-mark"><?= !empty($item['is_correct']) ? '答對' : '答錯' ?></p>
                <details class="quiz-feedback">
                    <summary>這題有問題？</summary>
                    <form method="post" action="/questions/<?= (int) $item['question_id'] ?>/feedback">
                        <?= \App\Support\Csrf::inputHtml() ?>
                        <input type="hidden" name="session_token" value="<?= htmlspecialchars((string) $session['session_token'], ENT_QUOTES, 'UTF-8') ?>">
                        <label>回饋類型：
                            <select name="feedback_type" required>
                                <option value="">請選擇</option>
                                <option value="wrong_answer">答案錯誤</option>
                                <option value="unclear_prompt">題目敘述不清</option>
                                <option value="bad_choices">選項有問題</option>
                                <option value="difficulty_mismatch">難易度不準</option>
                                <option value="other">其他</option>
                            </select>
                        </label>
                        <label>建議難易度（若認為難易度不準可選填）：
                            <select name="suggested_difficulty">
                                <option value="">不確定</option>
                                <option value="easy">簡單</option>
                                <option value="normal">普通</option>
                                <option value="hard">困難</option>
                                <option value="extreme">極難</option>
                            </select>
                        </label>
                        <label>留言（選填）：
                            <textarea name="message" maxlength="500" rows="2"></textarea>
                        </label>
                        <button type="submit">送出回饋</button>
                    </form>
                </details>
            </li>
        <?php endforeach; ?>
    </ul>

    <p class="quiz-result-actions">
        <a href="/works/<?= (int) $session['anime_work_id'] ?>">再玩一次</a>
        &nbsp;|&nbsp;
        <a href="/">回首頁</a>
    </p>
</div>
