-- https://www.analystbuilder.com/courses/mysql-for-data-analytics/question/bad-bonuses-Yeqqp
-- Everyone at Analyst Builder is supposed to receive a bonus at the end of the year.
-- Unfortunately some people didn't receive their bonus as was promised.
-- Write a query to determine the employees who did not receive their bonus so we can notify accounting.
-- Return their id and name in the output. Order the id from lowest to highest.

CREATE DATABASE IF NOT EXISTS abmysqlda;
USE abmysqlda;

CREATE TABLE IF NOT EXISTS bonus_employees (
    employee_id INT PRIMARY KEY,
    `name` VARCHAR(50),
    salary INT,
    supervisor_id INT
);

CREATE TABLE IF NOT EXISTS bonus (
    emp_id INT PRIMARY KEY,
    bonus INT
);

TRUNCATE bonus_employees;
TRUNCATE bonus;

INSERT INTO bonus_employees (employee_id, `name`, salary, supervisor_id) VALUES
(1, 'Josh', 65000, NULL),
(2, 'Mary', 30000, 1),
(3, 'Tim', 32000, 1),
(4, 'Sarah', 40000, NULL),
(5, 'Michael', 35000, 4);

INSERT INTO bonus (emp_id, bonus) VALUES
(1, 2000),
(4, 850),
(5, 750);

DELIMITER //
CREATE PROCEDURE IF NOT EXISTS find_bad_bonuses()
BEGIN
    SELECT 
      employee_id
      ,name
    FROM bonus_employees
    WHERE employee_id NOT IN (SELECT emp_id FROM bonus);
END //

DELIMITER ;

CALL find_bad_bonuses();