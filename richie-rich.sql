USE abmysqlda;

CREATE TABLE IF NOT EXISTS rr_companies (
    company varchar(30),
    `YEAR` date,
    profit int
);

TRUNCATE TABLE rr_companies;

INSERT INTO rr_companies (company, YEAR, profit)
    VALUES
        ('Techastro', '2023-01-05', 4000000),
        ('Techastro', '2022-12-20', 2000000),
        ('Techastro', '2021-05-24', 8000000),
        ('Techastro', '2020-03-26', 5000000),
        ('Techastro', '2019-02-05', 2000000),
        ('Delivery Pros', '2023-03-06', 11000000),
        ('Delivery Pros', '2022-10-22', 2000000),
        ('Delivery Pros', '2021-11-02', 12000000),
        ('Delivery Pros', '2020-09-15', 5000000),
        ('Delivery Pros', '2019-05-12', 5000000),
        ('Wire Tech', '2023-08-04', 4000000),
        ('Wire Tech', '2022-06-06', 2000000),
        ('Wire Tech', '2021-04-22', 6000000),
        ('Wire Tech', '2020-01-23', 2000000),
        ('Wire Tech', '2019-12-16', 3000000);

DELIMITER //
CREATE PROCEDURE IF NOT EXISTS greater_than_20_mil()
-- returns companies with profits greater than 20 million over 2020-2023
BEGIN
SELECT
    company
FROM rr_companies
WHERE TIMESTAMPDIFF(YEAR, `year`, '2023-01-01') < 3
GROUP BY company
HAVING SUM(profit) > 20000000;
END //

DELIMITER ;

CALL greater_than_20_mil();