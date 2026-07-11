<?php

declare(strict_types=1);

namespace App\Support;

class Router
{
    private static array $routes = [];

    public static function add(string $method, string $pattern, string $controller, string $action): void
    {
        self::$routes[] = [
            'method' => strtoupper($method),
            'pattern' => $pattern,
            'controller' => $controller,
            'action' => $action,
        ];
    }

    public static function dispatch(string $method, string $uri): void
    {
        $method = strtoupper($method);
        $path = explode('?', $uri, 2)[0];

        foreach (self::$routes as $route) {
            if ($route['method'] !== $method) {
                continue;
            }

            $params = self::match($route['pattern'], $path);

            if ($params === null) {
                continue;
            }

            self::invoke($route['controller'], $route['action'], $params);

            return;
        }

        http_response_code(404);
        echo '404 Not Found';
    }

    private static function match(string $pattern, string $path): ?array
    {
        $patternParts = explode('/', trim($pattern, '/'));
        $pathParts = explode('/', trim($path, '/'));

        if (count($patternParts) !== count($pathParts)) {
            return null;
        }

        $params = [];

        foreach ($patternParts as $index => $part) {
            $pathPart = $pathParts[$index];

            if (preg_match('/^\{(\w+)\}$/', $part, $matches) === 1) {
                $paramName = $matches[1];
                $expectsNumeric = $paramName === 'id' || substr($paramName, -3) === '_id';

                if ($expectsNumeric && !ctype_digit($pathPart)) {
                    return null;
                }

                $params[] = ctype_digit($pathPart) ? (int) $pathPart : $pathPart;
                continue;
            }

            if ($part !== $pathPart) {
                return null;
            }
        }

        return $params;
    }

    private static function invoke(string $controllerClass, string $action, array $params): void
    {
        if (!class_exists($controllerClass)) {
            echo "尚未實作：{$controllerClass}\n";

            return;
        }

        $controller = new $controllerClass();

        if (!method_exists($controller, $action)) {
            echo "尚未實作：{$controllerClass}::{$action}\n";

            return;
        }

        $controller->$action(...$params);
    }
}
