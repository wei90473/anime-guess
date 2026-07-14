<?php

declare(strict_types=1);

namespace App\Controllers\Admin;

use App\Models\AnimeWork;
use App\Models\QuestionFeedback;
use App\Services\AuthService;
use App\Support\Csrf;
use App\Support\Validator;
use App\Support\View;

class FeedbackController
{
    public function index(): void
    {
        AuthService::requireLogin();

        $filters = [
            'work_id'       => $_GET['work_id'] ?? '',
            'status'        => $_GET['status'] ?? '',
            'feedback_type' => $_GET['feedback_type'] ?? '',
        ];

        View::render('admin/feedbacks/index', [
            'title'     => '題目回饋',
            'feedbacks' => QuestionFeedback::findAll($filters),
            'works'     => AnimeWork::findAll(true),
            'filters'   => $filters,
        ]);
    }

    public function updateStatus(int $id): void
    {
        AuthService::requireLogin();
        Csrf::verify((string) ($_POST['csrf_token'] ?? ''));

        $status = trim((string) ($_POST['status'] ?? ''));

        if (Validator::inArray($status, ['open', 'resolved', 'ignored'])) {
            QuestionFeedback::updateStatus($id, $status);
        }

        $query = http_build_query(array_filter([
            'work_id'       => $_POST['work_id'] ?? '',
            'status'        => $_POST['filter_status'] ?? '',
            'feedback_type' => $_POST['feedback_type'] ?? '',
        ]));

        header('Location: /admin/feedbacks' . ($query !== '' ? '?' . $query : ''));
        exit;
    }
}
