<?php

declare(strict_types=1);

/**
 * @var string|null $error
 */

use App\Support\Csrf;

?>
<div class="admin-login">
    <h1>管理員登入</h1>
    <?php if (!empty($error)): ?>
        <p class="admin-error"><?= htmlspecialchars($error, ENT_QUOTES, 'UTF-8') ?></p>
    <?php endif; ?>
    <form method="post" action="/admin/login">
        <?= Csrf::inputHtml() ?>
        <label for="username">帳號</label>
        <input type="text" id="username" name="username" required autofocus>

        <label for="password">密碼</label>
        <input type="password" id="password" name="password" required>

        <button type="submit">登入</button>
    </form>
</div>
