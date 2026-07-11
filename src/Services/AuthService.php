<?php

declare(strict_types=1);

namespace App\Services;

use App\Models\AdminUser;
use App\Support\Session;

class AuthService
{
    public static function login(string $username, string $password): bool
    {
        $admin = AdminUser::findByUsername($username);

        if ($admin === null || !password_verify($password, $admin['password_hash'])) {
            return false;
        }

        Session::set('admin_id', (int) $admin['id']);
        Session::set('admin_username', $admin['username']);
        AdminUser::updateLastLogin((int) $admin['id']);

        return true;
    }

    public static function logout(): void
    {
        Session::destroy();
    }

    public static function check(): bool
    {
        return Session::get('admin_id') !== null;
    }

    public static function requireLogin(): void
    {
        if (!self::check()) {
            header('Location: /admin/login');
            exit;
        }
    }
}
