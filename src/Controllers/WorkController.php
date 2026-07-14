<?php

declare(strict_types=1);

namespace App\Controllers;

use App\Models\AnimeWork;
use App\Models\Question;
use App\Services\QuizService;
use App\Support\Csrf;
use App\Support\GuestToken;
use App\Support\Session;
use App\Support\View;

class WorkController
{
    private const ALLOWED_QUESTION_COUNTS = [5, 10];
    private const ALLOWED_QUESTION_TYPES = ['mixed', 'multiple_choice', 'fill_blank'];
    private const ALLOWED_DIFFICULTIES = ['any', 'easy', 'normal', 'hard', 'extreme'];

    public function show(int $id): void
    {
        GuestToken::get();

        $work = AnimeWork::findById($id);

        if ($work === null || (int) $work['is_active'] !== 1) {
            http_response_code(404);
            echo '找不到作品';

            return;
        }

        $availableCount = Question::countByWork($id);

        $error = Session::get('work_start_error');
        Session::set('work_start_error', null);

        View::render('work/show', [
            'title' => $work['title'],
            'work' => $work,
            'availableCount' => $availableCount,
            'error' => $error,
        ]);
    }

    public function start(int $id): void
    {
        Csrf::verify((string) ($_POST['csrf_token'] ?? ''));

        $guestToken = GuestToken::get();

        $work = AnimeWork::findById($id);

        if ($work === null || (int) $work['is_active'] !== 1) {
            http_response_code(404);
            echo '找不到作品';

            return;
        }

        $questionCount = (int) ($_POST['question_count'] ?? 5);

        if (!in_array($questionCount, self::ALLOWED_QUESTION_COUNTS, true)) {
            $questionCount = 5;
        }

        $questionType = (string) ($_POST['question_type'] ?? 'mixed');

        if (!in_array($questionType, self::ALLOWED_QUESTION_TYPES, true)) {
            $questionType = 'mixed';
        }

        $difficulty = (string) ($_POST['difficulty'] ?? 'any');

        if (!in_array($difficulty, self::ALLOWED_DIFFICULTIES, true)) {
            $difficulty = 'any';
        }

        $availableCount = Question::countByWorkAndType($id, $questionType);

        if ($availableCount < $questionCount) {
            Session::set('work_start_error', '題目不足，無法開始');

            header('Location: /works/' . $id);
            exit;
        }

        $sessionToken = QuizService::startSession($id, $guestToken, $questionCount, $questionType, $difficulty);

        header('Location: /quiz/' . $sessionToken);
        exit;
    }
}
