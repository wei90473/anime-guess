<?php

declare(strict_types=1);

namespace App\Support;

class Validator
{
    public static function required(array $data, array $fields): array
    {
        $missing = [];

        foreach ($fields as $field) {
            if (!array_key_exists($field, $data) || trim((string) $data[$field]) === '') {
                $missing[] = $field;
            }
        }

        return $missing;
    }

    public static function maxLength(string $value, int $max): bool
    {
        return mb_strlen($value) <= $max;
    }

    public static function minLength(string $value, int $min): bool
    {
        return mb_strlen($value) >= $min;
    }

    public static function inArray($value, array $allowed): bool
    {
        return in_array($value, $allowed, true);
    }

    public static function noHtml(string $value): bool
    {
        return strip_tags($value) === $value;
    }
}
