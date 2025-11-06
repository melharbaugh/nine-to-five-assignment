--datatype foe women employees
SELECT *
FROM datatype
WHERE data_type_text LIKE '%Women%'

SELECT *
FROM series
WHERE data_type_code = 10

--series code for women in comercial banking
SELECT *
FROM industry
WHERE industry_name = 'commercial banking'

SELECT *
FROM series
WHERE supersector_code = 55 AND data_type_code = 10 AND industry_code = 55522110

--all industry employees in 2016
SELECT SUM (value) as TotalEmployees
FROM annual_2016

select *
from annual_2016

SELECT *
FROM datatype

--all women employees in all industries in 2016

SELECT series_id
FROM series
WHERE data_type_code = 10

SELECT COUNT(id) AS TotalEmployees
FROM annual_2016

SELECT *
FROM annual_2016

SELECT SUM(value) AS TotalWomenEmp2016
FROM annual_2016
WHERE series_id LIKE '%10'

--production/nonsupervisory employees in 2016
SELECT *
FROM series

SELECT *
FROM series
WHERE series_title = 'Production and nonsupervisory employees'

SELECT SUM([value]) As TotalProdAndNsEmp
FROM annual_2016
WHERE series_id LIKE '%06'

--average weekly hours by production and nonsupervisory employees in Jan 2017
SELECT *
FROM series
WHERE series_title = 'Average weekly hours of production and nonsupervisory employees'

SELECT AVG(value) AS AvgWeeklyHours
FROM january_2017
WHERE series_id LIKE '%07'

--total weekly payroll
SELECT *
FROM january_2017

SELECT *
FROM series
WHERE series_title LIKE '%production%'

SELECT *
FROM series
WHERE series_title = 'average weekly earnings of production and nonsupervisory employees'

SELECT SUM(value) AS TotalPayroll
FROM january_2017
WHERE series_id LIKE '%30' 
    OR series_id LIKE '%31'

--industry with most avg weekly hours and industry with least avg weekly hours
SELECT *
FROM series
WHERE series_title LIKE '%production and nonsupervisory employees%'

SELECT *
FROM series
WHERE series_title = 'Average weekly hours of production and nonsupervisory employees'

SELECT *
FROM january_2017
WHERE series_id LIKE '%07'
ORDER BY [value] DESC

SELECT *
FROM industry
WHERE industry_code = 31336350

SELECT *
FROM january_2017
WHERE series_id LIKE '%07'
ORDER BY [value]

SELECT *
FROM industry
WHERE industry_code = 70713940

--which industry had highest and lowest total weekly payroll
SELECT *
FROM series
WHERE series_title = 'Average weekly earnings of production and nonsupervisory employees'

SELECT TOP 1 *
FROM january_2017
WHERE series_id LIKE '%30'
    OR series_id LIKE '%31'
ORDER BY [value] DESC

SELECT *
FROM industry
WHERE industry_code = 55524130

SELECT TOP 1 *
FROM january_2017
WHERE series_id LIKE '%30'
    OR series_id LIKE '%31'
ORDER BY [value]

SELECT *
FROM industry
WHERE industry_code = 70713950

--joining annual_2016 and series on series_id, only annual_2016 data
SELECT TOP 50 *
FROM annual_2016 AS a  
    LEFT JOIN series AS s
    ON a.series_id = s.series_id
ORDER BY id

--joining series and datatype on data_type_code
SELECT TOP 50 *
FROM series AS s  
    JOIN datatype AS d  
    ON s.data_type_code = d.data_type_code
ORDER BY series_id

--join series and industry on industry_code
SELECT TOP 50 *
FROM series AS s  
    JOIN industry AS i    
    ON s.industry_code = i.industry_code
ORDER BY series_id

/* return series_id, industry code, industry name and value from 2017 *if* value is 
greater than avg value for data type code 82 in 2016 */

--query to find Avg value for data type 82 in 2016
--join series and annual 2016 on series_id
SELECT AVG(a.[value]) AS avg2016
FROM annual_2016 AS a   
    JOIN series AS s   
    ON a.series_id = s.series_id
    WHERE s.data_type_code = '82'

--query to return results from Jan 2017
--join series and jan 2017 on series id
--join series and industry on industry code
SELECT j.series_id, s.industry_code, i.industry_name, j.value
FROM january_2017 AS j   
JOIN series AS s ON s.series_id = j.series_id
JOIN industry AS i ON s.industry_code = i.industry_code

--combine using CTE
WITH avg2016 AS (
    SELECT AVG(a.value) AS avgValue
    FROM annual_2016 AS a    
    JOIN series AS s  
    ON a.series_id = s.series_id
    WHERE s.data_type_code = '82'
)
SELECT j.series_id, s.industry_code, i.industry_name, j.value
FROM january_2017 AS j   
JOIN series AS s 
    ON s.series_id = j.series_id
JOIN industry AS i 
    ON s.industry_code = i.industry_code
CROSS JOIN avg2016 AS a   
WHERE j.value > a.avgValue

--not using CTE
SELECT j.series_id, s.industry_code, i.industry_name, j.value
FROM january_2017 AS j   
JOIN series AS s ON s.series_id = j.series_id
JOIN industry AS i ON s.industry_code = i.industry_code
WHERE j.value > (
    SELECT AVG(a.value)
    FROM annual_2016 AS a
    JOIN series AS se   
    ON a.series_id = se.series_id
    WHERE se.data_type_code = 82
)
ORDER BY value DESC

--union
SELECT a.value, a.year, a.period 
FROM annual_2016 AS a    
JOIN series AS s
    ON a.series_id = s.series_id
WHERE s.data_type_code = '30'

UNION

SELECT j.value, j.year, j.period   
FROM january_2017 AS j    
JOIN series AS s2
    ON j.series_id = s2.series_id
WHERE s2.data_type_code = '30'

SELECT AVG(value) AS avg
FROM january_2017
WHERE series_id LIKE '%30' 
    OR series_id LIKE '%31'

SELECT COUNT(id)
FROM january_2017
WHERE value > 527.58 
    AND series_id LIKE '%31'
    OR series_id LIKE '%30'

SELECT j.series_id, s.industry_code, i.industry_name, j.value
FROM january_2017 AS j   
    JOIN series AS s 
    ON s.series_id = j.series_id
    JOIN industry AS i 
    ON s.industry_code = i.industry_code
ORDER BY j.value DESC

SELECT a.series_id, s.industry_code, i.industry_name, a.value
FROM annual_2016 AS a   
    JOIN series AS s 
    ON s.series_id = a.series_id
    JOIN industry AS i 
    ON s.industry_code = i.industry_code
ORDER BY a.value DESC
