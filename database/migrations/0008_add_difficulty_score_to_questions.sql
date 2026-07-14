SET @dbname = DATABASE();
SET @tablename = 'questions';
SET @columnname = 'difficulty_score';
SET @column_exists = (
    SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_SCHEMA = @dbname AND TABLE_NAME = @tablename AND COLUMN_NAME = @columnname
);

SET @preparedStatement = (
    SELECT IF(
        @column_exists > 0,
        'SELECT 1',
        'ALTER TABLE questions ADD COLUMN difficulty_score TINYINT UNSIGNED NOT NULL DEFAULT 50 AFTER difficulty'
    )
);
PREPARE alterIfNotExists FROM @preparedStatement;
EXECUTE alterIfNotExists;
DEALLOCATE PREPARE alterIfNotExists;

-- Backfill only runs the first time the column is created (@column_exists was 0
-- at the start of this migration run). On any rerun the column already exists,
-- so this becomes a no-op and cannot overwrite calibrated difficulty_score values.
SET @backfillStatement = (
    SELECT IF(
        @column_exists > 0,
        'SELECT 1',
        "UPDATE questions SET difficulty_score = CASE difficulty
            WHEN 'easy' THEN 16
            WHEN 'hard' THEN 78
            WHEN 'extreme' THEN 95
            ELSE 50
        END"
    )
);
PREPARE backfillIfNotExists FROM @backfillStatement;
EXECUTE backfillIfNotExists;
DEALLOCATE PREPARE backfillIfNotExists;
