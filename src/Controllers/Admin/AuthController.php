<?php

declare(strict_types=1);

namespace App\Controllers\Admin;

use App\Services\AuthService;
use App\Support\Csrf;
use App\Support\View;

class AuthController
{
    public function showLoginForm(): void
    {
        if (AuthService::check()) {
            header('Location: /admin');
            exit;
        }

        View::render('admin/login', ['title' => '管理員登入']);
    }

    public function login(): void
    {
        Csrf::verify((string) ($_POST['csrf_token'] ?? ''));

        $username = (string) ($_POST['username'] ?? '');
        $password = (string) ($_POST['password'] ?? '');

        if (AuthService::login($username, $password)) {
            header('Location: /admin');
            exit;
        }

        View::render('admin/login', [
            'title' => '管理員登入',
            'error' => '帳號或密碼錯誤',
        ]);
    }

    public function logout(): void
    {
        Csrf::verify((string) ($_POST['csrf_token'] ?? ''));

        AuthService::logout();

        header('Location: /admin/login');
        exit;
    }
}
