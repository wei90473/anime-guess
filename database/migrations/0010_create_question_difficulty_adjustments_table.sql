CREATE TABLE IF NOT EXISTS question_difficulty_adjustments (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    guest_token CHAR(64) NOT NULL,
    anime_work_id INT UNSIGNED NOT NULL,
    quiz_session_id INT UNSIGNED NOT NULL,
    adjustment_date DATE NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY uq_qda_guest_work_date (guest_token, anime_work_id, adjustment_date),
    KEY idx_qda_session (quiz_session_id),
    CONSTRAINT fk_qda_work FOREIGN KEY (anime_work_id) REFERENCES anime_works (id),
    CONSTRAINT fk_qda_session FOREIGN KEY (quiz_session_id) REFERENCES quiz_sessions (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
