CREATE TABLE quiz_session_questions (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    quiz_session_id INT UNSIGNED NOT NULL,
    question_id INT UNSIGNED NOT NULL,
    order_index TINYINT UNSIGNED NOT NULL,
    player_answer VARCHAR(255) NULL,
    is_correct TINYINT(1) NULL,
    answered_at DATETIME NULL,
    UNIQUE KEY uq_session_order (quiz_session_id, order_index),
    UNIQUE KEY uq_session_question (quiz_session_id, question_id),
    KEY idx_session_questions_question (question_id),
    CONSTRAINT fk_session_questions_session FOREIGN KEY (quiz_session_id) REFERENCES quiz_sessions (id),
    CONSTRAINT fk_session_questions_question FOREIGN KEY (question_id) REFERENCES questions (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
