<?php

declare(strict_types=1);

namespace App\Controllers;

use App\Models\AnimeWork;
use App\Models\Question;
use App\Support\GuestToken;
use App\Support\View;

class HomeController
{
    public function index(): void
    {
        GuestToken::get();

        $works = AnimeWork::findAll();

        foreach ($works as &$work) {
            $work['question_count'] = Question::countByWork((int) $work['id']);
        }
        unset($work);

        View::render('home/index', [
            'title' => 'Anime Guess',
            'works' => $works,
        ]);
    }
}
