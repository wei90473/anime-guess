<?php

declare(strict_types=1);

namespace App\Models;

use App\Support\Database;

class QuizSession
{
    public static function create(array $data): int
    {
        $statement = Database::connect()->prepare(
            'INSERT INTO quiz_sessions (
                session_token, guest_token, anime_work_id, question_count, status, started_at
            ) VALUES (
                :session_token, :guest_token, :anime_work_id, :question_count, :status, :started_at
            )'
        );
        $statement->execute([
            'session_token' => $data['session_token'],
            'guest_token' => $data['guest_token'],
            'anime_work_id' => $data['anime_work_id'],
            'question_count' => $data['question_count'],
            'status' => $data['status'],
            'started_at' => $data['started_at'],
        ]);

        return (int) Database::connect()->lastInsertId();
    }

    public static function findByToken(string $token): ?array
    {
        $statement = Database::connect()->prepare(
            'SELECT id, session_token, guest_token, anime_work_id, question_count, correct_count,
                status, started_at, completed_at, created_at
             FROM quiz_sessions WHERE session_token = :session_token'
        );
        $statement->execute(['session_token' => $token]);

        $row = $statement->fetch();

        return $row === false ? null : $row;
    }

    public static function findByTokenAndGuest(string $token, string $guestToken): ?array
    {
        $statement = Database::connect()->prepare(
            'SELECT id, session_token, guest_token, anime_work_id, question_count, correct_count,
                status, started_at, completed_at, created_at
             FROM quiz_sessions WHERE session_token = :session_token AND guest_token = :guest_token'
        );
        $statement->execute([
            'session_token' => $token,
            'guest_token' => $guestToken,
        ]);

        $row = $statement->fetch();

        return $row === false ? null : $row;
    }

    public static function incrementCorrectCount(int $sessionId): void
    {
        $statement = Database::connect()->prepare(
            'UPDATE quiz_sessions SET correct_count = correct_count + 1 WHERE id = :id'
        );
        $statement->execute(['id' => $sessionId]);
    }

    public static function markCompleted(int $sessionId): void
    {
        $statement = Database::connect()->prepare(
            "UPDATE quiz_sessions SET status = 'completed', completed_at = NOW() WHERE id = :id"
        );
        $statement->execute(['id' => $sessionId]);
    }
}
