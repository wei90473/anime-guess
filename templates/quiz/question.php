<?php

declare(strict_types=1);

/**
 * @var array $session
 * @var array $question
 * @var array $choices
 * @var int $currentIndex
 * @var int $total
 */

use App\Support\Csrf;

$difficultyLabels = [
    'easy' => '簡單',
    'normal' => '普通',
    'hard' => '困難',
];
$difficultyLabel = $difficultyLabels[$question['difficulty']] ?? '普通';

?>
<div class="quiz-question">
    <p class="quiz-progress">第 <?= (int) $currentIndex ?> 題 / 共 <?= (int) $total ?> 題
        <span class="quiz-difficulty-badge">難易度：<?= htmlspecialchars($difficultyLabel, ENT_QUOTES, 'UTF-8') ?></span>
    </p>

    <h1 class="quiz-prompt"><?= htmlspecialchars((string) $question['prompt'], ENT_QUOTES, 'UTF-8') ?></h1>

    <form method="post" action="/quiz/<?= htmlspecialchars((string) $session['session_token'], ENT_QUOTES, 'UTF-8') ?>/answer" class="quiz-answer-form">
        <?= Csrf::inputHtml() ?>
        <input type="hidden" name="question_id" value="<?= (int) $question['question_id'] ?>">

        <?php if ($question['type'] === 'multiple_choice'): ?>
            <fieldset class="quiz-choices">
                <?php foreach ($choices as $choice): ?>
                    <label class="quiz-choice">
                        <input type="radio" name="answer" value="<?= htmlspecialchars((string) $choice, ENT_QUOTES, 'UTF-8') ?>" required>
                        <?= htmlspecialchars((string) $choice, ENT_QUOTES, 'UTF-8') ?>
                    </label>
                <?php endforeach; ?>
            </fieldset>
        <?php else: ?>
            <input type="text" name="answer" class="quiz-fill-input" required>
            <p class="quiz-fill-hint">提示：答案約 <?= mb_strlen((string) $question['correct_answer'], 'UTF-8') ?> 字</p>
        <?php endif; ?>

        <button type="submit" class="quiz-submit-button">送出答案</button>
    </form>
</div>
