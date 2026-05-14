CREATE DATABASE ss15_social_network_db;
USE ss15_social_network_db;

-- 1. TABLE USERS

CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);


-- 2. TABLE POSTS

CREATE TABLE posts (
    post_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    content TEXT NOT NULL,

    like_count INT DEFAULT 0,
    comment_count INT DEFAULT 0,

    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_posts_users
    FOREIGN KEY (user_id)
    REFERENCES users(user_id)
);

-- FULLTEXT SEARCH

ALTER TABLE posts
ADD FULLTEXT(content);

-- 3. TABLE COMMENTS

CREATE TABLE comments (
    comment_id INT PRIMARY KEY AUTO_INCREMENT,
    post_id INT NOT NULL,
    user_id INT NOT NULL,
    content TEXT NOT NULL,

    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_comments_posts
    FOREIGN KEY (post_id)
    REFERENCES posts(post_id),

    CONSTRAINT fk_comments_users
    FOREIGN KEY (user_id)
    REFERENCES users(user_id)
);


-- 4. TABLE LIKES

CREATE TABLE likes (
    like_id INT PRIMARY KEY AUTO_INCREMENT,

    user_id INT NOT NULL,
    post_id INT NOT NULL,

    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT uq_user_post
    UNIQUE(user_id, post_id),

    CONSTRAINT fk_likes_users
    FOREIGN KEY (user_id)
    REFERENCES users(user_id),

    CONSTRAINT fk_likes_posts
    FOREIGN KEY (post_id)
    REFERENCES posts(post_id)
);


-- 5. TABLE FRIENDS

CREATE TABLE friends (
    friendship_id INT PRIMARY KEY AUTO_INCREMENT,

    user_id INT NOT NULL,
    friend_id INT NOT NULL,

    status VARCHAR(20)
    CHECK(status IN ('pending', 'accepted')),

    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT chk_not_self_friend
    CHECK(user_id <> friend_id),

    CONSTRAINT fk_friends_user
    FOREIGN KEY (user_id)
    REFERENCES users(user_id),

    CONSTRAINT fk_friends_friend
    FOREIGN KEY (friend_id)
    REFERENCES users(user_id)
);


-- 6. TABLE POST LOGS

CREATE TABLE post_logs (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    post_id INT,
    post_content TEXT,
    deleted_at DATETIME DEFAULT CURRENT_TIMESTAMP
);


INSERT INTO users(username, password, email)
VALUES
('alice', '123456', 'alice@gmail.com'),
('bob', '123456', 'bob@gmail.com'),
('charlie', '123456', 'charlie@gmail.com');


INSERT INTO posts(user_id, content)
VALUES
(1, 'Hello everyone'),
(2, 'Learning MySQL'),
(3, 'Social network project');


INSERT INTO comments(post_id, user_id, content)
VALUES
(1, 2, 'Nice post'),
(1, 3, 'Very good');


INSERT INTO likes(user_id, post_id)
VALUES
(1, 2),
(2, 1),
(3, 1);

INSERT INTO friends(user_id, friend_id, status)
VALUES
(1, 2, 'accepted'),
(1, 3, 'pending');

-- =========================================
-- CHỨC NĂNG 1: VIEW USER INFO
-- =========================================

CREATE VIEW view_user_info AS
SELECT 
    user_id,
    username,
    email,
    created_at
FROM users;

DELIMITER $$

CREATE PROCEDURE sp_add_user(
    IN p_username VARCHAR(50),
    IN p_password VARCHAR(255),
    IN p_email VARCHAR(100)
)
BEGIN

    DECLARE check_username INT;
    DECLARE check_email INT;

    SELECT COUNT(user_id)INTO check_username FROM users WHERE username = p_username;
    SELECT COUNT(user_id) INTO check_email FROM users WHERE email = p_email;

    IF check_username > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'tên đã tồn tại';
    ELSEIF check_email > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Email đã tồn tại';
    ELSE
        INSERT INTO users(username, password, email)
        VALUES(p_username, p_password, p_email);

    END IF;

END $$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER tg_after_like_insert
AFTER INSERT ON likes
FOR EACH ROW
BEGIN

    UPDATE posts
    SET like_count = like_count + 1
    WHERE post_id = NEW.post_id;

END $$

DELIMITER ;


DELIMITER $$

CREATE TRIGGER tg_after_like_delete
AFTER DELETE ON likes
FOR EACH ROW
BEGIN

    UPDATE posts
    SET like_count = like_count - 1
    WHERE post_id = OLD.post_id
    AND like_count > 0;

END $$

DELIMITER ;


DELIMITER $$

CREATE TRIGGER tg_after_comment_insert
AFTER INSERT ON comments
FOR EACH ROW
BEGIN

    UPDATE posts
    SET comment_count = comment_count + 1
    WHERE post_id = NEW.post_id;

END $$

DELIMITER ;


DELIMITER $$

CREATE TRIGGER tg_after_comment_delete
AFTER DELETE ON comments
FOR EACH ROW
BEGIN

    UPDATE posts
    SET comment_count = comment_count - 1
    WHERE post_id = OLD.post_id
    AND comment_count > 0;

END $$

DELIMITER ;


DELIMITER $$

CREATE PROCEDURE sp_user_activity_report()
BEGIN

    SELECT u.user_id, u.username,
        COUNT(DISTINCT p.post_id) AS total_posts,
        COUNT(DISTINCT l.like_id) AS total_likes,
        COUNT(DISTINCT c.comment_id) AS total_comments

    FROM users u

    LEFT JOIN posts p
    ON u.user_id = p.user_id

    LEFT JOIN likes l
    ON u.user_id = l.user_id

    LEFT JOIN comments c
    ON u.user_id = c.user_id

    GROUP BY
        u.user_id,
        u.username;

END $$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE sp_delete_user(
    IN p_user_id INT
)
BEGIN

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    DELETE FROM likes
    WHERE user_id = p_user_id
    OR post_id IN (
        SELECT post_id
        FROM posts
        WHERE user_id = p_user_id
    );

    DELETE FROM comments
    WHERE user_id = p_user_id
    OR post_id IN (
        SELECT post_id
        FROM posts
        WHERE user_id = p_user_id
    );

    DELETE FROM friends
    WHERE user_id = p_user_id
    OR friend_id = p_user_id;

    DELETE FROM posts
    WHERE user_id = p_user_id;

    DELETE FROM users
    WHERE user_id = p_user_id;

    COMMIT;

END $$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER tg_before_friend_insert
BEFORE INSERT ON friends
FOR EACH ROW
BEGIN

    IF NEW.user_id = NEW.friend_id THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot friend yourself';

    END IF;

    IF EXISTS (
        SELECT friendship_id
        FROM friends
        WHERE user_id = NEW.user_id
        AND friend_id = NEW.friend_id
    ) THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Friend already exists';

    END IF;

    IF EXISTS (
        SELECT friendship_id
        FROM friends
        WHERE user_id = NEW.friend_id
        AND friend_id = NEW.user_id
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Reverse friend request exists';
    END IF;

END $$

DELIMITER ;