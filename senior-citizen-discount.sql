USE abmysqlda;

CREATE TABLE IF NOT EXISTS cs_customers (
    customer_id varchar(15),
    birth_date date
);

TRUNCATE TABLE cs_customers;

INSERT INTO cs_customers (customer_id, birth_date)
VALUES
    ('YVD4753692', '1989-03-25'),
    ('XBJ9334631', '1964-06-12'),
    ('CKT7420478', '1974-08-26'),
    ('NRD6336031', '1972-07-23'),
    ('RHY0461182', '1951-09-07'),
    ('UJL8594627', '1957-10-10'),
    ('PLM3202827', '1941-06-18'),
    ('YKL0784996', '1984-09-07'),
    ('WIC7447772', '1942-12-14'),
    ('JWV2386381', '1999-05-23'),
    ('KMA9421058', '2013-04-27'),
    ('GNI7686157', '1977-07-12'),
    ('ZUK8218129', '1971-10-11'),
    ('VNX4490181', '1952-02-14'),
    ('UPB1934369', '1968-02-08'),
    ('MFL8555017', '1997-05-22'),
    ('JYQ0229312', '1986-08-25'),
    ('WCB0774269', '1983-06-26'),
    ('FHX9457768', '2012-01-13'),
    ('QKP2926677', '1992-07-24');

DELIMITER //
CREATE PROCEDURE IF NOT EXISTS senior_citizen_discount()
-- returns customers who are senior citizens
BEGIN
    SELECT customer_id
    FROM cs_customers
    WHERE TIMESTAMPDIFF(YEAR, birth_date, '2023-01-01') >= 55
    ORDER BY customer_id;
END //

DELIMITER ;

CALL senior_citizen_discount();