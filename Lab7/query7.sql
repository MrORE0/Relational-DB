-- cities(id, name, country_code, district, population)
-- countries (code, name, continent, region, surface_area, indep_year, 
--      population, life_expectancy, gnp, gnp_old, local_name, government_form, head_of_state, capital, code2)
-- country_languages(country_code, language, is_official, percentage)


-- 1. List the twenty most populous cities in the world. (MySQL’s LIMIT feature may prove handy here.)
SELECT name, population FROM cities
ORDER BY name DESC
LIMIT 20;

-- 2. List the countries that have at least five cities with a population of one million or more. 
-- List the country’s name and the number of such cities.
SELECT countries.name AS country_name, COUNT(cities.id) AS num_cities_with_population
FROM countries
JOIN cities ON countries.code = cities.country_code
WHERE cities.population >= 1000000
GROUP BY countries.code, countries.name
HAVING num_cities_with_population >= 5;

-- 3. List all the countries which achieve independence since India did.
SELECT name FROM countries AS c1
WHERE c1.indep_year > (SELECT indep_year FROM countries WHERE name = 'India');

-- 4. List those languages that are spoken by a significant proportion of the population of at least six countries. 
-- (We take 25% or more to be “significant”.)
SELECT language FROM country_languages
WHERE percentage > 25
GROUP BY language 
HAVING count(DISTINCT country_code)>6;

-- 5. List the names of all countries that are both among the twenty poorest (lowest GNP per capita) and 
-- among the twenty with the lowest life expectancy. 
-- Note: take care to filter out countries whose life expectancy, population or GNP is unknown.
SELECT name FROM countries 
WHERE code IN(
    SELECT code FROM countries 
    WHERE life_expectancy IS NOT NULL
    ORDER BY life_expectancy ASC
    LIMIT 20
    )
    AND code IN (
    SELECT code FROM countries
    WHERE gnp/population IS NOT NULL
    ORDER BY gnp/population ASC
    LIMIT 20
    )
;

-- 6. List all the countries that comprise a ”significant” portion (at least 10% )
--  of the total surface area of the continent to which they belong. 
--  As a warm up, first do this for a specific continent (say South America). 
--  You may find the notion of a correlated subquery useful here (look it up).
SELECT name FROM countries
WHERE region = 'South America'
AND surface_area  > 0.1 * (SELECT sum(surface_area) FROM countries WHERE region = 'South America');

SELECT DISTINCT c1.name FROM countries AS c1
JOIN countries AS c2 ON c1.region = c2.region
WHERE c1.surface_area > 0.1 * (SELECT sum(surface_area) FROM countries WHERE region = c2.region AND surface_area IS NOT NULL);

-- 7. Calculate what proportion of the world’s total GNP belongs to the 20 richest (by GNP) countries.

-- GPT answer 
SELECT SUM(c1.gnp) / (SELECT SUM(gnp) FROM countries) AS proportion
FROM countries c1
ORDER BY gnp DESC
LIMIT 20;

-- 8. Determine the head of state with the greatest amount of territory (by surface area).
SELECT head_of_state FROM countries 
WHERE surface_area = (SELECT MAX(surface_area) FROM countries);

-- 9. List for each continent, the name of the country with the greatest and smallest population.
SELECT c1.continent, c1.name AS greatest_population, c2.name AS smallest_population
FROM countries AS c1
 
JOIN countries AS c2 ON c1.continent = c2.continent
WHERE c1.population = (SELECT MAX(population) FROM countries AS c3 WHERE c3.continent = c1.continent)
OR c2.population = (SELECT MIN(population) FROM countries AS c4 WHERE c4.continent = c2.continent)
GROUP by continent;
-- doesn't work for some reason

-- 10. For each country in Europe list the percentage of its population that live in its most populous city.

-- GPT response
SELECT 
    c1.name AS country_name,
    c1.population AS total_population,
    c2.name AS most_populous_city,
    c2.population AS city_population,
    (c2.population / c1.population) * 100 AS percentage_population_in_most_populous_city
FROM 
    countries AS c1
JOIN 
    cities AS c2 ON c1.code = c2.country_code
WHERE 
    c1.continent = 'Europe'
    AND c2.population = (SELECT MAX(population) FROM cities WHERE country_code = c1.code)
ORDER BY 
    country_name;


-- 11. List in descending order of population all countries in which none of the following
-- languages are spoken by a significant proportion of the population: English, Spanish,
-- Chinese, Arabic or Hindi
SELECT c1.name, cl.language 
FROM countries as c1
JOIN country_languages as cl ON c1.code = cl.country_code
WHERE cl.language IN ('English', 'Spanish', 'Chinese', 'Arabic', 'Hindi')
ORDER BY c1.population DESC;
