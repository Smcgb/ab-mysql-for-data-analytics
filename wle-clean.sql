-- https://www.analystbuilder.com/courses/mysql-for-data-analytics/lesson/world-life-expectancy-data-cleaning-SeIGY

SET GLOBAL local_infile=ON;

CREATE DATABASE IF NOT EXISTS wle;
USE wle;

CREATE TABLE IF NOT EXISTS worldlifeexpectancy (
  `Country` VARCHAR(60),
  `Year` INT,
  `Status` VARCHAR(11),
  `Lifeexpectancy` DOUBLE,
  `AdultMortality` INT,
  `infantdeaths` INT,
  `percentageexpenditure` DOUBLE,
  `Measles` INT,
  `BMI` DOUBLE,
  `under-fivedeaths` INT,
  `Polio` INT,
  `Diphtheria` INT,
  `HIVAIDS` DOUBLE,
  `GDP` INT,
  `thinness1-19years` DOUBLE,
  `thinness5-9years` DOUBLE,
  `Schooling` DOUBLE,
  `Row_ID` INT
);

TRUNCATE worldlifeexpectancy;

-- You may need to change the path to the file depending on where you downloaded it too.
LOAD DATA LOCAL INFILE '/home/barrel/mysql-for-data-analytics/WorldLifeExpectancy.csv'
INTO TABLE worldlifeexpectancy
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT 'Number of Rows in worldlifeexpectancy: ', COUNT(*) FROM worldlifeexpectancy;
SELECT * FROM worldlifeexpectancy LIMIT 5;

-- Clean the data
SELECT 'Begin cleaning the data';
SELECT 'Identify duplicates';

DELIMITER //
CREATE PROCEDURE IF NOT EXISTS view_num_duplicates()
-- views duplicates based on country name and year concatenated
SELECT
    CONCAT(country, year) AS country_year,
    COUNT(*) AS number_of_duplicates
FROM
    worldlifeexpectancy
GROUP BY country_year
HAVING number_of_duplicates > 1;
//
DELIMITER ;

CALL view_num_duplicates();

SELECT 'Remove duplicates';
-- view the duplicates
SELECT *
FROM (
    SELECT
        row_ID,
        CONCAT(Country, Year) AS country_year,
        ROW_NUMBER() OVER (PARTITION BY CONCAT(Country, Year) ORDER BY CONCAT(Country, Year)) AS row_num
    FROM
        worldlifeexpectancy) AS duplicates
WHERE row_num > 1;

-- Remove duplicates
DELETE FROM worldlifeexpectancy
WHERE 
    row_id IN (
    SELECT row_id
FROM (
    SELECT
        row_ID,
        CONCAT(Country, Year),
        ROW_NUMBER() OVER (PARTITION BY CONCAT(Country, Year) ORDER BY CONCAT(Country, Year)) AS row_num
    FROM
        worldlifeexpectancy) AS duplicates
WHERE row_num > 1);

-- Check for duplicates validation

CALL view_num_duplicates();

SELECT 'Check for missing values';

