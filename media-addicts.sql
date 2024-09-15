-- https://www.analystbuilder.com/courses/mysql-for-data-analytics/question/media-addicts-QSeoW
-- Social Media Addiction can be a crippling disease affecting millions every year.
-- We need to identify people who may fall into that category.
-- Write a query to find the people who spent a higher than average amount of time on social media.

CREATE DATABASE IF NOT EXISTS abmysqlda;
USE abmysqlda;

CREATE TABLE IF NOT EXISTS media_user_time (
    user_id INT PRIMARY KEY,
    media_time_minutes INT
);

CREATE TABLE IF NOT EXISTS media_user (
    user_id INT PRIMARY KEY,
    first_name VARCHAR(50)
);

TRUNCATE media_user_time;
TRUNCATE media_user;

INSERT INTO media_user_time (user_id, media_time_minutes) VALUES
(1, 0),
(2, 200),
(3, 250),
(4, 15),
(5, 500),
(6, 45),
(7, 450),
(8, 1000),
(9, 300),
(10, 60);

INSERT INTO media_user (user_id, first_name) VALUES
(1, 'John'),
(2, 'Janice'),
(3, 'Michael'),
(4, 'Molly'),
(5, 'Adam'),
(6, 'Amanda'),
(7, 'Chris'),
(8, 'Christine'),
(9, 'Bella'),
(10, 'Brian');

DELIMITER //
CREATE PROCEDURE IF NOT EXISTS media_addicts()
BEGIN
    SELECT first_name
      FROM
    (SELECT 
      ut.user_id AS user_id,
      ut.media_time_minutes,
      u.first_name
    FROM media_user_time AS ut
    LEFT JOIN media_user AS u 
      ON u.user_id = ut.user_id
    HAVING media_time_minutes > (SELECT AVG(media_time_minutes) FROM media_user_time)) AS t1
    ORDER BY first_name ASC;
END //
DELIMITER ;

CALL media_addicts();