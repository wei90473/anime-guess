<?php

declare(strict_types=1);

namespace App\Support;

class GuestToken
{
    private const COOKIE_NAME = 'guest_token';
    private const TTL_SECONDS = 60 * 60 * 24 * 365;

    public static function get(): string
    {
        if (!empty($_COOKIE[self::COOKIE_NAME])) {
            return $_COOKIE[self::COOKIE_NAME];
        }

        $token = bin2hex(random_bytes(32));

        setcookie(self::COOKIE_NAME, $token, [
            'expires' => time() + self::TTL_SECONDS,
            'path' => '/',
            'httponly' => true,
            'samesite' => 'Lax',
        ]);

        $_COOKIE[self::COOKIE_NAME] = $token;

        return $token;
    }
}
