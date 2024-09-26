-- https://www.analystbuilder.com/courses/mysql-for-data-analytics/question/boss-NKNgs
-- My Boss wants a report that shows each employee and their bosses name so he can try to memorize it before our quarterly social event.
-- Provide an output that includes the employee name matched with the name of their boss.
-- If they don't have a boss still include them in the output.
-- Order output on employee name alphabetically.

CREATE DATABASE IF NOT EXISTS abmysqlda;
USE abmysqlda;

CREATE TABLE IF NOT EXISTS boss (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(255),
    boss_id INT
);

TRUNCATE boss;

INSERT INTO boss (employee_id, employee_name, boss_id) 
    VALUES
        (1, 'Josh Harper', NULL),
        (2, 'Carolina Francis', NULL),
        (3, 'Gerald Butler', 2),
        (4, 'Richie Rich', 3),
        (5, 'Carol Danvers', NULL),
        (6, 'Peter McMillan', 2),
        (7, 'Sarah Burdauch', 5),
        (8, 'Donald Glover', NULL);



DELIMITER //
CREATE PROCEDURE IF NOT EXISTS find_bosses()
BEGIN
    SELECT 
      e.employee_name,
      b.employee_name AS boss
    FROM boss as e
    LEFT OUTER JOIN boss as b
    ON b.employee_id = e.boss_id
      ORDER BY e.employee_name;
END //

DELIMITER ;

CALL find_bosses();