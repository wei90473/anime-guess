<?php

declare(strict_types=1);

namespace App\Models;

use App\Support\Database;

class SubmissionAttempt
{
    public static function record(string $guestToken): void
    {
        $statement = Database::connect()->prepare(
            'INSERT INTO submission_attempts (guest_token) VALUES (:guest_token)'
        );
        $statement->execute(['guest_token' => $guestToken]);
    }

    public static function countRecent(string $guestToken, int $sinceHoursAgo): int
    {
        $statement = Database::connect()->prepare(
            'SELECT COUNT(*) FROM submission_attempts WHERE guest_token = :guest_token AND created_at >= :since'
        );
        $statement->execute([
            'guest_token' => $guestToken,
            'since' => date('Y-m-d H:i:s', time() - $sinceHoursAgo * 3600),
        ]);

        return (int) $statement->fetchColumn();
    }
}
