<?php

declare(strict_types=1);

namespace App\Controllers;

use App\Models\Question;
use App\Models\QuestionFeedback;
use App\Support\Csrf;
use App\Support\GuestToken;
use App\Support\Validator;

class FeedbackController
{
    private const VALID_TYPES = ['wrong_answer', 'unclear_prompt', 'bad_choices', 'difficulty_mismatch', 'other'];
    private const VALID_DIFFICULTIES = ['easy', 'normal', 'hard', 'extreme'];

    public function submit(int $id): void
    {
        Csrf::verify((string) ($_POST['csrf_token'] ?? ''));

        $question = Question::findByIdWithWork($id);

        if ($question === null || $question['status'] !== 'approved' || !(bool) $question['is_active']) {
            http_response_code(404);
            echo '找不到題目';

            return;
        }

        $feedbackType = trim((string) ($_POST['feedback_type'] ?? ''));

        if (!Validator::inArray($feedbackType, self::VALID_TYPES)) {
            $this->redirectToResult();

            return;
        }

        $suggestedDifficulty = null;
        if ($feedbackType === 'difficulty_mismatch') {
            $raw = trim((string) ($_POST['suggested_difficulty'] ?? ''));
            if (Validator::inArray($raw, self::VALID_DIFFICULTIES)) {
                $suggestedDifficulty = $raw;
            }
        }

        $message = trim((string) ($_POST['message'] ?? ''));
        $message = $message !== '' ? mb_substr($message, 0, 500) : null;

        QuestionFeedback::create([
            'question_id'          => (int) $question['id'],
            'anime_work_id'        => (int) $question['anime_work_id'],
            'guest_token'          => GuestToken::get(),
            'feedback_type'        => $feedbackType,
            'suggested_difficulty' => $suggestedDifficulty,
            'message'              => $message,
            'feedback_date'        => date('Y-m-d'),
        ]);

        $this->redirectToResult();
    }

    private function redirectToResult(): void
    {
        $sessionToken = (string) ($_POST['session_token'] ?? '');

        if ($sessionToken !== '' && preg_match('/^[a-zA-Z0-9]+$/', $sessionToken)) {
            header('Location: /quiz/' . $sessionToken . '/result?feedback=1');
        } else {
            header('Location: /');
        }
        exit;
    }
}
