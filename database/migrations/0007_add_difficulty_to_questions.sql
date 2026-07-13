SET @dbname = DATABASE();
SET @tablename = 'questions';
SET @columnname = 'difficulty';
SET @preparedStatement = (
    SELECT IF(
        (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS
         WHERE TABLE_SCHEMA = @dbname AND TABLE_NAME = @tablename AND COLUMN_NAME = @columnname) > 0,
        'SELECT 1',
        'ALTER TABLE questions ADD COLUMN difficulty ENUM(''easy'',''normal'',''hard'') NOT NULL DEFAULT ''normal'' AFTER type'
    )
);
PREPARE alterIfNotExists FROM @preparedStatement;
EXECUTE alterIfNotExists;
DEALLOCATE PREPARE alterIfNotExists;
