-- https://www.analystbuilder.com/courses/mysql-for-data-analytics/question/football-perfection-EcevI
-- Identify the Football teams that scored over 400 points and had 80 or less fouls.

CREATE DATABASE IF NOT EXISTS abmysqlda;

USE abmysqlda;

CREATE TABLE IF NOT EXISTS football (
	team varchar(40) PRIMARY KEY,
	points_scored int,
	penalties int
);

TRUNCATE football;

INSERT INTO football (team, points_scored, penalties) VALUES
	('Arizona Cardinals', 410, 93),
	('Atlanta Falcons', 396, 78),
	('Baltimore Ravens', 468, 88),
	('Buffalo Bills', 501, 88),
	('Carolina Panthers', 350, 84),
	('Chicago Bears', 372, 93),
	('Cincinnati Bengals', 311, 93),
	('Cleveland Browns', 408, 99),
	('Dallas Cowboys', 395, 103),
	('Denver Broncos', 323, 96),
	('Detroit Lions', 377, 90),
	('Green Bay Packers', 509, 76),
	('Houston Texans', 384, 90),
	('Indianapolis Colts', 451, 76),
	('Jacksonville Jaguars', 306, 87),
	('Kansas City Chiefs', 473, 80),
	('Las Vegas Raiders', 434, 96),
	('Los Angeles Chargers', 437, 77),
	('Los Angeles Rams', 372, 97),
	('Miami Dolphins', 404, 81),
	('Minnesota Vikings', 430, 80),
	('New England Patriots', 326, 75),
	('New Orleans Saints', 482, 89),
	('New York Giants', 280, 90),
	('New York Jets', 243, 91),
	('Philadelphia Eagles', 334, 81),
	('Pittsburgh Steelers', 416, 87),
	('San Francisco 49ers', 376, 99),
	('Seattle Seahawks', 459, 96),
	('Tampa Bay Buccaneers', 492, 95),
	('Tennessee Titans', 491, 82),
	('Washington Football Team', 335, 92);


DELIMITER //

CREATE PROCEDURE IF NOT EXISTS footballperfection()
BEGIN
    SELECT team FROM football
    WHERE points_scored > 400 AND penalties <= 80;
END //

DELIMITER ;

CALL footballperfection();
