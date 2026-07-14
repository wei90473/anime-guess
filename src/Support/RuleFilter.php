<?php

declare(strict_types=1);

namespace App\Support;

use App\Models\SubmissionAttempt;

class RuleFilter
{
    private const RATE_LIMIT_COUNT = 5;
    private const RATE_LIMIT_HOURS = 24;

    public static function check(array $data, string $guestToken): array
    {
        $errors = [];
        $flags = [];

        $animeWorkId = (int) ($data['anime_work_id'] ?? 0);
        $type = (string) ($data['type'] ?? '');
        $difficulty = (string) ($data['difficulty'] ?? '');
        $prompt = trim((string) ($data['prompt'] ?? ''));
        $correctAnswer = trim((string) ($data['correct_answer'] ?? ''));

        $choices = array_map(static function ($choice): string {
            return trim((string) $choice);
        }, is_array($data['choices'] ?? null) ? $data['choices'] : []);

        $acceptedAnswers = array_values(array_filter(array_map(static function ($answer): string {
            return trim((string) $answer);
        }, is_array($data['accepted_answers'] ?? null) ? $data['accepted_answers'] : []), static function (string $answer): bool {
            return $answer !== '';
        }));

        $nonEmptyChoices = array_values(array_filter($choices, static function (string $choice): bool {
            return $choice !== '';
        }));

        // 1. 必填欄位缺漏
        $missingRequired = $animeWorkId <= 0
            || $type === ''
            || $difficulty === ''
            || $prompt === ''
            || $correctAnswer === ''
            || ($type === 'multiple_choice' && (count($choices) !== 4 || count($nonEmptyChoices) !== 4));

        if ($missingRequired) {
            $errors[] = '請填寫所有必填欄位';
        }

        // 1b. anime_work_id 須存在於 anime_works 且為啟用狀態
        if ($animeWorkId > 0 && !self::animeWorkExists($animeWorkId)) {
            $errors[] = '所選動漫作品不存在';
        }

        // 1c. type 白名單
        if ($type !== '' && !in_array($type, ['multiple_choice', 'fill_blank'], true)) {
            $errors[] = '題目類型不正確';
        }

        // 1d. difficulty 白名單
        if ($difficulty !== '' && !in_array($difficulty, DifficultyScale::TIER_ORDER, true)) {
            $errors[] = '請選擇有效的難易度';
        }

        // 2. prompt 長度 5~200
        if ($prompt !== '' && (!Validator::minLength($prompt, 5) || !Validator::maxLength($prompt, 200))) {
            $errors[] = '題目內容長度需為 5~200 字';
        }

        // 3. correct_answer 長度 1~100
        if ($correctAnswer !== '' && (!Validator::minLength($correctAnswer, 1) || !Validator::maxLength($correctAnswer, 100))) {
            $errors[] = '正確答案長度需為 1~100 字';
        }

        // 4. 選擇題：4 個非空選項，正確答案須為其中之一
        if ($type === 'multiple_choice' && count($choices) === 4 && count($nonEmptyChoices) === 4) {
            if ($correctAnswer !== '' && !in_array($correctAnswer, $choices, true)) {
                $errors[] = '正確答案必須完全等於其中一個選項';
            }
        }

        $textValues = array_merge([$prompt, $correctAnswer], $choices, $acceptedAnswers);

        // 5. 違禁字（大小寫不分，子字串比對）
        if (self::containsBannedWord($textValues)) {
            $errors[] = '內容含有不允許的字詞';
        }

        // 6. HTML tag
        foreach ($textValues as $value) {
            if ($value !== '' && !Validator::noHtml($value)) {
                $errors[] = '內容不可包含 HTML 標籤';
                break;
            }
        }

        // 7. 頻率限制：24 小時內 >= 5 筆
        if (self::countRecentSubmissions($guestToken) >= self::RATE_LIMIT_COUNT) {
            $errors[] = '投稿過於頻繁，請 24 小時後再試';
        }

        // 軟性警示 1：possible_duplicate
        if ($animeWorkId > 0 && $prompt !== '' && self::hasDuplicatePrompt($animeWorkId, $prompt)) {
            $flags[] = 'possible_duplicate';
        }

        // 軟性警示 2：no_alt_answers
        if ($type === 'fill_blank' && $acceptedAnswers === []) {
            $flags[] = 'no_alt_answers';
        }

        // 軟性警示 3：very_short_answer
        if ($correctAnswer !== '' && mb_strlen(self::normalize($correctAnswer), 'UTF-8') < 2) {
            $flags[] = 'very_short_answer';
        }

        return ['errors' => $errors, 'flags' => $flags];
    }

    private static function animeWorkExists(int $animeWorkId): bool
    {
        $statement = Database::connect()->prepare(
            'SELECT id FROM anime_works WHERE id = :id AND is_active = 1'
        );
        $statement->execute(['id' => $animeWorkId]);

        return $statement->fetch() !== false;
    }

    private static function containsBannedWord(array $values): bool
    {
        $bannedWords = self::fetchBannedWords();

        if ($bannedWords === []) {
            return false;
        }

        foreach ($values as $value) {
            if ($value === '') {
                continue;
            }

            $normalized = mb_strtolower($value, 'UTF-8');

            foreach ($bannedWords as $word) {
                if ($word !== '' && mb_strpos($normalized, mb_strtolower($word, 'UTF-8')) !== false) {
                    return true;
                }
            }
        }

        return false;
    }

    private static function fetchBannedWords(): array
    {
        $statement = Database::connect()->query('SELECT word FROM banned_words');

        return array_column($statement->fetchAll(), 'word');
    }

    private static function countRecentSubmissions(string $guestToken): int
    {
        return SubmissionAttempt::countRecent($guestToken, self::RATE_LIMIT_HOURS);
    }

    private static function hasDuplicatePrompt(int $animeWorkId, string $prompt): bool
    {
        $normalized = self::normalize($prompt);

        $statement = Database::connect()->prepare(
            'SELECT prompt FROM questions WHERE anime_work_id = :work_id'
        );
        $statement->execute(['work_id' => $animeWorkId]);

        foreach ($statement->fetchAll() as $row) {
            if (self::normalize((string) $row['prompt']) === $normalized) {
                return true;
            }
        }

        return false;
    }

    private static function normalize(string $value): string
    {
        $normalized = preg_replace('/\s+/u', '', trim($value));

        return mb_strtolower((string) $normalized, 'UTF-8');
    }
}
