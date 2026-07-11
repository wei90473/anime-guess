<?php

declare(strict_types=1);

namespace App\Models;

use App\Support\Database;

class AnimeWork
{
    public static function findAll(bool $includeInactive = false): array
    {
        $sql = 'SELECT id, title, slug, cover_image_path, description, is_active, created_at, updated_at FROM anime_works';

        if (!$includeInactive) {
            $sql .= ' WHERE is_active = 1';
        }

        $sql .= ' ORDER BY title ASC';

        $statement = Database::connect()->query($sql);

        return $statement->fetchAll();
    }

    public static function findById(int $id): ?array
    {
        $statement = Database::connect()->prepare(
            'SELECT id, title, slug, cover_image_path, description, is_active, created_at, updated_at FROM anime_works WHERE id = :id'
        );
        $statement->execute(['id' => $id]);

        $row = $statement->fetch();

        return $row === false ? null : $row;
    }

    public static function findBySlug(string $slug): ?array
    {
        $statement = Database::connect()->prepare(
            'SELECT id, title, slug, cover_image_path, description, is_active, created_at, updated_at FROM anime_works WHERE slug = :slug'
        );
        $statement->execute(['slug' => $slug]);

        $row = $statement->fetch();

        return $row === false ? null : $row;
    }

    public static function create(array $data): int
    {
        $statement = Database::connect()->prepare(
            'INSERT INTO anime_works (title, slug, cover_image_path, description, is_active)
             VALUES (:title, :slug, :cover_image_path, :description, 1)'
        );
        $statement->execute([
            'title' => $data['title'],
            'slug' => $data['slug'],
            'cover_image_path' => $data['cover_image_path'] !== '' ? $data['cover_image_path'] : null,
            'description' => $data['description'] !== '' ? $data['description'] : null,
        ]);

        return (int) Database::connect()->lastInsertId();
    }

    public static function update(int $id, array $data): void
    {
        $statement = Database::connect()->prepare(
            'UPDATE anime_works
             SET title = :title, cover_image_path = :cover_image_path, description = :description
             WHERE id = :id'
        );
        $statement->execute([
            'title' => $data['title'],
            'cover_image_path' => $data['cover_image_path'] !== '' ? $data['cover_image_path'] : null,
            'description' => $data['description'] !== '' ? $data['description'] : null,
            'id' => $id,
        ]);
    }

    public static function toggle(int $id): void
    {
        $statement = Database::connect()->prepare(
            'UPDATE anime_works SET is_active = 1 - is_active WHERE id = :id'
        );
        $statement->execute(['id' => $id]);
    }

    public static function generateSlug(string $title): string
    {
        $slug = mb_strtolower(trim($title), 'UTF-8');
        $slug = preg_replace('/\s+/', '-', $slug);
        $slug = preg_replace('/[^a-z0-9-]/', '', (string) $slug);
        $slug = preg_replace('/-+/', '-', (string) $slug);
        $slug = trim((string) $slug, '-');

        return $slug;
    }
}
