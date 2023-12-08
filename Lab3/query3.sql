SELECT * FROM countries;

SELECT name, MAX(area) FROM countries;

SELECT name, MAX(population) FROM countries
WHERE region LIKE "Africa";

SELECT SUM(gdp) FROM countries
WHERE region LIKE "Europe";

SELECT name, population FROM countries
WHERE gdp IS NULL; 
-- very important 
SELECT name, population FROM countries
WHERE gdp IS NOT NULL; 

SELECT region, AVG(gdp) FROM countries
GROUP BY region;

SELECT name FROM countries
WHERE name LIKE '%'||region||'%';

SELECT region, MIN(gdp), MAX(gdp)
FROM countries
GROUP BY region;

SELECT region, count(name), sum(population)
FROM countries
WHERE region IN ('Europe', 'Africa', 'Middle East')
GROUP BY region;

SELECT SUM(area), SUM(population), SUM(gdp)
FROM countries
WHERE name IN ('Spain', 'France', 'Germany');
-- use this the next time

SELECT region, count(name)
FROM countries
WHERE population > 100000000
GROUP BY region;

SELECT substring(name, 1, 1), count(*), min(name), max(name) 
FROM countries
GROUP BY substring(name, 1, 1);
-- query 12 is awful 
-- SUBSTRING: This is a SQL function used to extract a substring (a portion of a string) from a given string.
-- 1: The second argument (in this case, 1) specifies the position in the string from which you want to start extracting the substring. In SQL, positions are typically counted from 1, so starting at position 1 means starting at the very beginning of the string.
-- 1: The third argument (in this case, 1) specifies the length of the substring you want to extract. Since it's set to 1, it means you want to extract only one character from the specified position.

SELECT name, region FROM countries
ORDER BY region ASC, name ASC, population DESC;

SELECT region, COUNT(*), SUM(population), SUM(area) / SUM(population) AS population_density
FROM countries
GROUP BY region
HAVING SUM(population) > 1000000000;
-- 14 why does is give me 0 for density???

-- there is more to this labsheet come back to it

-- 18 
SELECT c.name AS country_name, c.region, c.area
FROM countries AS c
WHERE c.area >= 0.1 * (
    SELECT SUM(area)
    FROM countries AS c2
    WHERE c2.region = c.region
);
