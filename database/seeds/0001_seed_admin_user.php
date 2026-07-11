<?php

declare(strict_types=1);

require __DIR__ . '/../../vendor/autoload.php';

use App\Support\Database;
use App\Support\Env;

Env::load(__DIR__ . '/../../config/.env');

$username = $argv[1] ?? null;
$password = $argv[2] ?? null;

if ($username === null || $password === null) {
    fwrite(STDERR, "Usage: php 0001_seed_admin_user.php <username> <password>\n");
    exit(1);
}

try {
    $pdo = Database::connect();
} catch (\Throwable $e) {
    fwrite(STDERR, "Could not connect to database: " . $e->getMessage() . "\n");
    exit(1);
}

$checkStatement = $pdo->prepare('SELECT id FROM admin_users WHERE username = :username');
$checkStatement->execute(['username' => $username]);

if ($checkStatement->fetch() !== false) {
    fwrite(STDOUT, "Admin user '{$username}' already exists, skipping.\n");
    exit(0);
}

$passwordHash = password_hash($password, PASSWORD_DEFAULT);

$insertStatement = $pdo->prepare(
    'INSERT INTO admin_users (username, password_hash) VALUES (:username, :password_hash)'
);
$insertStatement->execute([
    'username' => $username,
    'password_hash' => $passwordHash,
]);

fwrite(STDOUT, "Admin user '{$username}' created.\n");
