USE abmysqlda;

CREATE TABLE IF NOT EXISTS bg_player_totals (
    player_name varchar(60) PRIMARY KEY,
    points int
);
TRUNCATE TABLE bg_player_totals;

INSERT INTO bg_player_totals (player_name, points)
    VALUES
        ('Wilt Chamberlain', 	31560),
        ('Shaquille O\'Neal', 	28596),
        ('Moses Malone', 	27409),
        ('Michael Jordan', 	32292),
        ('LeBron James', 	38072),
        ('Kobe Bryant', 	33643),
        ('Karl Malone', 	36928),
        ('Kareem Abdul-Jabbar', 	38387),
        ('Dirk Nowitzki', 	31560),
        ('Carmelo Anthony', 	28289);

DELIMITER //
CREATE PROCEDURE IF NOT EXISTS basketball_greatness()
-- Ranks players by points scored
BEGIN
    SELECT
        player_name,
        points,
        DENSE_RANK() OVER(ORDER BY points DESC) RANKING
    FROM bg_player_totals
    ORDER BY points DESC;
END
//

DELIMITER ;

CALL basketball_greatness();










