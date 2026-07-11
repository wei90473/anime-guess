<?php

declare(strict_types=1);

namespace App\Support;

class Csrf
{
    public static function token(): string
    {
        Session::start();

        if (empty($_SESSION['csrf_token'])) {
            $_SESSION['csrf_token'] = bin2hex(random_bytes(32));
        }

        return $_SESSION['csrf_token'];
    }

    public static function verify(string $token): void
    {
        Session::start();

        $expected = $_SESSION['csrf_token'] ?? '';

        if ($expected === '' || !hash_equals($expected, $token)) {
            http_response_code(403);
            exit('Invalid CSRF token');
        }
    }

    public static function inputHtml(): string
    {
        $token = htmlspecialchars(self::token(), ENT_QUOTES, 'UTF-8');

        return '<input type="hidden" name="csrf_token" value="' . $token . '">';
    }
}
