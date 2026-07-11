<?php

declare(strict_types=1);

namespace App\Support;

class Session
{
    private static bool $started = false;

    public static function start(): void
    {
        if (self::$started || session_status() === PHP_SESSION_ACTIVE) {
            self::$started = true;

            return;
        }

        session_set_cookie_params([
            'httponly' => true,
            'samesite' => 'Lax',
        ]);

        session_name((string) Env::get('SESSION_NAME', 'app_session'));
        session_start();

        self::$started = true;
    }

    /**
     * @param mixed $value
     */
    public static function set(string $key, $value): void
    {
        self::start();

        $_SESSION[$key] = $value;
    }

    /**
     * @param mixed $default
     * @return mixed
     */
    public static function get(string $key, $default = null)
    {
        self::start();

        return $_SESSION[$key] ?? $default;
    }

    public static function destroy(): void
    {
        self::start();

        $_SESSION = [];

        if (ini_get('session.use_cookies')) {
            $params = session_get_cookie_params();
            setcookie(
                session_name(),
                '',
                time() - 42000,
                $params['path'],
                $params['domain'],
                $params['secure'],
                $params['httponly']
            );
        }

        session_destroy();
        self::$started = false;
    }
}
