<?php

declare(strict_types=1);

namespace App\Services;

use App\Models\Question;
use App\Models\QuizSession;
use App\Models\QuizSessionQuestion;
use App\Support\Database;

class QuizService
{
    public static function startSession(int $workId, string $guestToken, int $questionCount): string
    {
        $questions = Question::findByWork($workId);

        $mcCount = (int) ceil($questionCount / 2);
        $fillCount = $questionCount - $mcCount;

        $mcPool = [];
        $fillPool = [];

        foreach ($questions as $question) {
            if ($question['type'] === 'multiple_choice') {
                $mcPool[] = $question;
            } else {
                $fillPool[] = $question;
            }
        }

        $selected = array_merge(
            self::pickRandom($mcPool, $mcCount),
            self::pickRandom($fillPool, $fillCount)
        );

        if (count($selected) < $questionCount) {
            $selectedIds = array_column($selected, 'id');
            $remainingPool = array_values(array_filter(
                $questions,
                static function (array $question) use ($selectedIds): bool {
                    return !in_array($question['id'], $selectedIds, true);
                }
            ));

            $selected = array_merge(
                $selected,
                self::pickRandom($remainingPool, $questionCount - count($selected))
            );
        }

        shuffle($selected);

        $sessionToken = bin2hex(random_bytes(21));

        $pdo = Database::connect();
        $pdo->beginTransaction();

        try {
            $sessionId = QuizSession::create([
                'session_token' => $sessionToken,
                'guest_token' => $guestToken,
                'anime_work_id' => $workId,
                'question_count' => $questionCount,
                'status' => 'in_progress',
                'started_at' => date('Y-m-d H:i:s'),
            ]);

            QuizSessionQuestion::createBatch($sessionId, array_column($selected, 'id'));

            $pdo->commit();
        } catch (\Throwable $e) {
            $pdo->rollBack();

            throw $e;
        }

        return $sessionToken;
    }

    public static function currentQuestion(string $sessionToken, string $guestToken): ?array
    {
        $session = QuizSession::findByTokenAndGuest($sessionToken, $guestToken);

        if ($session === null) {
            return null;
        }

        $questions = QuizSessionQuestion::findBySession((int) $session['id']);

        $currentQuestion = null;
        $currentIndex = null;

        foreach ($questions as $index => $question) {
            if ($question['answered_at'] === null) {
                $currentQuestion = $question;
                $currentIndex = $index + 1;
                break;
            }
        }

        if ($currentQuestion === null) {
            return null;
        }

        return [
            'session' => $session,
            'question' => $currentQuestion,
            'current_index' => $currentIndex,
            'total' => count($questions),
        ];
    }

    public static function gradeAnswer(int $sessionId, int $questionId, string $playerAnswer): array
    {
        $question = Question::findById($questionId);

        $isCorrect = self::checkAnswer($question, $playerAnswer);

        $updated = QuizSessionQuestion::recordAnswer($sessionId, $questionId, $playerAnswer, $isCorrect);

        if ($updated && $isCorrect) {
            QuizSession::incrementCorrectCount($sessionId);
        }

        $remaining = QuizSessionQuestion::countUnanswered($sessionId);
        $sessionCompleted = $remaining === 0;

        if ($updated && $sessionCompleted) {
            QuizSession::markCompleted($sessionId);
        }

        return [
            'is_correct' => $isCorrect,
            'correct_answer' => (string) $question['correct_answer'],
            'session_completed' => $sessionCompleted,
        ];
    }

    private static function checkAnswer(array $question, string $playerAnswer): bool
    {
        if ($question['type'] === 'multiple_choice') {
            return trim($playerAnswer) === trim((string) $question['correct_answer']);
        }

        return self::checkFillBlank($question, $playerAnswer);
    }

    private static function checkFillBlank(array $question, string $playerAnswer): bool
    {
        $normalizedPlayer = self::normalizeAnswer($playerAnswer);

        $candidates = [$question['correct_answer']];

        if (!empty($question['accepted_answers_json'])) {
            $accepted = json_decode((string) $question['accepted_answers_json'], true);

            if (is_array($accepted)) {
                $candidates = array_merge($candidates, $accepted);
            }
        }

        foreach ($candidates as $candidate) {
            if ($normalizedPlayer === self::normalizeAnswer((string) $candidate)) {
                return true;
            }
        }

        return false;
    }

    private static function normalizeAnswer(string $answer): string
    {
        $answer = trim($answer);
        $answer = mb_strtolower($answer, 'UTF-8');
        $answer = str_replace("\u{3000}", ' ', $answer);
        $answer = preg_replace('/\s+/u', ' ', $answer);

        return trim($answer);
    }

    private static function pickRandom(array $pool, int $count): array
    {
        if ($count <= 0 || $pool === []) {
            return [];
        }

        if ($count >= count($pool)) {
            return $pool;
        }

        $keys = array_rand($pool, $count);
        $keys = is_array($keys) ? $keys : [$keys];

        $picked = [];

        foreach ($keys as $key) {
            $picked[] = $pool[$key];
        }

        return $picked;
    }
}
