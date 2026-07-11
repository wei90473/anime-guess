<?php

declare(strict_types=1);

namespace App\Controllers\Admin;

use App\Services\AuthService;
use App\Support\Database;
use App\Support\View;

class DashboardController
{
    public function index(): void
    {
        AuthService::requireLogin();

        $pdo = Database::connect();

        $pendingSubmissions = (int) $pdo->query(
            "SELECT COUNT(*) FROM questions WHERE status = 'pending'"
        )->fetchColumn();

        $totalWorks = (int) $pdo->query(
            'SELECT COUNT(*) FROM anime_works WHERE is_active = 1'
        )->fetchColumn();

        $approvedQuestions = (int) $pdo->query(
            "SELECT COUNT(*) FROM questions WHERE status = 'approved' AND is_active = 1"
        )->fetchColumn();

        View::render('admin/dashboard', [
            'title' => '管理後台',
            'pendingSubmissions' => $pendingSubmissions,
            'totalWorks' => $totalWorks,
            'approvedQuestions' => $approvedQuestions,
        ]);
    }
}
