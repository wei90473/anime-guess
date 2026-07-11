CREATE TABLE quiz_sessions (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    session_token CHAR(43) NOT NULL,
    guest_token CHAR(64) NOT NULL,
    anime_work_id INT UNSIGNED NOT NULL,
    question_count TINYINT UNSIGNED NOT NULL,
    correct_count TINYINT UNSIGNED NOT NULL DEFAULT 0,
    status ENUM('in_progress', 'completed') NOT NULL DEFAULT 'in_progress',
    started_at DATETIME NOT NULL,
    completed_at DATETIME NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY uq_quiz_sessions_token (session_token),
    KEY idx_quiz_sessions_guest_token (guest_token),
    KEY idx_quiz_sessions_work (anime_work_id),
    CONSTRAINT fk_quiz_sessions_anime_work FOREIGN KEY (anime_work_id) REFERENCES anime_works (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
