<?php

declare(strict_types=1);

require __DIR__ . '/../vendor/autoload.php';

use App\Support\Database;
use App\Support\Env;

Env::load(__DIR__ . '/../config/.env');

try {
    $pdo = Database::connect();
} catch (\Throwable $e) {
    fwrite(STDERR, "Could not connect to database: " . $e->getMessage() . "\n");
    exit(1);
}

$pdo->exec(
    "CREATE TABLE IF NOT EXISTS schema_migrations (
        id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
        migration VARCHAR(255) NOT NULL UNIQUE,
        applied_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci"
);

$appliedStatement = $pdo->query('SELECT migration FROM schema_migrations');
$applied = $appliedStatement->fetchAll(\PDO::FETCH_COLUMN);

$migrationsDir = __DIR__ . '/migrations';
$files = glob($migrationsDir . '/*.sql');
sort($files, SORT_STRING);

if ($files === false || $files === []) {
    fwrite(STDOUT, "No migration files found in {$migrationsDir}\n");
    exit(0);
}

$recordStatement = $pdo->prepare('INSERT INTO schema_migrations (migration) VALUES (:migration)');

foreach ($files as $file) {
    $name = basename($file);

    if (in_array($name, $applied, true)) {
        fwrite(STDOUT, "Skipping already applied migration: {$name}\n");
        continue;
    }

    $sql = file_get_contents($file);

    if ($sql === false) {
        fwrite(STDERR, "Could not read migration file: {$name}\n");
        exit(1);
    }

    fwrite(STDOUT, "Applying migration: {$name}\n");

    try {
        $pdo->exec($sql);
        $recordStatement->execute(['migration' => $name]);
    } catch (\Throwable $e) {
        fwrite(STDERR, "Migration failed ({$name}): " . $e->getMessage() . "\n");
        exit(1);
    }
}

fwrite(STDOUT, "Migrations complete.\n");
