<?php

declare(strict_types=1);

namespace App\Controllers;

use App\Models\QuizSession;
use App\Models\QuizSessionQuestion;
use App\Services\QuizService;
use App\Support\Csrf;
use App\Support\GuestToken;
use App\Support\View;

class QuizController
{
    public function question(string $sessionToken): void
    {
        $guestToken = GuestToken::get();

        $current = QuizService::currentQuestion($sessionToken, $guestToken);

        if ($current === null) {
            $session = QuizSession::findByTokenAndGuest($sessionToken, $guestToken);

            if ($session !== null && $session['status'] === 'completed') {
                header('Location: /quiz/' . $sessionToken . '/result');
                exit;
            }

            header('Location: /');
            exit;
        }

        View::render('quiz/question', [
            'title' => '猜謎作答',
            'session' => $current['session'],
            'question' => $current['question'],
            'choices' => QuizService::orderedChoices($current['question']),
            'currentIndex' => $current['current_index'],
            'total' => $current['total'],
        ]);
    }

    public function answer(string $sessionToken): void
    {
        Csrf::verify((string) ($_POST['csrf_token'] ?? ''));

        $guestToken = GuestToken::get();

        $current = QuizService::currentQuestion($sessionToken, $guestToken);

        if ($current === null) {
            header('Location: /quiz/' . $sessionToken);
            exit;
        }

        $questionId = (int) ($_POST['question_id'] ?? 0);

        if ($questionId !== (int) $current['question']['question_id']) {
            header('Location: /quiz/' . $sessionToken);
            exit;
        }

        $playerAnswer = mb_substr(trim((string) ($_POST['answer'] ?? '')), 0, 255);

        $result = QuizService::gradeAnswer((int) $current['session']['id'], $questionId, $playerAnswer);

        if ($result['session_completed']) {
            header('Location: /quiz/' . $sessionToken . '/result');
            exit;
        }

        header('Location: /quiz/' . $sessionToken);
        exit;
    }

    public function result(string $sessionToken): void
    {
        $guestToken = GuestToken::get();

        $session = QuizSession::findByTokenAndGuest($sessionToken, $guestToken);

        if ($session === null) {
            header('Location: /');
            exit;
        }

        $questions = QuizSessionQuestion::findBySession((int) $session['id']);

        View::render('quiz/result', [
            'title' => '作答結果',
            'session' => $session,
            'questions' => $questions,
            'summary' => QuizService::resultSummary($questions),
        ]);
    }
}
