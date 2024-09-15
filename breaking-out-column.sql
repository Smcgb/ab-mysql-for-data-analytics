-- https://www.analystbuilder.com/courses/mysql-for-data-analytics/question/breaking-out-column-vGogi
-- The addresses in this table are in a very strange format. We actually need them broken out into street address, city, state, and zip code, but currently it's pretty unusable.
-- Write a query to break out this column into street, city, state, and zip_code with those names exactly.

CREATE DATABASE IF NOT EXISTS abmysqlda;
USE abmysqlda;

CREATE TABLE IF NOT EXISTS breakout_addresses (
    address VARCHAR(100)
);

TRUNCATE breakout_addresses;

INSERT INTO breakout_addresses
    VALUES
      ('123 Main St- Anytown- CA- 12345'),
      ('456 Elm St- Springfield- IL- 67890'),
      ('789 Oak Ave- Newtown- PA- 23456'),
      ('1010 Maple Dr- Greensboro- NC- 34567'),
      ('1313 Pine St- Seattle- WA- 45678');

DELIMITER //

CREATE PROCEDURE IF NOT EXISTS breakout_addresses_proc()
BEGIN
    SELECT
      SUBSTRING_INDEX(address, "-", 1) AS street,
      SUBSTRING_INDEX(SUBSTRING_INDEX(address, "-", 2), "-", -1) AS city,
      SUBSTRING_INDEX(SUBSTRING_INDEX(address, "-", -2), "-", 1) AS state,
      SUBSTRING_INDEX(address, "-", -1) AS zip_code
    FROM breakout_addresses;
END //

DELIMITER ;

CALL breakout_addresses_proc();