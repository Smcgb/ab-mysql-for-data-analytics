-- https://www.analystbuilder.com/courses/mysql-for-data-analytics/question/gamer-tags-vWMEm
-- Create a gamer tag for each player in the tournament.
-- Select the first 3 characters of their first name and combine that with the year they were born.
-- Your output should have their first name, last name, and gamer tag called "gamer_tag"
-- Order output on gamertag in alphabetical order.

CREATE DATABASE IF NOT EXISTS abmysqlda;

USE abmysqlda;

CREATE TABLE IF NOT EXISTS gamer_tags (
    first_name varchar(35),
    last_name varchar(35),
    birth_date date,
    game varchar(50)
);

TRUNCATE gamer_tags;

INSERT INTO gamer_tags VALUES
('Alexander', 'Maxwell', '1998-01-01', 'League of Legends'),
('Johnny', 'Baxter', '1997-11-05', 'Dota 2'),
('Kelly', 'Zillen', '1996-03-04', 'League of Legends'),
('Kevin', 'Mallow', '2000-12-12', 'League of Legends'),
('Lisa', 'Larz', '1997-03-04', 'Dota 2');

DELIMITER //

CREATE PROCEDURE IF NOT EXISTS create_gamer_tags()
BEGIN
    SELECT first_name, last_name, CONCAT(first_name, 1, 3, YEAR(birth_date)) AS gamer_tag
    FROM gamer_tags
    ORDER BY gamer_tag;
END //

DELIMITER ;

CALL create_gamer_tags();
