<?php

declare(strict_types=1);

namespace App\Support;

class DifficultyScale
{
    public const TIER_ORDER = ['easy', 'normal', 'hard', 'extreme'];

    private const TIER_RANGES = [
        'easy' => [0, 32],
        'normal' => [33, 66],
        'hard' => [67, 90],
        'extreme' => [91, 100],
    ];

    private const TIER_MIDPOINTS = [
        'easy' => 16,
        'normal' => 50,
        'hard' => 78,
        'extreme' => 95,
    ];

    public static function tierForScore(int $score): string
    {
        foreach (self::TIER_RANGES as $tier => $range) {
            if ($score >= $range[0] && $score <= $range[1]) {
                return $tier;
            }
        }

        return 'normal';
    }

    public static function midpointForTier(string $tier): int
    {
        return self::TIER_MIDPOINTS[$tier] ?? self::TIER_MIDPOINTS['normal'];
    }

    public static function clampScore(int $score): int
    {
        return max(0, min(100, $score));
    }
}
