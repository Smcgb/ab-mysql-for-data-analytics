-- https://www.analystbuilder.com/courses/mysql-for-data-analytics/lesson/world-life-expectancy-data-cleaning-SeIGY
CREATE DATABASE IF NOT EXISTS wle;
USE wle;

CREATE TABLE IF NOT EXISTS worldlifeexpectancy (
  `Country` VARCHAR(60),
  `Year` INT,
  `Status` VARCHAR(11),
  `Lifeexpectancy` TEXT,
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

-- Clean countries that only have a single entry
SELECT 'Countries with a single entry';
SELECT
    Country,
    COUNT(*) AS number_of_rows
FROM
    worldlifeexpectancy
GROUP BY Country;

DELETE FROM worldlifeexpectancy
WHERE Country IN (
    SELECT Country
    FROM (
        SELECT
            Country,
            COUNT(*) AS number_of_rows
        FROM
            worldlifeexpectancy
        GROUP BY Country) AS countries_with_limited_data
    WHERE number_of_rows < 2);

-- Clean the data
SELECT 'Begin cleaning the data';

-- identify countries with limited data and drop them if they have a single row

SELECT
    Country,
    COUNT(*) AS number_of_rows
FROM
    worldlifeexpectancy
GROUP BY Country
HAVING number_of_rows < 2;

DELETE FROM worldlifeexpectancy
WHERE Country IN (
    SELECT Country
    FROM (
        SELECT
            Country,
            COUNT(*) AS number_of_rows
        FROM
            worldlifeexpectancy
        GROUP BY Country
        HAVING number_of_rows < 2) AS countries_with_limited_data);

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

-- List missing values
SELECT
    (SELECT COUNT(*) FROM worldlifeexpectancy WHERE Status IS NULL OR Status = '') AS Status_nulls,
    (SELECT COUNT(*) FROM worldlifeexpectancy WHERE Lifeexpectancy IS NULL OR Lifeexpectancy = '') AS Lifeexpectancy_nulls,
    (SELECT COUNT(*) FROM worldlifeexpectancy WHERE AdultMortality IS NULL OR AdultMortality = '') AS AdultMortality_nulls,
    (SELECT COUNT(*) FROM worldlifeexpectancy WHERE infantdeaths IS NULL OR infantdeaths = '') AS infantdeaths_nulls,
    (SELECT COUNT(*) FROM worldlifeexpectancy WHERE percentageexpenditure IS NULL OR percentageexpenditure = '') AS percentageexpenditure_nulls,
    (SELECT COUNT(*) FROM worldlifeexpectancy WHERE Measles IS NULL OR Measles = '') AS Measles_nulls,
    (SELECT COUNT(*) FROM worldlifeexpectancy WHERE BMI IS NULL OR BMI = '') AS BMI_nulls,
    (SELECT COUNT(*) FROM worldlifeexpectancy WHERE `under-fivedeaths` IS NULL OR `under-fivedeaths` = '') AS under_fivedeaths_nulls,
    (SELECT COUNT(*) FROM worldlifeexpectancy WHERE Polio IS NULL OR Polio = '') AS Polio_nulls,
    (SELECT COUNT(*) FROM worldlifeexpectancy WHERE Diphtheria IS NULL OR Diphtheria = '') AS Diphtheria_nulls,
    (SELECT COUNT(*) FROM worldlifeexpectancy WHERE HIVAIDS IS NULL OR HIVAIDS = '') AS HIVAIDS_nulls,
    (SELECT COUNT(*) FROM worldlifeexpectancy WHERE GDP IS NULL OR GDP = '') AS GDP_nulls,
    (SELECT COUNT(*) FROM worldlifeexpectancy WHERE `thinness1-19years` IS NULL OR `thinness1-19years` = '') AS thinness1_19years_nulls,
    (SELECT COUNT(*) FROM worldlifeexpectancy WHERE `thinness5-9years` IS NULL OR `thinness5-9years` = '') AS thinness5_9years_nulls,
    (SELECT COUNT(*) FROM worldlifeexpectancy WHERE Schooling IS NULL OR Schooling = '') AS Schooling_nulls;

SELECT 'Check for missing values in Status';

SELECT * FROM worldlifeexpectancy
    WHERE status = '';

-- My preferred cleaning method over the video walkthrough
-- as it allows for changes over time to be used. This should be more
-- future-proof.
WITH filled_status_table AS
         (SELECT Country,
                 Year,
                 COALESCE(
                         NULLIF(status, ''), -- Treat empty strings as NULL
                         LAG(NULLIF(status, '')) OVER (PARTITION BY country ORDER BY year), -- Previous non-empty status
                         LEAD(NULLIF(status, '')) OVER (PARTITION BY country ORDER BY year) -- Next non-empty status
                 ) AS filled_status
          FROM worldlifeexpectancy
         )

UPDATE worldlifeexpectancy
    JOIN filled_status_table
    ON worldlifeexpectancy.country = filled_status_table.country
        AND worldlifeexpectancy.year = filled_status_table.year
SET worldlifeexpectancy.status = filled_status_table.filled_status
WHERE worldlifeexpectancy.status = '';

SELECT 'Validating Clean, there should be no results under this query';

SELECT count(*) FROM worldlifeexpectancy
WHERE status = '';

with t1 as (SELECT
                wle.Country,
                wle.`Year`,
                wle.`Lifeexpectancy`,
                ROUND(
                        (LAG(`Lifeexpectancy`, 1)
                             OVER (PARTITION BY Country ORDER BY `Year`)
                            +
                         LEAD(`Lifeexpectancy`, 1)
                              OVER (PARTITION BY Country ORDER BY `Year`)
                            ) / 2, 1) AS `Lifeexpectancy_avg`
            FROM worldlifeexpectancy as wle)

UPDATE worldlifeexpectancy AS wle
    JOIN t1 ON wle.Country = t1.Country AND wle.`Year` = t1.`Year`
SET wle.`Lifeexpectancy` = t1.`Lifeexpectancy_avg`
WHERE wle.`Lifeexpectancy` = ''
  AND wle.Country IN (SELECT Country FROM t1 GROUP BY Country HAVING COUNT(*) > 1);

SELECT
    Country,
    Year,
    Lifeexpectancy
FROM worldlifeexpectancy
WHERE Country IN ('Afghanistan', 'Albania');

SELECT 'Imputing GDP, Missing values imputed with the average GDP of the country';

WITH filled_gdp_table AS
         (SELECT Country,
                    Year,
                 AVG(GDP) OVER (PARTITION BY Country) AS filled_gdp
          FROM worldlifeexpectancy
         )

UPDATE worldlifeexpectancy
    JOIN filled_gdp_table
    ON worldlifeexpectancy.country = filled_gdp_table.country
        AND worldlifeexpectancy.year = filled_gdp_table.year
SET worldlifeexpectancy.GDP = filled_gdp_table.filled_gdp
WHERE worldlifeexpectancy.GDP = '';

SELECT 'Updating GDP, some countries havve erroneous GDP values';

UPDATE worldlifeexpectancy
SET GDP = CASE
              WHEN GDP < 10000 THEN GDP * (10000 / GDP)
              ELSE GDP
    END
WHERE Status = 'Developed'
  AND GDP > 0;



