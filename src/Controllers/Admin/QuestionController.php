<?php

declare(strict_types=1);

namespace App\Controllers\Admin;

use App\Models\AnimeWork;
use App\Models\Question;
use App\Services\AuthService;
use App\Support\Csrf;
use App\Support\DifficultyScale;
use App\Support\Validator;
use App\Support\View;

class QuestionController
{
    private const TYPES = ['multiple_choice', 'fill_blank'];
    private const DIFFICULTIES = DifficultyScale::TIER_ORDER;

    public function index(): void
    {
        AuthService::requireLogin();

        $filters = [
            'work_id' => trim((string) ($_GET['work_id'] ?? '')),
            'status' => trim((string) ($_GET['status'] ?? '')),
        ];

        View::render('admin/questions/index', [
            'title' => '題目管理',
            'questions' => Question::findAll($filters),
            'works' => AnimeWork::findAll(true),
            'filters' => $filters,
        ]);
    }

    public function create(): void
    {
        AuthService::requireLogin();

        View::render('admin/questions/form', [
            'title' => '新增題目',
            'question' => null,
            'works' => AnimeWork::findAll(true),
            'errors' => [],
            'old' => [],
        ]);
    }

    public function store(): void
    {
        AuthService::requireLogin();
        Csrf::verify((string) ($_POST['csrf_token'] ?? ''));

        [$errors, $data, $old] = $this->validateInput($_POST);

        if (!empty($errors)) {
            View::render('admin/questions/form', [
                'title' => '新增題目',
                'question' => null,
                'works' => AnimeWork::findAll(true),
                'errors' => $errors,
                'old' => $old,
            ]);

            return;
        }

        Question::create($data);

        header('Location: /admin/questions');
        exit;
    }

    public function edit(int $id): void
    {
        AuthService::requireLogin();

        $question = Question::findById($id);

        if ($question === null) {
            http_response_code(404);
            echo '找不到題目';

            return;
        }

        View::render('admin/questions/form', [
            'title' => '編輯題目',
            'question' => $question,
            'works' => AnimeWork::findAll(true),
            'errors' => [],
            'old' => [],
        ]);
    }

    public function update(int $id): void
    {
        AuthService::requireLogin();
        Csrf::verify((string) ($_POST['csrf_token'] ?? ''));

        $question = Question::findById($id);

        if ($question === null) {
            http_response_code(404);
            echo '找不到題目';

            return;
        }

        [$errors, $data, $old] = $this->validateInput($_POST, $question);

        if (!empty($errors)) {
            View::render('admin/questions/form', [
                'title' => '編輯題目',
                'question' => $question,
                'works' => AnimeWork::findAll(true),
                'errors' => $errors,
                'old' => $old,
            ]);

            return;
        }

        Question::update($id, $data);

        header('Location: /admin/questions');
        exit;
    }

    public function toggle(int $id): void
    {
        AuthService::requireLogin();
        Csrf::verify((string) ($_POST['csrf_token'] ?? ''));

        if (Question::findById($id) === null) {
            http_response_code(404);
            echo '找不到題目';

            return;
        }

        Question::toggle($id);

        header('Location: /admin/questions');
        exit;
    }

    private function validateInput(array $post, ?array $existing = null): array
    {
        $errors = [];

        $workIdRaw = trim((string) ($post['anime_work_id'] ?? ''));
        $type = (string) ($post['type'] ?? '');
        $difficulty = (string) ($post['difficulty'] ?? 'normal');
        $prompt = trim((string) ($post['prompt'] ?? ''));
        $correctAnswer = trim((string) ($post['correct_answer'] ?? ''));
        $choicesRaw = is_array($post['choices'] ?? null) ? $post['choices'] : [];
        $acceptedAnswersRaw = trim((string) ($post['accepted_answers'] ?? ''));

        $old = [
            'anime_work_id' => $workIdRaw,
            'type' => $type,
            'difficulty' => $difficulty,
            'prompt' => $prompt,
            'correct_answer' => $correctAnswer,
            'choices' => $choicesRaw,
            'accepted_answers' => $acceptedAnswersRaw,
        ];

        $workId = ctype_digit($workIdRaw) ? (int) $workIdRaw : 0;

        if ($workId <= 0 || AnimeWork::findById($workId) === null) {
            $errors[] = '請選擇有效的作品';
        }

        if (!Validator::inArray($type, self::TYPES)) {
            $errors[] = '請選擇題型';
        }

        if (!Validator::inArray($difficulty, self::DIFFICULTIES)) {
            $errors[] = '請選擇有效的難易度';
        }

        if ($prompt === '') {
            $errors[] = '題目內容為必填';
        } elseif (!Validator::minLength($prompt, 5) || !Validator::maxLength($prompt, 200)) {
            $errors[] = '題目內容長度需為 5~200 字';
        }

        if ($correctAnswer === '') {
            $errors[] = '正確答案為必填';
        } elseif (!Validator::minLength($correctAnswer, 1) || !Validator::maxLength($correctAnswer, 100)) {
            $errors[] = '正確答案長度需為 1~100 字';
        }

        $choicesJson = null;
        $acceptedAnswersJson = null;

        if ($type === 'multiple_choice') {
            $choices = array_map(static function ($choice): string {
                return trim((string) $choice);
            }, $choicesRaw);

            $nonEmptyCount = count(array_filter($choices, static function (string $choice): bool {
                return $choice !== '';
            }));

            if (count($choices) !== 4 || $nonEmptyCount !== 4) {
                $errors[] = '選擇題需恰好 4 個非空選項';
            } elseif ($correctAnswer !== '' && !in_array($correctAnswer, $choices, true)) {
                $errors[] = '正確答案必須完全等於其中一個選項';
            }

            if (count($choices) === 4) {
                $choicesJson = json_encode(array_values($choices), JSON_UNESCAPED_UNICODE);
            }
        } elseif ($type === 'fill_blank') {
            $acceptedAnswers = [];

            if ($acceptedAnswersRaw !== '') {
                foreach (preg_split('/\r\n|\r|\n/', $acceptedAnswersRaw) as $line) {
                    $line = trim($line);

                    if ($line !== '') {
                        $acceptedAnswers[] = $line;
                    }
                }
            }

            $acceptedAnswersJson = $acceptedAnswers === [] ? null : json_encode($acceptedAnswers, JSON_UNESCAPED_UNICODE);
        }

        $difficultyScore = ($existing !== null && $existing['difficulty'] === $difficulty)
            ? (int) $existing['difficulty_score']
            : DifficultyScale::midpointForTier($difficulty);

        $data = [
            'anime_work_id' => $workId,
            'type' => $type,
            'difficulty' => $difficulty,
            'difficulty_score' => $difficultyScore,
            'prompt' => $prompt,
            'choices_json' => $choicesJson,
            'correct_answer' => $correctAnswer,
            'accepted_answers_json' => $acceptedAnswersJson,
            'origin' => 'admin',
            'status' => 'approved',
        ];

        return [$errors, $data, $old];
    }
}
