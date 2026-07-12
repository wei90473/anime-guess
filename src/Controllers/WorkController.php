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

        $availableCount = Question::countByWork($id);

        if ($availableCount < $questionCount) {
            Session::set('work_start_error', '題目不足，無法開始');

            header('Location: /works/' . $id);
            exit;
        }

        $sessionToken = QuizService::startSession($id, $guestToken, $questionCount);

        header('Location: /quiz/' . $sessionToken);
        exit;
    }
}
