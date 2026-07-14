-- 0012_create_question_feedbacks_table.sql
-- 依賴：0003_create_questions_table.sql, 0001_create_anime_works_table.sql
-- 可重複執行（idempotent）

CREATE TABLE IF NOT EXISTS question_feedbacks (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    question_id INT UNSIGNED NOT NULL,
    anime_work_id INT UNSIGNED NOT NULL,
    guest_token CHAR(64) NOT NULL,
    feedback_type ENUM('wrong_answer','unclear_prompt','bad_choices','difficulty_mismatch','other') NOT NULL,
    suggested_difficulty ENUM('easy','normal','hard','extreme') NULL,
    message VARCHAR(500) NULL,
    status ENUM('open','resolved','ignored') NOT NULL DEFAULT 'open',
    feedback_date DATE NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY uq_qf_guest_question_date (guest_token, question_id, feedback_date),
    KEY idx_qf_question (question_id),
    KEY idx_qf_work_status (anime_work_id, status),
    KEY idx_qf_type (feedback_type),
    CONSTRAINT fk_qf_question FOREIGN KEY (question_id) REFERENCES questions (id),
    CONSTRAINT fk_qf_work FOREIGN KEY (anime_work_id) REFERENCES anime_works (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
