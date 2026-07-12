<?php

declare(strict_types=1);

/**
 * @var array $work
 * @var int $availableCount
 * @var string|null $error
 */

use App\Support\Csrf;

?>
<div class="work-show">
    <a href="/" class="back-link">← 回首頁</a>
    <h1><?= htmlspecialchars($work['title'], ENT_QUOTES, 'UTF-8') ?></h1>

    <?php if (!empty($work['description'])): ?>
        <p class="work-description"><?= nl2br(htmlspecialchars($work['description'], ENT_QUOTES, 'UTF-8')) ?></p>
    <?php endif; ?>

    <?php if (!empty($error)): ?>
        <p class="work-error"><?= htmlspecialchars($error, ENT_QUOTES, 'UTF-8') ?></p>
    <?php endif; ?>

    <?php if ($availableCount < 5): ?>
        <p class="work-insufficient">題目不足，無法開始</p>
    <?php else: ?>
        <form method="post" action="/works/<?= (int) $work['id'] ?>/start" class="work-start-form">
            <?= Csrf::inputHtml() ?>

            <fieldset>
                <legend>選擇題數</legend>

                <label>
                    <input type="radio" name="question_count" value="5" checked>
                    5 題
                </label>

                <?php if ($availableCount >= 10): ?>
                    <label>
                        <input type="radio" name="question_count" value="10">
                        10 題
                    </label>
                <?php endif; ?>
            </fieldset>

            <button type="submit" class="work-start-button">開始！</button>
        </form>
    <?php endif; ?>
</div>
