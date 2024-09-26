CREATE DATABASE IF NOT EXISTS abmysqlda;
USE abmysqlda;

CREATE TABLE if not exists country (
    `rank` int PRIMARY KEY,
    country varchar(40),
    gdp_in_millions int,
    population int,
    world_gdp_percentage decimal(5,2)
);

TRUNCATE country;

DELIMITER //

INSERT INTO country (`rank`, country, gdp_in_millions, population, world_gdp_percentage) VALUES
                                                                                             (1, "United States", 	        19485394, 	325084756, 	   24.08),
                                                                                             (2, "China", 	                12237700, 	1421021791,    15.12),
                                                                                             (3, "Japan", 	                4872415, 	127502725, 	    6.02),
                                                                                             (4, "Germany", 	                3693204, 	82658409, 	    4.56),
                                                                                             (5, "India", 	                2650725, 	1338676785, 	3.28),
                                                                                             (6, "United Kingdom", 	        2637866, 	66727461, 	    3.26),
                                                                                             (7, "France", 	                2582501, 	64842509, 	    3.19),
                                                                                             (8, "Brazil", 	                2053595, 	207833823, 	    2.54),
                                                                                             (9, "Italy", 	                1943835, 	60673701, 	    2.40),
                                                                                             (10, "Canada", 	                1647120, 	36732095, 	    2.04),
                                                                                             (11, "Russia", 	                1578417, 	145530082, 	    1.95),
                                                                                             (12, "South Korea", 	        1530751, 	51096415, 	    1.89),
                                                                                             (13, "Australia", 	            1323421, 	24584620, 	    1.64),
                                                                                             (14, "Spain", 	                1314314, 	46647428, 	    1.62),
                                                                                             (15, "Mexico", 	                1150888, 	124777324, 	    1.42),
                                                                                             (16, "Indonesia", 	            1015421, 	264650963, 	    1.25),
                                                                                             (17, "Turkey", 	                851549, 	81116450, 	    1.05),
                                                                                             (18, "Netherlands", 	        830573,     17021347, 	    1.03),
                                                                                             (19, "Saudi Arabia", 	        686738,     33101179, 	    0.85),
                                                                                             (20, "Switzerland", 	        678965,     8455804, 	    0.84),
                                                                                             (21, "Argentina", 	            637430,     43937140, 	    0.79),
                                                                                             (22, "Sweden", 	                535607,     9904896, 	    0.66),
                                                                                             (23, "Poland", 	                526466,     37953180, 	    0.65),
                                                                                             (24, "Belgium", 	            494764,     11419748, 	    0.61),
                                                                                             (25, "Thailand", 	            455303,     69209810, 	    0.56),
                                                                                             (26, "Iran", 	                454013,     80673883, 	    0.56),
                                                                                             (27, "Austria", 	            416836,     8819901, 	    0.52),
                                                                                             (28, "Norway", 	                399489,     5296326, 	    0.49),
                                                                                             (29, "United Arab Emirates", 	382575,     9487203, 	    0.47),
                                                                                             (30, "Nigeria", 	            375745,     190873244, 	    0.46),
                                                                                             (31, "Israel", 	                353268,     8243848, 	    0.44),
                                                                                             (32, "South Africa", 	        348872,     57009756, 	    0.43),
                                                                                             (33, "Hong Kong", 	            341449,     7306322, 	    0.42),
                                                                                             (34, "Ireland", 	            331430,     4753279, 	    0.41),
                                                                                             (35, "Denmark", 	            329866,     5732274, 	    0.41),
                                                                                             (36, "Singapore", 	            323907,     5708041, 	    0.40),
                                                                                             (37, "Malaysia", 	            314710,     31104646, 	    0.39),
                                                                                             (38, "Colombia", 	            314458,     48909839, 	    0.39),
                                                                                             (39, "Philippines", 	        313595,     105172925, 	    0.39),
                                                                                             (40, "Pakistan", 	            304952,     207906209, 	    0.38),
                                                                                             (41, "Chile", 	                277076,     18470439, 	    0.34),
                                                                                             (42, "Finland", 	            252302,     5511371, 	    0.31),
                                                                                             (43, "Bangladesh", 	            249724,     159685424, 	    0.31),
                                                                                             (44, "Egypt", 	                235369,     96442591, 	    0.29),
                                                                                             (45, "Vietnam", 	            223780,     94600648, 	    0.28),
                                                                                             (46, "Portugal", 	            219308,     10288527, 	    0.27),
                                                                                             (47, "Czechia", 	            215914,     10641034, 	    0.27),
                                                                                             (48, "Romania", 	            211884,     19653969, 	    0.26),
                                                                                             (49, "Peru", 	                211389,     31444298, 	    0.26),
                                                                                             (50, "New Zealand", 	        204139,     4702034,	    0.25),
                                                                                             (51, "Greece", 	                203086,     10569450, 	    0.25),
                                                                                             (52, "Iraq", 	                192061,     37552781, 	    0.24),
                                                                                             (53, "Algeria",                 167555,     41389189,       0.21);

    CREATE PROCEDURE IF NOT EXISTS CAFRIT()
    -- Selects columns related to Canada, France, and Italy on this table
    BEGIN
        SELECT * FROM country
          WHERE country IN ('Canada', 'France', 'Italy')
        ORDER BY country.country;
    END //

DELIMITER ;

CALL CAFRIT();