CREATE DATABASE IF NOT EXISTS abmysqlda;
USE abmysqlda;

-- https://www.analystbuilder.com/courses/mysql-for-data-analytics/question/duplicate-emails-Lntae
-- There's recently been an error on our server where some emails were duplicated. We need to identify those emails so we can remove the duplicates.
-- Write an SQL query to report all the duplicate emails and how many times they are in the database.
-- Output should be in alphabetical order.

CREATE TABLE IF NOT EXISTS emails (
    id int PRIMARY KEY,
    email varchar(255)
);

TRUNCATE emails;

INSERT INTO emails VALUES
(1, 'alex@gmail.com'),
(2, 'Gregory@yahoo.com'),
(3, 'analystbuilder@gmail.com'),
(4, 'sally@aol.com'),
(5, 'ted@gmail.com'),
(6, 'Kevin@yahoo.com'),
(7, 'Jennifer@yahoo.com'),
(8, 'alex@gmail.com'),
(9, 'Larry@gmail.com'),
(10, 'Ted@yahoo.com'),
(11, 'analystbuilder@gmail.com');

DELIMITER //

CREATE PROCEDURE IF NOT EXISTS duplicate_emails()
BEGIN
    SELECT 
        email,
        COUNT(email) as `count`
    FROM emails
    GROUP BY email
    HAVING count(email) > 1;
END //

DELIMITER ;

CALL duplicate_emails();
