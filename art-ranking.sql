-- https://www.analystbuilder.com/courses/mysql-for-data-analytics/question/art-ranking-eJnaJ

-- Each artist was given a rating by 3 separate judges.
-- Write a query to combine those scores and rank the artists from highest to lowest. If there is a tie the next ranking after it should be the next number sequentially, meaning there will be a gap in the next rank.
-- Output should include the artist, their total score, and rank.
-- Order your output from smallest to largest rank. If there is a tie order on the artist id as well from smallest to largest.
-- CREATE DATABASE IF NOT EXISTS abmysqlda;

CREATE DATABASE IF NOT EXISTS abmysqlda;
USE abmysqlda;

CREATE TABLE IF NOT EXISTS art_rankings (
    artist_id INT,
    judge_id INT,
    score INT
);

TRUNCATE art_rankings;

INSERT INTO art_rankings 
    VALUES
      (1, 1001, 4),
      (2, 1001, 6),
      (3, 1001, 4),
      (4, 1001, 10),
      (5, 1001, 7),
      (1, 1002, 4),
      (2, 1002, 6),
      (3, 1002, 7),
      (4, 1002, 5),
      (5, 1002, 10),
      (1, 1003, 7),
      (2, 1003, 5),
      (3, 1003, 4),
      (4, 1003, 8),
      (5, 1003, 6);

DELIMITER //

CREATE PROCEDURE IF NOT EXISTS art_ranking()
BEGIN
    SELECT artist_id,
           SUM(score) AS Total_score,
           RANK() OVER(ORDER BY SUM(score) DESC) rn
    FROM art_rankings
    GROUP BY artist_id
      ORDER BY rn, artist_id;
END //

DELIMITER ;

CALL art_ranking();