<?php

declare(strict_types=1);

namespace App\Controllers\Admin;

use App\Models\Question;
use App\Services\AuthService;
use App\Support\Csrf;
use App\Support\Session;
use App\Support\View;

class SubmissionReviewController
{
    public function index(): void
    {
        AuthService::requireLogin();

        View::render('admin/submissions/index', [
            'title' => '投稿審核',
            'submissions' => Question::findPending(),
        ]);
    }

    public function show(int $id): void
    {
        AuthService::requireLogin();

        $submission = Question::findByIdWithWork($id);

        if ($submission === null) {
            http_response_code(404);
            echo '找不到投稿';

            return;
        }

        View::render('admin/submissions/show', [
            'title' => '投稿詳情',
            'submission' => $submission,
            'choices' => $this->decodeJson($submission['choices_json']),
            'acceptedAnswers' => $this->decodeJson($submission['accepted_answers_json']),
            'flags' => $this->decodeJson($submission['filter_flags']),
        ]);
    }

    public function approve(int $id): void
    {
        AuthService::requireLogin();
        Csrf::verify((string) ($_POST['csrf_token'] ?? ''));

        $submission = Question::findById($id);

        if ($submission !== null && $submission['status'] === 'pending') {
            Question::approve($id, (int) Session::get('admin_id'));
        }

        header('Location: /admin/submissions');
        exit;
    }

    public function reject(int $id): void
    {
        AuthService::requireLogin();
        Csrf::verify((string) ($_POST['csrf_token'] ?? ''));

        $submission = Question::findById($id);

        if ($submission !== null && $submission['status'] === 'pending') {
            Question::deleteById($id);
        }

        header('Location: /admin/submissions');
        exit;
    }

    private function decodeJson(?string $json): array
    {
        if ($json === null || $json === '') {
            return [];
        }

        $decoded = json_decode($json, true);

        return is_array($decoded) ? $decoded : [];
    }
}
