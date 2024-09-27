USE abmysqlda;

CREATE TABLE IF NOT EXISTS youtube_videos (
    video_id INT PRIMARY KEY,
    thumps_up INT,
    thumps_down INT
);

TRUNCATE TABLE youtube_videos;

INSERT INTO youtube_videos (video_id, thumps_up, thumps_down)
VALUES
    (1, 2980, 2366),
    (2, 895, 6289),
    (3, 8366, 5714),
    (4, 5601, 1378),
    (5, 861, 523),
    (6, 1165, 494),
    (7, 2346, 1376),
    (8, 911, 651),
    (9, 1920, 6635),
    (10, 6073, 8403),
    (11, 2863, 5647),
    (12, 6167, 1219),
    (13, 1316, 5129),
    (14, 2782, 7663),
    (15, 5429, 4627);

DELIMITER //
CREATE PROCEDURE IF NOT EXISTS get_low_quality_videos()
BEGIN
    SELECT
        video_id
FROM youtube_videos
WHERE (thumps_up / (thumps_up + thumps_down)) < 0.55
ORDER BY video_id;
END //

DELIMITER ;

CALL get_low_quality_videos();