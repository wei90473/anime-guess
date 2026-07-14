ALTER TABLE questions
    MODIFY COLUMN difficulty ENUM('easy','normal','hard','extreme') NOT NULL DEFAULT 'normal';
