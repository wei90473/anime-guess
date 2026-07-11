<?php

declare(strict_types=1);

namespace App\Models;

use App\Support\Database;

class AdminUser
{
    public static function findByUsername(string $username): ?array
    {
        $statement = Database::connect()->prepare(
            'SELECT id, username, password_hash, last_login_at, created_at FROM admin_users WHERE username = :username'
        );
        $statement->execute(['username' => $username]);

        $row = $statement->fetch();

        return $row === false ? null : $row;
    }

    public static function updateLastLogin(int $id): void
    {
        $statement = Database::connect()->prepare(
            'UPDATE admin_users SET last_login_at = NOW() WHERE id = :id'
        );
        $statement->execute(['id' => $id]);
    }
}
