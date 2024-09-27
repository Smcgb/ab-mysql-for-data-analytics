CREATE DATABASE IF NOT EXISTS ushh;

USE ushh;

CREATE TABLE IF NOT EXISTS USHouseholdIncome(
    row_id     INTEGER  NOT NULL Primary KEY
    ,id           INTEGER  NOT NULL
    ,State_Code INTEGER  NOT NULL
    ,State_Name VARCHAR(20) NOT NULL
    ,State_ab   VARCHAR(2) NOT NULL
    ,County       VARCHAR(33) NOT NULL
    ,City         VARCHAR(22) NOT NULL
    ,Place        VARCHAR(36)
    ,`Type`         VARCHAR(12) NOT NULL
    ,`Primary`    VARCHAR(5) NOT NULL
    ,Zip_Code   INTEGER  NOT NULL
    ,Area_Code  VARCHAR(3) NOT NULL
    ,ALand        BIGINT  NOT NULL
    ,AWater       BIGINT  NOT NULL
    ,Lat          NUMERIC(10,7) NOT NULL
    ,Lon          NUMERIC(12,7) NOT NULL
);

TRUNCATE TABLE USHouseholdIncome;

LOAD DATA LOCAL INFILE 'home/barrel/mysql-for-data-analytics/USHouseholdIncome.csv'
INTO TABLE USHouseholdIncome
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT 'Number of Rows in USHouseholdIncome: ', COUNT(*) FROM USHouseholdIncome;
SELECT * FROM USHouseholdIncome LIMIT 5;