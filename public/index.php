<?php

declare(strict_types=1);

$autoload = __DIR__ . '/../vendor/autoload.php';

if (!is_file($autoload)) {
    http_response_code(500);
    echo 'vendor/autoload.php 不存在，請先執行 composer install';
    exit(1);
}

require $autoload;

use App\Controllers\Admin\FeedbackController as AdminFeedbackController;
use App\Controllers\Admin\AuthController as AdminAuthController;
use App\Controllers\Admin\DashboardController as AdminDashboardController;
use App\Controllers\Admin\QuestionController as AdminQuestionController;
use App\Controllers\Admin\SubmissionReviewController as AdminSubmissionReviewController;
use App\Controllers\Admin\WorkController as AdminWorkController;
use App\Controllers\FeedbackController;
use App\Controllers\HomeController;
use App\Controllers\QuizController;
use App\Controllers\SubmissionController;
use App\Controllers\WorkController;
use App\Support\Env;
use App\Support\Router;

Env::load(__DIR__ . '/../config/.env');

// 訪客流程
Router::add('GET', '/', HomeController::class, 'index');
Router::add('GET', '/works/{id}', WorkController::class, 'show');
Router::add('POST', '/works/{id}/start', WorkController::class, 'start');
Router::add('GET', '/quiz/{session_token}', QuizController::class, 'question');
Router::add('POST', '/quiz/{session_token}/answer', QuizController::class, 'answer');
Router::add('GET', '/quiz/{session_token}/result', QuizController::class, 'result');
Router::add('GET', '/submit', SubmissionController::class, 'form');
Router::add('POST', '/submit', SubmissionController::class, 'submit');
Router::add('GET', '/submit/thanks', SubmissionController::class, 'thanks');
Router::add('POST', '/questions/{id}/feedback', FeedbackController::class, 'submit');

// 管理後台
Router::add('GET', '/admin/login', AdminAuthController::class, 'showLoginForm');
Router::add('POST', '/admin/login', AdminAuthController::class, 'login');
Router::add('POST', '/admin/logout', AdminAuthController::class, 'logout');
Router::add('GET', '/admin', AdminDashboardController::class, 'index');

Router::add('GET', '/admin/works', AdminWorkController::class, 'index');
Router::add('GET', '/admin/works/create', AdminWorkController::class, 'create');
Router::add('POST', '/admin/works', AdminWorkController::class, 'store');
Router::add('GET', '/admin/works/{id}/edit', AdminWorkController::class, 'edit');
Router::add('POST', '/admin/works/{id}', AdminWorkController::class, 'update');
Router::add('POST', '/admin/works/{id}/toggle', AdminWorkController::class, 'toggle');

Router::add('GET', '/admin/questions', AdminQuestionController::class, 'index');
Router::add('GET', '/admin/questions/create', AdminQuestionController::class, 'create');
Router::add('POST', '/admin/questions', AdminQuestionController::class, 'store');
Router::add('GET', '/admin/questions/{id}/edit', AdminQuestionController::class, 'edit');
Router::add('POST', '/admin/questions/{id}', AdminQuestionController::class, 'update');
Router::add('POST', '/admin/questions/{id}/toggle', AdminQuestionController::class, 'toggle');

Router::add('GET', '/admin/submissions', AdminSubmissionReviewController::class, 'index');
Router::add('GET', '/admin/submissions/{id}', AdminSubmissionReviewController::class, 'show');
Router::add('POST', '/admin/submissions/{id}/approve', AdminSubmissionReviewController::class, 'approve');
Router::add('POST', '/admin/submissions/{id}/reject', AdminSubmissionReviewController::class, 'reject');

Router::add('GET', '/admin/feedbacks', AdminFeedbackController::class, 'index');
Router::add('POST', '/admin/feedbacks/{id}/status', AdminFeedbackController::class, 'updateStatus');

Router::dispatch($_SERVER['REQUEST_METHOD'], $_SERVER['REQUEST_URI']);
