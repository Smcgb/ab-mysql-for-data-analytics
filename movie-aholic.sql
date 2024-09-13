-- https://www.analystbuilder.com/courses/mysql-for-data-analytics/question/movie-aholic-fBXjU
-- Find the customer who has watched the greatest number of movies.
-- Return the Customer Name.
-- Example: If Ron watched "Lord of the Rings" 3 times and "Star Wars" 2 times (totaling 5 viewings), Leslie watched 4 movies, and Tom watched 2 movies, Ron, with his 5 total viewings, would be the answer.

-- for automatic parsing, the table name will be "movie_customers" instead of "customers" as noted in the excercise.

CREATE DATABASE IF NOT EXISTS abmysqlda;

USE abmysqlda;

CREATE TABLE IF NOT EXISTS movie_customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS movienames (
    movie_id INT PRIMARY KEY,
    movie_name VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS movie_date_viewed (
    customer_id INT REFERENCES movie_customers(customer_id),
    movie_id INT REFERENCES movienames(movie_id),
    view_date DATE
);

TRUNCATE movie_customers;
TRUNCATE movienames;
TRUNCATE movie_date_viewed;

INSERT INTO movie_customers (customer_id, customer_name) VALUES
(1, 'Ron'),
(2, 'Leslie'),
(3, 'Tom'),
(4, 'April');

INSERT INTO movienames (movie_id, movie_name) VALUES
(1, 'Spider-Man'),
(2, 'Lord of The Rings'),
(3, 'Star Wars'),
(4, 'Back to the Future');

INSERT INTO movie_date_viewed (customer_id, movie_id, view_date) VALUES
(4, 1, '2009-11-01'),
(2, 1, '2011-06-16'),
(3, 1, '2013-02-03'),
(2, 2, '2021-12-25'),
(1, 2, '2022-01-05'),
(3, 2, '2019-04-02'),
(4, 3, '2017-01-29'),
(1, 3, '2016-03-17'),
(2, 3, '2020-06-09'),
(3, 4, '2021-04-10'),
(1, 4, '2001-09-02'),
(3, 4, '2012-01-30'),
(4, 4, '2000-10-13');

DELIMITER //
CREATE PROCEDURE IF NOT EXISTS movieaholic()
BEGIN
    SELECT 
        c.customer_name
    FROM movie_customers AS c
    LEFT JOIN movie_date_viewed as dv 
        ON dv.customer_id = c.customer_id
    GROUP BY c.customer_name
    ORDER BY count(dv.view_date) DESC
    LIMIT 1;
END //

DELIMITER ;

CALL movieaholic();