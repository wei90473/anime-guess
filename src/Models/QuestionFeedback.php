<?php

declare(strict_types=1);

namespace App\Models;

use App\Support\Database;

class QuestionFeedback
{
    public static function create(array $data): bool
    {
        $statement = Database::connect()->prepare(
            'INSERT INTO question_feedbacks
                (question_id, anime_work_id, guest_token, feedback_type, suggested_difficulty, message, feedback_date)
             VALUES
                (:question_id, :anime_work_id, :guest_token, :feedback_type, :suggested_difficulty, :message, :feedback_date)'
        );

        try {
            $statement->execute([
                'question_id'          => $data['question_id'],
                'anime_work_id'        => $data['anime_work_id'],
                'guest_token'          => $data['guest_token'],
                'feedback_type'        => $data['feedback_type'],
                'suggested_difficulty' => $data['suggested_difficulty'],
                'message'              => $data['message'],
                'feedback_date'        => $data['feedback_date'],
            ]);

            return true;
        } catch (\PDOException $e) {
            $sqlState   = $e->errorInfo[0] ?? null;
            $driverCode = $e->errorInfo[1] ?? null;

            if ($sqlState === '23000' && $driverCode === 1062) {
                return true;
            }

            throw $e;
        }
    }

    public static function findAll(array $filters = []): array
    {
        $sql = 'SELECT qf.id, qf.question_id, qf.anime_work_id, qf.feedback_type,
                       qf.suggested_difficulty, qf.message, qf.status, qf.feedback_date, qf.created_at,
                       q.prompt, q.difficulty, q.difficulty_score,
                       aw.title AS work_title
                FROM question_feedbacks qf
                JOIN questions q ON q.id = qf.question_id
                JOIN anime_works aw ON aw.id = qf.anime_work_id';

        $conditions = [];
        $params = [];

        if (!empty($filters['work_id'])) {
            $conditions[] = 'qf.anime_work_id = :work_id';
            $params['work_id'] = (int) $filters['work_id'];
        }

        if (!empty($filters['status'])) {
            $conditions[] = 'qf.status = :status';
            $params['status'] = (string) $filters['status'];
        }

        if (!empty($filters['feedback_type'])) {
            $conditions[] = 'qf.feedback_type = :feedback_type';
            $params['feedback_type'] = (string) $filters['feedback_type'];
        }

        if ($conditions !== []) {
            $sql .= ' WHERE ' . implode(' AND ', $conditions);
        }

        $sql .= ' ORDER BY qf.created_at DESC';

        $statement = Database::connect()->prepare($sql);
        $statement->execute($params);

        return $statement->fetchAll();
    }

    public static function updateStatus(int $id, string $status): bool
    {
        $statement = Database::connect()->prepare(
            'UPDATE question_feedbacks SET status = :status WHERE id = :id'
        );
        $statement->execute(['status' => $status, 'id' => $id]);

        return $statement->rowCount() > 0;
    }
}
