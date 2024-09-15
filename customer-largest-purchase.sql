-- https://www.analystbuilder.com/courses/mysql-for-data-analytics/question/customers-largest-purchases-bAKfU
-- We want to take a look at each customers purchases and give them their own row number.
-- Break the rows out by the customer and give each row a number based off the amount spent starting from the highest to the lowest.

CREATE DATABASE IF NOT EXISTS abmysqlda;
USE abmysqlda;

CREATE TABLE IF NOT EXISTS clp_purchases (
    customer_id INT,
    transaction_id INT,
    amount INT
);

TRUNCATE clp_purchases;

INSERT INTO clp_purchases
    VALUES
      (1001, 339473, 89),
      (1002, 359433, 5),
      (1003, 43176, 52),
      (1004, 27169, 19),
      (1001, 530588, 4),
      (1004, 528902, 78),
      (1005, 584167, 72),
      (1003, 55479, 45),
      (1005, 500607, 98),
      (1004, 544617, 65),
      (1001, 374711, 94),
      (1002, 328456, 42),
      (1005, 412764, 43),
      (1001, 225602, 19),
      (1004, 642498, 55),
      (1002, 415562, 50),
      (1005, 272319, 78),
      (1001, 445346, 92),
      (1002, 458215, 30),
      (1004, 173711, 91),
      (1003, 102487, 39),
      (1005, 566617, 58);



DELIMITER //

CREATE PROCEDURE IF NOT EXISTS customer_largest_purchase()
BEGIN
    SELECT 
      customer_id, 
      amount,
      ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY amount DESC) rn  
    FROM clp_purchases;
END //

DELIMITER ;

CALL customer_largest_purchase();