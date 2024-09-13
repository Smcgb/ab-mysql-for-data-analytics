-- https://www.analystbuilder.com/courses/mysql-for-data-analytics/question/average-gaming-session-WpZJK
-- What was the average time spent, per user, gaming on their computer?

CREATE DATABASE IF NOT EXISTS abmysqlda;
USE abmysqlda;

CREATE TABLE IF NOT EXISTS gaming_sessions (
    user_id int,
    session_id int,
    minutes_per_session int,
    activity varchar(15)
);

TRUNCATE gaming_sessions;

INSERT INTO gaming_sessions (user_id, session_id, minutes_per_session, activity) 
    VALUES
        (1, 1, 44, 'Gaming'),
        (1, 1, 27, 'Homework'),
        (1, 1, 25, 'YouTube'),
        (2, 7, 37, 'Gaming'),
        (2, 6, 23, 'Gaming'),
        (3, 5, 88, 'Homework'),
        (3, 5, 85, 'Homework'),
        (3, 4, 76, 'Homework'),
        (4, 3, 88, 'YouTube'),
        (4, 3, 57, 'Gaming'),
        (4, 2, 32, 'Gaming'),
        (4, 2, 98, 'YouTube');

DELIMITER //

CREATE PROCEDURE IF NOT EXISTS average_gaming_session()
BEGIN
    SELECT user_id,
        AVG(minutes_per_session) AS avg_minutes_per_session
    FROM gaming_sessions
    WHERE activity = 'Gaming'
    GROUP BY user_id;
END //

DELIMITER ;

CALL average_gaming_session();