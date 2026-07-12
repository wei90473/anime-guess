<?php

declare(strict_types=1);

namespace App\Controllers;

use App\Models\AnimeWork;
use App\Services\SubmissionService;
use App\Support\Csrf;
use App\Support\GuestToken;
use App\Support\Session;
use App\Support\View;

class SubmissionController
{
    public function form(): void
    {
        GuestToken::get();

        $errors = Session::get('submission_errors', []);
        $old = Session::get('submission_old', []);
        Session::set('submission_errors', null);
        Session::set('submission_old', null);

        View::render('submission/form', [
            'title' => '投稿題目',
            'works' => AnimeWork::findAll(),
            'errors' => $errors,
            'old' => $old,
        ]);
    }

    public function submit(): void
    {
        Csrf::verify((string) ($_POST['csrf_token'] ?? ''));

        $guestToken = GuestToken::get();

        $result = SubmissionService::submit($_POST, $guestToken);

        if (!$result['success']) {
            Session::set('submission_errors', $result['errors']);
            Session::set('submission_old', $_POST);

            header('Location: /submit');
            exit;
        }

        header('Location: /submit/thanks');
        exit;
    }

    public function thanks(): void
    {
        View::render('submission/thanks', [
            'title' => '投稿成功',
        ]);
    }
}
