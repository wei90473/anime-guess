<?php

declare(strict_types=1);

/**
 * @var array|null $question
 * @var array $works
 * @var array $errors
 * @var array $old
 */

use App\Support\Csrf;

$isEdit = $question !== null;

$workId = $old['anime_work_id'] ?? ($question['anime_work_id'] ?? '');
$type = $old['type'] ?? ($question['type'] ?? 'multiple_choice');
$difficulty = $old['difficulty'] ?? ($question['difficulty'] ?? 'normal');
$prompt = $old['prompt'] ?? ($question['prompt'] ?? '');
$correctAnswer = $old['correct_answer'] ?? ($question['correct_answer'] ?? '');

if (isset($old['choices'])) {
    $choices = $old['choices'];
} elseif ($isEdit && $question['choices_json'] !== null) {
    $decodedChoices = json_decode($question['choices_json'], true);
    $choices = is_array($decodedChoices) ? $decodedChoices : [];
} else {
    $choices = [];
}

while (count($choices) < 4) {
    $choices[] = '';
}

if (isset($old['accepted_answers'])) {
    $acceptedAnswersText = $old['accepted_answers'];
} elseif ($isEdit && $question['accepted_answers_json'] !== null) {
    $decodedAnswers = json_decode($question['accepted_answers_json'], true);
    $acceptedAnswersText = is_array($decodedAnswers) ? implode("\n", $decodedAnswers) : '';
} else {
    $acceptedAnswersText = '';
}

$action = $isEdit ? '/admin/questions/' . (int) $question['id'] : '/admin/questions';

$difficultyLabels = [
    'easy' => '簡單',
    'normal' => '普通',
    'hard' => '困難',
    'extreme' => '極難',
];

?>
<div class="admin-question-form">
    <h1><?= $isEdit ? '編輯題目' : '新增題目' ?></h1>

    <?php if (!empty($errors)): ?>
        <ul class="admin-error">
            <?php foreach ($errors as $error): ?>
                <li><?= htmlspecialchars($error, ENT_QUOTES, 'UTF-8') ?></li>
            <?php endforeach; ?>
        </ul>
    <?php endif; ?>

    <form method="post" action="<?= htmlspecialchars($action, ENT_QUOTES, 'UTF-8') ?>">
        <?= Csrf::inputHtml() ?>

        <label for="anime_work_id">作品</label>
        <select id="anime_work_id" name="anime_work_id" required>
            <option value="">請選擇作品</option>
            <?php foreach ($works as $work): ?>
                <option value="<?= (int) $work['id'] ?>"<?= (string) $workId === (string) $work['id'] ? ' selected' : '' ?>>
                    <?= htmlspecialchars($work['title'], ENT_QUOTES, 'UTF-8') ?>
                </option>
            <?php endforeach; ?>
        </select>

        <fieldset>
            <legend>題型</legend>
            <label>
                <input type="radio" name="type" value="multiple_choice" class="question-type-input"
                    <?= $type === 'multiple_choice' ? 'checked' : '' ?>>
                選擇題
            </label>
            <label>
                <input type="radio" name="type" value="fill_blank" class="question-type-input"
                    <?= $type === 'fill_blank' ? 'checked' : '' ?>>
                填字題
            </label>
        </fieldset>

        <label for="difficulty">難易度</label>
        <select id="difficulty" name="difficulty" required>
            <?php foreach ($difficultyLabels as $value => $label): ?>
                <option value="<?= htmlspecialchars($value, ENT_QUOTES, 'UTF-8') ?>"<?= (string) $difficulty === $value ? ' selected' : '' ?>>
                    <?= htmlspecialchars($label, ENT_QUOTES, 'UTF-8') ?>
                </option>
            <?php endforeach; ?>
        </select>

        <label for="prompt">題目內容</label>
        <textarea id="prompt" name="prompt" rows="3" required><?= htmlspecialchars((string) $prompt, ENT_QUOTES, 'UTF-8') ?></textarea>

        <div id="choices-section">
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

        <div id="accepted-answers-section">
            <label for="accepted_answers">可接受的替代答案（每行一個，選填）</label>
            <textarea id="accepted_answers" name="accepted_answers" rows="4"><?= htmlspecialchars((string) $acceptedAnswersText, ENT_QUOTES, 'UTF-8') ?></textarea>
        </div>

        <button type="submit"><?= $isEdit ? '儲存' : '新增' ?></button>
    </form>

    <p><a href="/admin/questions">返回題目列表</a></p>
</div>

<script>
(function () {
    var choicesSection = document.getElementById('choices-section');
    var acceptedAnswersSection = document.getElementById('accepted-answers-section');
    var typeInputs = document.querySelectorAll('.question-type-input');

    function updateVisibility() {
        var selected = document.querySelector('.question-type-input:checked');
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
