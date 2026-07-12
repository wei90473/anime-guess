<?php

declare(strict_types=1);

/**
 * @var array $session
 * @var array $question
 * @var int $currentIndex
 * @var int $total
 */

use App\Support\Csrf;

$choices = [];

if ($question['type'] === 'multiple_choice' && !empty($question['choices_json'])) {
    $decoded = json_decode((string) $question['choices_json'], true);
    $choices = is_array($decoded) ? $decoded : [];
}

?>
<div class="quiz-question">
    <p class="quiz-progress">第 <?= (int) $currentIndex ?> 題 / 共 <?= (int) $total ?> 題</p>

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
        <?php endif; ?>

        <button type="submit" class="quiz-submit-button">送出答案</button>
    </form>
</div>
