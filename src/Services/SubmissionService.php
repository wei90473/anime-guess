<?php

declare(strict_types=1);

namespace App\Services;

use App\Models\Question;
use App\Models\SubmissionAttempt;
use App\Support\Database;
use App\Support\DifficultyScale;
use App\Support\RuleFilter;

class SubmissionService
{
    public static function submit(array $postData, string $guestToken): array
    {
        $type = (string) ($postData['type'] ?? '');
        $difficulty = (string) ($postData['difficulty'] ?? '');

        $choices = [];

        if ($type === 'multiple_choice' && is_array($postData['choices'] ?? null)) {
            $choices = array_map(static function ($choice): string {
                return trim((string) $choice);
            }, $postData['choices']);
        }

        $acceptedAnswers = [];

        if ($type === 'fill_blank') {
            $acceptedAnswersRaw = trim((string) ($postData['accepted_answers'] ?? ''));

            if ($acceptedAnswersRaw !== '') {
                foreach (preg_split('/\r\n|\r|\n/', $acceptedAnswersRaw) as $line) {
                    $line = trim($line);

                    if ($line !== '') {
                        $acceptedAnswers[] = $line;
                    }
                }
            }
        }

        $animeWorkId = (int) ($postData['anime_work_id'] ?? 0);
        $prompt = trim((string) ($postData['prompt'] ?? ''));
        $correctAnswer = trim((string) ($postData['correct_answer'] ?? ''));

        $result = RuleFilter::check([
            'anime_work_id' => $animeWorkId,
            'type' => $type,
            'difficulty' => $difficulty,
            'prompt' => $prompt,
            'correct_answer' => $correctAnswer,
            'choices' => $choices,
            'accepted_answers' => $acceptedAnswers,
        ], $guestToken);

        if ($result['errors'] !== []) {
            return ['success' => false, 'errors' => $result['errors']];
        }

        $choicesJson = $type === 'multiple_choice'
            ? json_encode(array_values($choices), JSON_UNESCAPED_UNICODE)
            : null;

        $acceptedAnswersJson = $acceptedAnswers === []
            ? null
            : json_encode($acceptedAnswers, JSON_UNESCAPED_UNICODE);

        $nickname = trim((string) ($postData['submitted_nickname'] ?? ''));

        $pdo = Database::connect();
        $pdo->beginTransaction();

        try {
            Question::create([
                'anime_work_id' => $animeWorkId,
                'type' => $type,
                'difficulty_score' => DifficultyScale::midpointForTier($difficulty),
                'prompt' => $prompt,
                'choices_json' => $choicesJson,
                'correct_answer' => $correctAnswer,
                'accepted_answers_json' => $acceptedAnswersJson,
                'origin' => 'submission',
                'status' => 'pending',
                'submitted_by_token' => $guestToken,
                'submitted_nickname' => $nickname !== '' ? mb_substr($nickname, 0, 50, 'UTF-8') : null,
                'filter_flags' => $result['flags'] !== [] ? json_encode($result['flags'], JSON_UNESCAPED_UNICODE) : null,
            ]);

            SubmissionAttempt::record($guestToken);

            $pdo->commit();
        } catch (\Throwable $e) {
            $pdo->rollBack();

            throw $e;
        }

        return ['success' => true];
    }
}
