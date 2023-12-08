-- countries(name, region, area, population, gdp)

-- 1. What is the greatest area of any country?
SELECT MAX(area) AS The_Greatest_Are FROM countries;

-- 2. What is the largest population of any country in Africa?
SELECT MAX(population) FROM countries
WHERE region = 'Africa';

-- 3. What is the total GDP of Europe?
SELECT SUM(gdp) FROM countries
WHERE region = 'Europe';

-- 4. List the names and populations of all countries whose GDP is not known (NULL).
SELECT name FROM countries
WHERE gdp IS NULL;
-- watch out for words is known not null
-- 5. List the names and GDPs of all countries for which a GDP is known.
SELECT name FROM countries
WHERE gdp IS NULL;

-- 6. List the name and average GDP of each region.
SELECT region, AVG(gdp) FROM countries
GROUP BY region;

-- 7. List all the countries whose name contains the region name as a substring.
SELECT name FROM countries
WHERE name LIKE '%'||region||'%';
-- gadnoooooooooo!!!!!!

-- 8. List the minimum and maximum per capita GDP for each region.
SELECT region, MIN(gdp / population) AS min_per_capita_gdp, MAX(gdp / population) AS max_per_capita_gdp
FROM countries
GROUP BY region;

-- 9. List the number of countries and total population for each of the following regions:
-- Europe, Africa and the Middle East.
SELECT name, population FROM countries
WHERE region IN ('Europe', 'Africa' 'Middle East');
