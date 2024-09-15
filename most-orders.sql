--  https://www.analystbuilder.com/courses/mysql-for-data-analytics/question/most-orders-EHObW
--  Write an SQL query to identify the customer who had the largest number of orders.
--  Return the Customer_ID and number of orders, but if 2 customers had the same amount of orders, return them both.

CREATE DATABASE IF NOT EXISTS abmysqlda;
USE abmysqlda;

CREATE TABLE IF NOT EXISTS m_orders (
    customer_id INT,
    number_of_orders INT
);

TRUNCATE m_orders;

INSERT INTO m_orders VALUES
   (1,15),
   (2,25),
   (3,4),
   (4,21),
   (5,5),
   (6,9),
   (7,25),
   (8,22),
   (9,2),
   (10,1);

DELIMITER //
CREATE PROCEDURE IF NOT EXISTS most_orders()
BEGIN
    SELECT
      customer_id,
      number_of_orders
    FROM m_orders
    HAVING number_of_orders = (SELECT MAX(number_of_orders) FROM m_orders);
END //

DELIMITER ;

CALL most_orders();