USE abmysqlda;

CREATE TABLE nf_names (
    first_name varchar(30),
    last_name varchar(30)
);

TRUNCATE TABLE nf_names;

INSERT INTO nf_names (first_name, last_name)
    VALUES
        ('JAMES', 	'JIMOTHY'),
        ('Johnny', 	'Slides'),
        ('sally', 	'smalls'),
        ('ALleN', 	'LisBiTs'),
        ('HairY', 	'StyLes'),
        ('KEVIN', 	'BACON');

DELIMITER //
CREATE PROCEDURE IF NOT EXISTS name_format()
-- returns names in proper format
BEGIN
    SELECT
        CONCAT(
                UCASE(SUBSTRING(first_name, 1,1)),
                LOWER(SUBSTRING(first_name, 2)),
                ' ',
                UCASE(SUBSTRING(last_name, 1,1)),
                LOWER(SUBSTRING(last_name, 2))
        ) AS proper_name
    FROM nf_names
    ORDER BY proper_name;
END //

DELIMITER ;

CALL name_format();07