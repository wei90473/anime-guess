<?php

declare(strict_types=1);

/**
 * @var array $works
 */

?>
<div class="home">
    <h1>Anime Guess 動漫猜題</h1>

    <?php if (empty($works)): ?>
        <p class="home-empty">目前沒有作品，請稍後再來</p>
    <?php else: ?>
        <div class="work-grid">
            <?php foreach ($works as $work): ?>
                <div class="work-card">
                    <?php if (!empty($work['cover_image_path'])): ?>
                        <img
                            class="work-card-cover"
                            src="<?= htmlspecialchars($work['cover_image_path'], ENT_QUOTES, 'UTF-8') ?>"
                            alt="<?= htmlspecialchars($work['title'], ENT_QUOTES, 'UTF-8') ?>"
                        >
                    <?php endif; ?>
                    <h2 class="work-card-title"><?= htmlspecialchars($work['title'], ENT_QUOTES, 'UTF-8') ?></h2>
                    <p class="work-card-count"><?= (int) $work['question_count'] ?> 題可用</p>
                    <a class="work-card-button" href="/works/<?= (int) $work['id'] ?>">開始猜謎</a>
                </div>
            <?php endforeach; ?>
        </div>
    <?php endif; ?>
</div>
