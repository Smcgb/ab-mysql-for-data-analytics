USE wle;
-- --------------------------------------------------------
SELECT 'Most Improved Life Expectancy';
-- --------------------------------------------------------
WITH CTE AS (
    SELECT
        Country,
        Lifeexpectancy,
        `Year`,
        ROW_NUMBER() OVER (PARTITION BY Country ORDER BY `Year`) AS rn_first,
        ROW_NUMBER() OVER (PARTITION BY Country ORDER BY `Year` DESC) AS rn_last
    FROM worldlifeexpectancy
)

SELECT
    first.Country,
    (last.Lifeexpectancy - first.Lifeexpectancy) AS life_expectancy_change,

    ROUND(
            (last.Lifeexpectancy - first.Lifeexpectancy)
                - AVG(last.Lifeexpectancy - first.Lifeexpectancy) OVER (),
            2) AS difference_from_avg,

    ABS(
            (last.Lifeexpectancy - first.Lifeexpectancy)
                - AVG(last.Lifeexpectancy - first.Lifeexpectancy) OVER ())
        / STDDEV(last.Lifeexpectancy - first.Lifeexpectancy) OVER () AS z_score
FROM
    CTE AS first
        JOIN
    CTE AS last ON first.Country = last.Country
WHERE
    first.rn_first = 1 AND last.rn_last = 1
ORDER BY life_expectancy_change DESC;

-- --------------------------------------------------------

SELECT 'Most Declined Life Expectancy';

WITH CTE AS (
    SELECT
        Country,
        Lifeexpectancy,
        `Year`,
        ROW_NUMBER() OVER (PARTITION BY Country ORDER BY `Year`) AS rn_first,
        ROW_NUMBER() OVER (PARTITION BY Country ORDER BY `Year` DESC) AS rn_last
    FROM worldlifeexpectancy
)

SELECT
    first.Country,
    (last.Lifeexpectancy - first.Lifeexpectancy) AS life_expectancy_change,
    ROUND((last.Lifeexpectancy - first.Lifeexpectancy) - AVG(last.Lifeexpectancy - first.Lifeexpectancy) OVER (), 2) AS difference_from_avg,
    ABS((last.Lifeexpectancy - first.Lifeexpectancy) - AVG(last.Lifeexpectancy - first.Lifeexpectancy) OVER ()) / STDDEV(last.Lifeexpectancy - first.Lifeexpectancy) OVER () AS z_score
FROM
    CTE AS first
        JOIN
    CTE AS last ON first.Country = last.Country
WHERE
    first.rn_first = 1 AND last.rn_last = 1
ORDER BY life_expectancy_change
LIMIT 10;

-- --------------------------------------------------------

SELECT 'World Life Expectancy';

SELECT
    wle.`Year`,
    ROUND(AVG(wle.Lifeexpectancy), 2) AS avg_life_expectancy,
    ROUND(AVG(wle.Lifeexpectancy), 2) - ROUND(AVG(t2.Lifeexpectancy), 2) AS avg_le_change
FROM
    worldlifeexpectancy as wle
        LEFT JOIN worldlifeexpectancy AS t2 ON  wle.`Year` = t2.`Year` + 1
GROUP BY `Year`;

-- --------------------------------------------------------

SELECT 'GDP and Life Expectancy Correlation';

CREATE TABLE IF NOT EXISTS gdp_year (
                                        YEAR INT NOT NULL PRIMARY KEY,
                                        GDP FLOAT NOT NULL
);

TRUNCATE TABLE gdp_year;

LOAD DATA LOCAL INFILE 'gdp_year.csv' INTO TABLE gdp_year
    FIELDS TERMINATED BY ','
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS;

SELECT * FROM gdp_year;

-- --------------------------------------------------------

SELECT 'Least Developed Developed and Most Developed Developing Comparison';

WITH least_developed_developed AS (
    SELECT
        Country,
        GDP,
        Status
    FROM worldlifeexpectancy
    WHERE Status = 'Developed'
        AND `Year` = 2022
        AND GDP > 0
    ORDER BY GDP
    LIMIT 1
),

MOST_developed_developing AS (
    SELECT
        Country,
        GDP,
        Status
    FROM worldlifeexpectancy
    WHERE Status = 'Developing'
        AND `Year` = 2022
    ORDER BY GDP DESC
    LIMIT 1
)

SELECT * FROM least_developed_developed
UNION
SELECT * FROM MOST_developed_developing;