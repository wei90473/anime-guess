<?php

declare(strict_types=1);

/**
 * @var array $works
 */

$avatarPalette = ['#2b6cb0', '#276749', '#9b2c2c', '#6b46c1', '#b7791f', '#2c7a7b', '#c53030', '#4a5568'];

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
                            class="work-card-avatar"
                            src="<?= htmlspecialchars($work['cover_image_path'], ENT_QUOTES, 'UTF-8') ?>"
                            alt="<?= htmlspecialchars($work['title'], ENT_QUOTES, 'UTF-8') ?>"
                        >
                    <?php else: ?>
                        <?php $avatarColor = $avatarPalette[abs(crc32((string) $work['title'])) % count($avatarPalette)]; ?>
                        <div class="work-card-avatar work-card-avatar-fallback" style="background-color: <?= htmlspecialchars($avatarColor, ENT_QUOTES, 'UTF-8') ?>;">
                            <?= htmlspecialchars(mb_substr((string) $work['title'], 0, 2, 'UTF-8'), ENT_QUOTES, 'UTF-8') ?>
                        </div>
                    <?php endif; ?>
                    <h2 class="work-card-title"><?= htmlspecialchars($work['title'], ENT_QUOTES, 'UTF-8') ?></h2>
                    <p class="work-card-count"><?= (int) $work['question_count'] ?> 題可用</p>
                    <a class="work-card-button" href="/works/<?= (int) $work['id'] ?>">開始猜謎</a>
                </div>
            <?php endforeach; ?>
        </div>
    <?php endif; ?>
</div>
