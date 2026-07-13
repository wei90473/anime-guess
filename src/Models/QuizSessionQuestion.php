<?php

declare(strict_types=1);

namespace App\Models;

use App\Support\Database;

class QuizSessionQuestion
{
    public static function createBatch(int $sessionId, array $questionIds): void
    {
        $statement = Database::connect()->prepare(
            'INSERT INTO quiz_session_questions (quiz_session_id, question_id, order_index)
             VALUES (:quiz_session_id, :question_id, :order_index)'
        );

        foreach (array_values($questionIds) as $orderIndex => $questionId) {
            $statement->execute([
                'quiz_session_id' => $sessionId,
                'question_id' => $questionId,
                'order_index' => $orderIndex,
            ]);
        }
    }

    public static function findBySession(int $sessionId): array
    {
        $statement = Database::connect()->prepare(
            'SELECT sq.id, sq.quiz_session_id, sq.question_id, sq.order_index,
                sq.player_answer, sq.is_correct, sq.answered_at,
                q.type, q.difficulty, q.prompt, q.choices_json, q.correct_answer, q.accepted_answers_json
             FROM quiz_session_questions sq
             JOIN questions q ON q.id = sq.question_id
             WHERE sq.quiz_session_id = :quiz_session_id
             ORDER BY sq.order_index ASC'
        );
        $statement->execute(['quiz_session_id' => $sessionId]);

        return $statement->fetchAll();
    }

    public static function recordAnswer(int $sessionId, int $questionId, string $playerAnswer, bool $isCorrect): bool
    {
        $statement = Database::connect()->prepare(
            'UPDATE quiz_session_questions
             SET player_answer = :player_answer, is_correct = :is_correct, answered_at = NOW()
             WHERE quiz_session_id = :quiz_session_id AND question_id = :question_id AND answered_at IS NULL'
        );
        $statement->execute([
            'player_answer' => $playerAnswer,
            'is_correct' => $isCorrect ? 1 : 0,
            'quiz_session_id' => $sessionId,
            'question_id' => $questionId,
        ]);

        return $statement->rowCount() > 0;
    }

    public static function countUnanswered(int $sessionId): int
    {
        $statement = Database::connect()->prepare(
            'SELECT COUNT(*) FROM quiz_session_questions
             WHERE quiz_session_id = :quiz_session_id AND answered_at IS NULL'
        );
        $statement->execute(['quiz_session_id' => $sessionId]);

        return (int) $statement->fetchColumn();
    }
}
