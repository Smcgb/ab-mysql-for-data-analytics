CREATE DATABASE IF NOT EXISTS abmysqlda;
USE abmysqlda;

CREATE TABLE if not exists products (
    product_name varchar(40),
    purchase_price decimal(5,2),
    sales_price decimal(5,2)
);

TRUNCATE products;

INSERT INTO products (product_name, purchase_price, sales_price) VALUES 
    ('Dog shampoo', 5.0, 10.0),
    ('Dog conditioner', 6.5, 12.0),
    ('Dog nail clippers', 3.25, 8.0),
    ('Dog hair brush', 4.75, 9.5),
    ('Dog ear cleaner', 2.8, 6.5),
    ('Dog grooming scissors', 7.2, 15.0),
    ('Dog toothbrush and toothpaste set', 4.0, 10.0);

DELIMITER //
    -- https://www.analystbuilder.com/courses/mysql-for-data-analytics/question/profit-margin-PGQzz
    -- Determine the profit margin for each product.
    -- The profit margin is derived by subtracting the Purchase Price from the Sale Price and then applying a 7% tax on that amount.
    -- Present the product name along with its corresponding profit (round to 2 decimal places).
    -- Order products by largest profit to smallest and products alphabetically.

    CREATE PROCEDURE IF NOT EXISTS profit_margin()
    BEGIN
       SELECT product_name, ROUND((sales_price - purchase_price) * 0.93, 2) AS profit
        FROM products
        ORDER BY profit DESC, product_name;
    END //

DELIMITER ;

CALL profit_margin();