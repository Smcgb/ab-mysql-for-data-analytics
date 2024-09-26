-- https://www.analystbuilder.com/courses/mysql-for-data-analytics/question/contact-information-PtilV
-- If they don't have an email we need to create one for them. Use their first and last name to create a gmail for them.
-- Example: Jenny Fisher's email would become jenny.fisher@gmail.com
-- Output should include first name, last name, and email. All emails should be populated.
-- Order the output on email address alphabetically.
-- Note this can be done in a few ways, but we can use a function called "COALESCE" which will check for NULL Values and if it is NULL it will populate it with whatever you put in there.

CREATE DATABASE IF NOT EXISTS abmysqlda;
USE abmysqlda;

CREATE TABLE IF NOT EXISTS contact_information (
    id INT PRIMARY KEY,
    email VARCHAR(50),
    address VARCHAR(50)
);

TRUNCATE contact_information;

CREATE TABLE IF NOT EXISTS people_information (
id INT,
first_name VARCHAR(50),
last_name VARCHAR(50),
city VARCHAR(50),
state VARCHAR(50)
);

TRUNCATE people_information;

INSERT INTO contact_information
    VALUES
      (1, 'emily.hernandez@gmail.com', '123 Main St'),
      (2, 'jasmine.chen@gmail.com', '456 Oak Ave'),
      (3, 'austin.garcia@gmail.com', '789 Elm St'),
      (4, NULL, NULL),
      (5, 'avery.davis@gmail.com', '654 Maple St'),
      (6, 'olivia.wilson@gmail.com', '987 Cherry Ln'),
      (7, NULL, '234 Birch Ave'),
      (8, 'sophie.thompson@gmail.com', NULL),
      (9, 'liam.wright@gmail.com', '890 Cedar Rd'),
      (10, 'isabella.perez@gmail.com', '1111 Oak St'),
      (11, NULL, '2222 Pine St'),
      (12, 'evelyn.nelson@gmail.com', '3333 Birch Blvd'),
      (13, 'michael.king@gmail.com', NULL),
      (14, 'madison.baker@gmail.com', '5555 Maple Rd'),
      (15, 'elijah.robinson@gmail.com', '6666 Pine Ave'),
      (16, 'ava.green@gmail.com', '7777 Cedar Blvd'),
      (17, NULL, '8888 Birch St'),
      (18, 'victoria.allen@gmail.com', '9999 Maple Ln'),
      (19, 'benjamin.hill@gmail.com', NULL),
      (20, 'emma.walker@gmail.com', '5678 Cedar Ln');

INSERT INTO people_information (id, first_name, last_name, city, state)
VALUES
    (1, 'Emily', 'Hernandez', 'San Francisco', 'CA'),
    (2, 'Jasmine', 'Chen', 'New York', 'NY'),
    (3, 'Austin', 'Garcia', 'Austin', 'TX'),
    (4, 'Brandon', 'Lee', 'Los Angeles', 'CA'),
    (5, 'Avery', 'Davis', 'Chicago', 'IL'),
    (6, 'Olivia', 'Wilson', 'Miami', 'FL'),
    (7, 'Ethan', 'Cooper', 'Denver', 'CO'),
    (8, 'Sophie', 'Thompson', 'Seattle', 'WA'),
    (9, 'Liam', 'Wright', 'Boston', 'MA'),
    (10, 'Isabella', 'Perez', 'Phoenix', 'AZ'),
    (11, 'Noah', 'Carter', 'Atlanta', 'GA'),
    (12, 'Evelyn', 'Nelson', 'Portland', 'OR'),
    (13, 'Michael', 'King', 'Nashville', 'TN'),
    (14, 'Madison', 'Baker', 'New Orleans', 'LA'),
    (15, 'Elijah', 'Robinson', 'San Diego', 'CA'),
    (16, 'Ava', 'Green', 'Dallas', 'TX'),
    (17, 'Alexander', 'Hall', 'Philadelphia', 'PA'),
    (18, 'Victoria', 'Allen', 'Charlotte', 'NC'),
    (19, 'Benjamin', 'Hill', 'Houston', 'TX'),
    (20, 'Emma', 'Walker', 'Salt Lake City', 'UT');

DELIMITER //

CREATE PROCEDURE IF NOT EXISTS contact_information_proc()
BEGIN
    SELECT 
      p.first_name,
      p.last_name,
      COALESCE(c.email, lower(CONCAT(p.first_name, '.', p.last_name, '@gmail.com'))) as email
    FROM people_information AS p
    LEFT JOIN contact_information AS c
      ON c.id = p.id
    ORDER BY email;
END //

DELIMITER ;

CALL contact_information_proc();