-- https://www.analystbuilder.com/courses/mysql-for-data-analytics/lesson/importing-data-into-mysql-BUhyR
-- File should be downloaded via wget in bash

SET GLOBAL local_infile=ON;
USE bakery;

CREATE TABLE IF NOT EXISTS product_suggestions (
    product_suggestion_id INT PRIMARY KEY,
    product_suggestion_name VarChar(50),
    date_received DATE
);

TRUNCATE product_suggestions;

-- You may need to change the path to the file depending on where you downloaded it too.
LOAD DATA LOCAL INFILE '/home/barrel/mysql-for-data-analytics/product_suggestions.csv'
INTO TABLE product_suggestions
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT * FROM product_suggestions;