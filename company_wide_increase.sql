CREATE DATABASE IF NOT EXISTS abmysqlda;
USE abmysqlda;

-- https://www.analystbuilder.com/courses/mysql-for-data-analytics/question/company-wide-increase-ouuah

-- If our company hits its yearly targets, every employee receives a salary increase depending on what level you are in the company.
-- Give each Employee who is a level 1 a 10% increase, level 2 a 15% increase, and level 3 a 200% increase.
-- Include this new column in your output as "new_salary"

CREATE TABLE IF NOT EXISTS employees (
    employee_id int PRIMARY KEY,
    pay_level int,
    salary int
);

TRUNCATE employees;

INSERT INTO employees VALUES
(1001, 1, 75000),
(1002, 1, 85000),
(1003, 1, 60000),
(1004, 2, 95000),
(1005, 2, 95000),
(1006, 2, 85000),
(1007, 2, 105000),
(1008, 3, 300000),
(1009, 2, 105000),
(1010, 2, 95000),
(1011, 2, 115000),
(1012, 1, 85000),
(1013, 1, 75000),
(1014, 1, 60000),
(1015, 1, 75000),
(1016, 2, 85000),
(1017, 2, 105000),
(1018, 2, 95000),
(1019, 1, 75000);

DELIMITER //

CREATE PROCEDURE IF NOT EXISTS company_wide_increase()
BEGIN
    SELECT *,
        CASE
          WHEN pay_level = 1 THEN (salary * 1.1)
          WHEN pay_level = 2 THEN (salary * 1.15)
          WHEN pay_level = 3 THEN (salary * 3)
        END AS new_salary
    FROM employees;
END //

DELIMITER ;

CALL company_wide_increase();