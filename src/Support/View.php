<?php

declare(strict_types=1);

namespace App\Support;

class View
{
    private const TEMPLATES_PATH = __DIR__ . '/../../templates';

    public static function render(string $template, array $data = []): void
    {
        $content = self::capture(self::TEMPLATES_PATH . '/' . $template . '.php', $data);

        extract($data);

        require self::TEMPLATES_PATH . '/layout.php';
    }

    public static function partial(string $partial, array $data = []): void
    {
        echo self::capture(self::TEMPLATES_PATH . '/partials/' . $partial . '.php', $data);
    }

    private static function capture(string $path, array $data): string
    {
        extract($data);

        ob_start();
        require $path;

        return ob_get_clean();
    }
}
