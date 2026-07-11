<?php

declare(strict_types=1);

namespace App\Controllers\Admin;

use App\Models\AnimeWork;
use App\Services\AuthService;
use App\Support\Csrf;
use App\Support\Validator;
use App\Support\View;

class WorkController
{
    public function index(): void
    {
        AuthService::requireLogin();

        View::render('admin/works/index', [
            'title' => '作品管理',
            'works' => AnimeWork::findAll(true),
        ]);
    }

    public function create(): void
    {
        AuthService::requireLogin();

        View::render('admin/works/form', [
            'title' => '新增作品',
            'work' => null,
            'errors' => [],
            'old' => [],
        ]);
    }

    public function store(): void
    {
        AuthService::requireLogin();
        Csrf::verify((string) ($_POST['csrf_token'] ?? ''));

        $title = trim((string) ($_POST['title'] ?? ''));
        $description = trim((string) ($_POST['description'] ?? ''));
        $coverImagePath = trim((string) ($_POST['cover_image_path'] ?? ''));

        $errors = $this->validate($title);

        if (!empty($errors)) {
            View::render('admin/works/form', [
                'title' => '新增作品',
                'work' => null,
                'errors' => $errors,
                'old' => [
                    'title' => $title,
                    'description' => $description,
                    'cover_image_path' => $coverImagePath,
                ],
            ]);

            return;
        }

        $slug = $this->uniqueSlug(AnimeWork::generateSlug($title));

        AnimeWork::create([
            'title' => $title,
            'slug' => $slug,
            'description' => $description,
            'cover_image_path' => $coverImagePath,
        ]);

        header('Location: /admin/works');
        exit;
    }

    public function edit(int $id): void
    {
        AuthService::requireLogin();

        $work = AnimeWork::findById($id);

        if ($work === null) {
            http_response_code(404);
            echo '找不到作品';

            return;
        }

        View::render('admin/works/form', [
            'title' => '編輯作品',
            'work' => $work,
            'errors' => [],
            'old' => [],
        ]);
    }

    public function update(int $id): void
    {
        AuthService::requireLogin();
        Csrf::verify((string) ($_POST['csrf_token'] ?? ''));

        $work = AnimeWork::findById($id);

        if ($work === null) {
            http_response_code(404);
            echo '找不到作品';

            return;
        }

        $title = trim((string) ($_POST['title'] ?? ''));
        $description = trim((string) ($_POST['description'] ?? ''));
        $coverImagePath = trim((string) ($_POST['cover_image_path'] ?? ''));

        $errors = $this->validate($title);

        if (!empty($errors)) {
            View::render('admin/works/form', [
                'title' => '編輯作品',
                'work' => $work,
                'errors' => $errors,
                'old' => [
                    'title' => $title,
                    'description' => $description,
                    'cover_image_path' => $coverImagePath,
                ],
            ]);

            return;
        }

        AnimeWork::update($id, [
            'title' => $title,
            'description' => $description,
            'cover_image_path' => $coverImagePath,
        ]);

        header('Location: /admin/works');
        exit;
    }

    public function toggle(int $id): void
    {
        AuthService::requireLogin();
        Csrf::verify((string) ($_POST['csrf_token'] ?? ''));

        if (AnimeWork::findById($id) === null) {
            http_response_code(404);
            echo '找不到作品';

            return;
        }

        AnimeWork::toggle($id);

        header('Location: /admin/works');
        exit;
    }

    private function validate(string $title): array
    {
        $errors = [];

        if (Validator::required(['title' => $title], ['title']) !== []) {
            $errors[] = '作品名稱為必填';
        } elseif (!Validator::maxLength($title, 150)) {
            $errors[] = '作品名稱長度不可超過 150 字';
        }

        return $errors;
    }

    private function uniqueSlug(string $baseSlug): string
    {
        if ($baseSlug === '') {
            $baseSlug = 'work';
        }

        $slug = $baseSlug;
        $suffix = 2;

        while (AnimeWork::findBySlug($slug) !== null) {
            $slug = $baseSlug . '-' . $suffix;
            $suffix++;
        }

        return $slug;
    }
}
