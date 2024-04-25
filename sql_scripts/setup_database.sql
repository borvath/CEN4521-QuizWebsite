DROP DATABASE IF EXISTS quizmaker;
CREATE DATABASE IF NOT EXISTS quizmaker;
USE quizmaker;

CREATE TABLE IF NOT EXISTS user (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    username VARCHAR(100) NOT NULL,
    password VARCHAR(255) NOT NULL,
    type ENUM('student', 'admin') NOT NULL,
    PRIMARY KEY(id),
    UNIQUE INDEX username_UNIQUE (username ASC) VISIBLE
);

CREATE TABLE IF NOT EXISTS quiz (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    author_id INT UNSIGNED NOT NULL,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(500),
    course VARCHAR(50),
    creation_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE INDEX name_UNIQUE (name ASC) VISIBLE,
    CONSTRAINT author_id FOREIGN KEY (author_id) REFERENCES user(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS question (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    quiz_id INT UNSIGNED NOT NULL,
    question_text VARCHAR(500) NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT quiz_id FOREIGN KEY (quiz_id) REFERENCES quiz(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS answer (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    question_id INT UNSIGNED NOT NULL,
    answer_text VARCHAR(500) NOT NULL,
    is_correct BOOLEAN NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT question_id FOREIGN KEY (question_id) REFERENCES question(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS grade (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    user_id INT UNSIGNED NOT NULL,
    quiz_id INT UNSIGNED NOT NULL,
    score INT UNSIGNED NOT NULL DEFAULT 0,
    PRIMARY KEY (id),
    CONSTRAINT grade_user_id FOREIGN KEY (user_id) REFERENCES user(id) ON DELETE CASCADE,
    CONSTRAINT grade_quiz_id FOREIGN KEY (quiz_id) REFERENCES quiz(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS ratings (
    studentID INT UNSIGNED NOT NULL,
    quizID INT UNSIGNED NOT NULL,
    studentRatings VARCHAR(250),
    amountOfStars INT UNSIGNED CHECK (amountOfStars >= 1 AND amountOfStars <= 5),
    PRIMARY KEY (studentID, quizID),
    CONSTRAINT quizID FOREIGN KEY (quizID) REFERENCES quiz(id) ON DELETE CASCADE,
    CONSTRAINT studentID FOREIGN KEY (studentID) REFERENCES user(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS login_log (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    user_id INT UNSIGNED NOT NULL,
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    CONSTRAINT user_id FOREIGN KEY (user_id) REFERENCES user(id) ON DELETE CASCADE
);
