CREATE TABLE IF NOT EXISTS submission_attempts (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    guest_token CHAR(64) NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    KEY idx_submission_attempts_guest_token_created_at (guest_token, created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Backfill minimal attempt rows (no question content) from existing recent
-- submissions so the 24h/5 rate limit does not reset when switching to this
-- table. Guarded by row count so rerunning this migration does not duplicate
-- attempts once real traffic has populated the table.
SET @attempts_exist = (SELECT COUNT(*) FROM submission_attempts);

SET @backfillStatement = (
    SELECT IF(
        @attempts_exist > 0,
        'SELECT 1',
        "INSERT INTO submission_attempts (guest_token, created_at)
         SELECT submitted_by_token, created_at FROM questions
         WHERE origin = 'submission' AND submitted_by_token IS NOT NULL
           AND created_at >= (NOW() - INTERVAL 24 HOUR)"
    )
);
PREPARE backfillAttempts FROM @backfillStatement;
EXECUTE backfillAttempts;
DEALLOCATE PREPARE backfillAttempts;
