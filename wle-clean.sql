-- https://www.analystbuilder.com/courses/mysql-for-data-analytics/lesson/world-life-expectancy-data-cleaning-SeIGY

SET GLOBAL local_infile=ON;

USE abmysqlda;

CREATE TABLE IF NOT EXISTS worldlifexpectancy (
  `Country` VARCHAR(60),
  `Year` BIGINT,
  `Status` VARCHAR(11),
  `Lifeexpectancy` DOUBLE,
  `AdultMortality` INT,
  `infantdeaths` INT,
  `percentageexpenditure` DOUBLE,
  `Measles` BIGINT,
  `BMI` DOUBLE,
  `under-fivedeaths` BIGINT,
  `Polio` BIGINT,
  `Diphtheria` BIGINT,
  `HIVAIDS` DOUBLE,
  `GDP` BIGINT,
  `thinness1-19years` DOUBLE,
  `thinness5-9years` DOUBLE,
  `Schooling` DOUBLE,
  `Row_ID` INTO
);