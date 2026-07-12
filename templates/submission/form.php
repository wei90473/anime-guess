<?php

declare(strict_types=1);

/**
 * @var array $works
 * @var array $errors
 * @var array $old
 */

use App\Support\Csrf;

$animeWorkId = $old['anime_work_id'] ?? '';
$type = $old['type'] ?? 'multiple_choice';
$prompt = $old['prompt'] ?? '';
$correctAnswer = $old['correct_answer'] ?? '';
$acceptedAnswers = $old['accepted_answers'] ?? '';
$nickname = $old['submitted_nickname'] ?? '';

$choices = is_array($old['choices'] ?? null) ? $old['choices'] : [];

while (count($choices) < 4) {
    $choices[] = '';
}

?>
<div class="submission-form">
    <h1>投稿題目</h1>

    <?php if (!empty($errors)): ?>
        <ul class="submission-error">
            <?php foreach ($errors as $error): ?>
                <li><?= htmlspecialchars($error, ENT_QUOTES, 'UTF-8') ?></li>
            <?php endforeach; ?>
        </ul>
    <?php endif; ?>

    <form method="post" action="/submit">
        <?= Csrf::inputHtml() ?>

        <label for="anime_work_id">作品</label>
        <select id="anime_work_id" name="anime_work_id" required>
            <option value="">請選擇作品</option>
            <?php foreach ($works as $work): ?>
                <option value="<?= (int) $work['id'] ?>"<?= (string) $animeWorkId === (string) $work['id'] ? ' selected' : '' ?>>
                    <?= htmlspecialchars($work['title'], ENT_QUOTES, 'UTF-8') ?>
                </option>
            <?php endforeach; ?>
        </select>

        <fieldset>
            <legend>題型</legend>
            <label>
                <input type="radio" name="type" value="multiple_choice" class="submission-type-input"
                    <?= $type === 'multiple_choice' ? 'checked' : '' ?>>
                選擇題
            </label>
            <label>
                <input type="radio" name="type" value="fill_blank" class="submission-type-input"
                    <?= $type === 'fill_blank' ? 'checked' : '' ?>>
                填字題
            </label>
        </fieldset>

        <label for="prompt">題目內容</label>
        <textarea id="prompt" name="prompt" rows="3" required><?= htmlspecialchars((string) $prompt, ENT_QUOTES, 'UTF-8') ?></textarea>

        <div id="submission-choices-section">
            <p>選項（4 個）</p>
            <?php foreach ($choices as $index => $choice): ?>
                <?php if ($index >= 4) { break; } ?>
                <label for="choice_<?= $index ?>">選項 <?= $index + 1 ?></label>
                <input type="text" id="choice_<?= $index ?>" name="choices[]"
                    value="<?= htmlspecialchars((string) $choice, ENT_QUOTES, 'UTF-8') ?>">
            <?php endforeach; ?>
        </div>

        <label for="correct_answer">正確答案</label>
        <input type="text" id="correct_answer" name="correct_answer" maxlength="100" required
            value="<?= htmlspecialchars((string) $correctAnswer, ENT_QUOTES, 'UTF-8') ?>">

        <div id="submission-accepted-answers-section">
            <label for="accepted_answers">替代答案（可選，每行一個替代寫法）</label>
            <textarea id="accepted_answers" name="accepted_answers" rows="4"><?= htmlspecialchars((string) $acceptedAnswers, ENT_QUOTES, 'UTF-8') ?></textarea>
        </div>

        <label for="submitted_nickname">投稿暱稱（選填）</label>
        <input type="text" id="submitted_nickname" name="submitted_nickname" maxlength="50"
            value="<?= htmlspecialchars((string) $nickname, ENT_QUOTES, 'UTF-8') ?>">

        <button type="submit">送出投稿</button>
    </form>
</div>

<script>
(function () {
    var choicesSection = document.getElementById('submission-choices-section');
    var acceptedAnswersSection = document.getElementById('submission-accepted-answers-section');
    var typeInputs = document.querySelectorAll('.submission-type-input');

    function updateVisibility() {
        var selected = document.querySelector('.submission-type-input:checked');
        var type = selected ? selected.value : 'multiple_choice';

        choicesSection.style.display = type === 'multiple_choice' ? '' : 'none';
        acceptedAnswersSection.style.display = type === 'fill_blank' ? '' : 'none';
    }

    for (var i = 0; i < typeInputs.length; i++) {
        typeInputs[i].addEventListener('change', updateVisibility);
    }

    updateVisibility();
})();
</script>
