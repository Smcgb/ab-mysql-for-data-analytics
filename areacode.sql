-- https://www.analystbuilder.com/courses/mysql-for-data-analytics/question/football-perfection-EcevI
-- Identify the Football teams that scored over 400 points and had 80 or less fouls.

CREATE DATABASE IF NOT EXISTS abmysqlda;

USE abmysqlda;

CREATE TABLE IF NOT EXISTS phone_numbers (
	numbers char(12) PRIMARY KEY
);

TRUNCATE phone_numbers;

INSERT INTO phone_numbers (numbers) VALUES
    ('701-555-1234'),
    ('555-701-5678'),
    ('555-123-4701'),
    ('701-123-4567'),
    ('123-701-6789'),
    ('123-456-7701'),
    ('701-678-9012'),
    ('678-701-1234'),
    ('678-901-7012');


DELIMITER //

CREATE PROCEDURE IF NOT EXISTS seven01_areacode()
BEGIN
    SELECT numbers FROM phone_numbers
    WHERE numbers LIKE "701%";
END //

DELIMITER ;

CALL seven01_areacode();
