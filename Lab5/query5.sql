-- movies(id, title, yr, score, votes, director)
-- actors(id, name)
-- castings(movieid, actorid)

-- 1. Determine how many films and how many actors are represented in the DB
SELECT count(*),
(SELECT count(*) FROM actors)
FROM movies;

-- 2. Determine how many films were released in 1975?
SELECT count(*) FROM (
SELECT title FROM movies
WHERE yr LIKE '1975');

-- 3. List the ids of all films in which Clint Eastwood appears.
SELECT movieid FROM castings
WHERE actorid LIKE(
SELECT id FROM actors
WHERE name LIKE 'Clint Eastwood');

-- 4. List the names and years of all films in which Clint Eastwood appears. Order the films chronologically.
SELECT movies.title, movies.yr FROM movies
JOIN castings ON castings.movieid = movies.id
JOIN actors ON castings.actorid = actors.id
WHERE actors.name LIKE 'Clint Eastwood'
ORDER BY yr;

-- 5. List all the actors who appeared in “Citizen Kane”. 
-- use IN so you can use the whole column instead of one value
SELECT name FROM actors
WHERE id IN ( 
    SELECT actorid FROM castings
    WHERE movieid LIKE (
        SELECT id FROM movies
        WHERE title LIKE 'Citizen Kane'));


-- 6. List all the actors who appeared in either “Vertigo” or “Rear Window”.
SELECT name FROM actors
WHERE id IN ( 
    SELECT actorid FROM castings
    WHERE movieid IN (
        SELECT id FROM movies
        WHERE title LIKE 'Vertigo' OR title LIKE 'Rear Window')
        );

-- 7. List all the films made by the director with id number 28.
SELECT title FROM movies
WHERE director LIKE '28';

-- 8. List all the films made by the director of “Godfather, The”.
SELECT title FROM movies
WHERE director =(
    SELECT director FROM movies
    WHERE title = 'Godfather, The');

-- 9. List all remakes, i.e. pairs of films with the same name; give the name and the year in each case.
SELECT
    m1.title AS original_title,
    m1.yr AS original_year,
    m2.title AS remake_title,
    m2.yr AS remake_year
FROM
    movies AS m1
JOIN
    movies AS m2
ON
    m1.title = m2.title
WHERE
    m1.yr < m2.yr;

-- 10. List the names all obvious sequels with names like “Superman II”
-- ( Consider only the first four sequels i.e. II to V).
SELECT title
FROM movies
WHERE title LIKE '% II'
OR title LIKE '% III'
OR title LIKE '% IV'
OR title LIKE '% V'; 

-- 11. List all film-sequel pairs where the sequel has the same name of the original with the
-- Roman numeral II appended. (Hint: SQLite uses the concatenation operator || to join
-- strings together, so "Superman" || " II" = "Superman II".)
SELECT
    original.title AS original_title,
    sequel.title AS sequel_title
FROM
    movies AS original
JOIN
    movies AS sequel
ON
    original.title || ' II' = sequel.title
WHERE
    original.title != sequel.title;


-- 12. List all pairs of films by the same director where one film received a good score (> 8)
-- and another a poor score (< 3).
SELECT
    f1.title AS film1,
    f2.title AS film2,
    f1.director,
    f1.score AS film1_score,
    f2.score AS film2_score
FROM
    movies AS f1
JOIN
    movies AS f2
ON
    f1.director = f2.director
WHERE
    f1.score > 8
    AND f2.score < 3
    AND f1.id < f2.id;


-- 13. List all the films in which both Clint Eastwood and Richard Burton appeared.
-- we join them twice so we can get the result from one and then another and then get only the intersection of these
SELECT m.title AS film_title
FROM movies AS m
JOIN castings AS c1 ON m.id = c1.movieid
JOIN actors AS a1 ON c1.actorid = a1.id
JOIN castings AS c2 ON m.id = c2.movieid
JOIN actors AS a2 ON c2.actorid = a2.id
WHERE a1.name = 'Clint Eastwood'
  AND a2.name = 'Richard Burton';
 
--  OR you can use intersect
SELECT m.title AS film_title
FROM movies AS m 
JOIN castings AS c ON m.id = c.movieid
JOIN actors as a ON a.id = c.actorid
WHERE a.name = 'Clint Eastwood'
INTERSECT
SELECT m.title AS film_title
FROM movies AS m 
JOIN castings AS c ON m.id = c.movieid
JOIN actors as a ON a.id = c.actorid
WHERE a.name = 'Richard Burton';

-- or with subqueries and intersect
SELECT m1.title AS film_title
FROM movies AS m1
WHERE m1.id IN (
    SELECT c1.movieid
    FROM castings AS c1
    WHERE c1.actorid IN (
        SELECT a1.id
        FROM actors AS a1
        WHERE a1.name = 'Clint Eastwood'
    )
)
INTERSECT
SELECT m2.title AS film_title
FROM movies AS m2
WHERE m2.id IN (
    SELECT c2.movieid
    FROM castings AS c2
    WHERE c2.actorid IN (
        SELECT a2.id
        FROM actors AS a2
        WHERE a2.name = 'Richard Burton'
    )
);


-- this one is sooo strange (gpt3)
SELECT m.title AS film_title
FROM movies AS m 
JOIN castings AS c ON m.id = c.movieid
JOIN actors AS a ON a.id = c.actorid
WHERE a.name = 'Clint Eastwood' OR a.name = 'Richard Burton'
GROUP BY m.title
HAVING COUNT(DISTINCT a.name) = 2;


-- 14. List all the actors who have appeared in a film with Al Pacino.
-- working from the very inside of the query to the outside
SELECT name FROM actors
WHERE id IN(
    SELECT actorid FROM castings
    WHERE movieid IN(
        SELECT id FROM movies
        WHERE  id IN (
            SELECT movieid FROM castings
            WHERE actorid LIKE 
                (SELECT id FROM actors
                WHERE name LIKE 'Al Pacino')
                    )
                    )
            );

-- 15. List all the actors who appeared in both “Big Sleep, The” and “Casablanca”.
SELECT name FROM actors
WHERE id IN (
    SELECT actorid FROM castings
    WHERE movieid =
        (SELECT id FROM movies
        WHERE title = 'Big Sleep, The')
    INTERSECT
    SELECT actorid FROM castings
    WHERE movieid =
        (SELECT id FROM movies
        WHERE title = 'Casablanca')
    )
;

-- 16. List all the actors who made a film during the 1950s and also in the 1980s
SELECT name
FROM actors
WHERE id IN (
    SELECT actorid
    FROM castings
    WHERE movieid IN (
        SELECT id
        FROM movies
        WHERE yr BETWEEN 1950 AND 1959
        OR yr BETWEEN 1980 AND 1989
    )
);

-- 17. For each year during the 1960s, list the number of films made, and the first and last (alphabetically by title).
SELECT yr,count(*), MIN(title) AS first_alph, MAX(title) AS last_alph FROM movies
WHERE yr BETWEEN 1960 AND 1969
GROUP BY yr
ORDER BY yr;

-- 18. List all the actors who appeared in at least ten films and the names of his/her films.
SELECT a.name, m.title
FROM actors AS a
JOIN castings AS c ON a.id = c.actorid
JOIN movies AS m ON c.movieid = m.id
WHERE a.name IN(
    SELECT a1.name AS actor_name
    FROM actors AS a1
    JOIN castings AS c ON a1.id = c.actorid
    GROUP BY a1.name
    HAVING COUNT(c.actorid) >= 10
    ORDER BY COUNT(c.actorid) DESC);