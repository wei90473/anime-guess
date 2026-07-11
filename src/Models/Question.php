<?php

declare(strict_types=1);

namespace App\Models;

use App\Support\Database;

class Question
{
    private const COLUMNS = 'id, anime_work_id, type, prompt, choices_json, correct_answer,
        accepted_answers_json, origin, status, submitted_by_token, submitted_nickname,
        filter_flags, reviewed_by, reviewed_at, rejection_reason, is_active, created_at, updated_at';

    public static function findByWork(int $workId, bool $includeInactive = false): array
    {
        $sql = 'SELECT ' . self::COLUMNS . ' FROM questions WHERE anime_work_id = :work_id';

        if (!$includeInactive) {
            $sql .= " AND status = 'approved' AND is_active = 1";
        }

        $sql .= ' ORDER BY created_at DESC';

        $statement = Database::connect()->prepare($sql);
        $statement->execute(['work_id' => $workId]);

        return $statement->fetchAll();
    }

    public static function findAll(array $filters = []): array
    {
        $sql = 'SELECT q.id, q.anime_work_id, q.type, q.prompt, q.choices_json, q.correct_answer,
                q.accepted_answers_json, q.origin, q.status, q.submitted_by_token, q.submitted_nickname,
                q.filter_flags, q.reviewed_by, q.reviewed_at, q.rejection_reason, q.is_active,
                q.created_at, q.updated_at, w.title AS work_title
            FROM questions q
            JOIN anime_works w ON w.id = q.anime_work_id';

        $conditions = [];
        $params = [];

        if (!empty($filters['work_id'])) {
            $conditions[] = 'q.anime_work_id = :work_id';
            $params['work_id'] = (int) $filters['work_id'];
        }

        if (!empty($filters['status'])) {
            $conditions[] = 'q.status = :status';
            $params['status'] = (string) $filters['status'];
        }

        if (!empty($filters['origin'])) {
            $conditions[] = 'q.origin = :origin';
            $params['origin'] = (string) $filters['origin'];
        }

        if ($conditions !== []) {
            $sql .= ' WHERE ' . implode(' AND ', $conditions);
        }

        $sql .= ' ORDER BY q.created_at DESC';

        $statement = Database::connect()->prepare($sql);
        $statement->execute($params);

        return $statement->fetchAll();
    }

    public static function findById(int $id): ?array
    {
        $statement = Database::connect()->prepare(
            'SELECT ' . self::COLUMNS . ' FROM questions WHERE id = :id'
        );
        $statement->execute(['id' => $id]);

        $row = $statement->fetch();

        return $row === false ? null : $row;
    }

    public static function create(array $data): int
    {
        $statement = Database::connect()->prepare(
            'INSERT INTO questions (
                anime_work_id, type, prompt, choices_json, correct_answer,
                accepted_answers_json, origin, status
            ) VALUES (
                :anime_work_id, :type, :prompt, :choices_json, :correct_answer,
                :accepted_answers_json, :origin, :status
            )'
        );
        $statement->execute([
            'anime_work_id' => $data['anime_work_id'],
            'type' => $data['type'],
            'prompt' => $data['prompt'],
            'choices_json' => $data['choices_json'],
            'correct_answer' => $data['correct_answer'],
            'accepted_answers_json' => $data['accepted_answers_json'],
            'origin' => $data['origin'],
            'status' => $data['status'],
        ]);

        return (int) Database::connect()->lastInsertId();
    }

    public static function update(int $id, array $data): void
    {
        $statement = Database::connect()->prepare(
            'UPDATE questions
             SET anime_work_id = :anime_work_id,
                 type = :type,
                 prompt = :prompt,
                 choices_json = :choices_json,
                 correct_answer = :correct_answer,
                 accepted_answers_json = :accepted_answers_json
             WHERE id = :id'
        );
        $statement->execute([
            'anime_work_id' => $data['anime_work_id'],
            'type' => $data['type'],
            'prompt' => $data['prompt'],
            'choices_json' => $data['choices_json'],
            'correct_answer' => $data['correct_answer'],
            'accepted_answers_json' => $data['accepted_answers_json'],
            'id' => $id,
        ]);
    }

    public static function toggle(int $id): void
    {
        $statement = Database::connect()->prepare(
            'UPDATE questions SET is_active = 1 - is_active WHERE id = :id'
        );
        $statement->execute(['id' => $id]);
    }

    public static function countPending(): int
    {
        $statement = Database::connect()->query(
            "SELECT COUNT(*) FROM questions WHERE status = 'pending'"
        );

        return (int) $statement->fetchColumn();
    }
}
