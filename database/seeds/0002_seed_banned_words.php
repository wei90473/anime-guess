<?php

declare(strict_types=1);

require __DIR__ . '/../../vendor/autoload.php';

use App\Support\Database;
use App\Support\Env;

Env::load(__DIR__ . '/../../config/.env');

$bannedWords = [
    '垃圾',
    '廢物',
    '混蛋',
    '白痴',
    '智障',
    '色情',
    '賤人',
    '婊子',
    '幹你娘',
    '幹',
    '操你媽',
    'fuck',
    'shit',
    'bitch',
    'ass',
    'asshole',
    'bastard',
    'dick',
    'cunt',
    'whore',
];

try {
    $pdo = Database::connect();
} catch (\Throwable $e) {
    fwrite(STDERR, "Could not connect to database: " . $e->getMessage() . "\n");
    exit(1);
}

$statement = $pdo->prepare('INSERT IGNORE INTO banned_words (word) VALUES (:word)');

$insertedCount = 0;

foreach ($bannedWords as $word) {
    $statement->execute(['word' => $word]);
    $insertedCount += $statement->rowCount();
}

fwrite(STDOUT, "Inserted {$insertedCount} new banned word(s) (out of " . count($bannedWords) . " total).\n");
