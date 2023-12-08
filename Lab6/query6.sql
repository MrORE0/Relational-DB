-- movies(id, title, yr, score, votes, director)
-- actors(id, name)
-- castings(movieid, actorid)

SELECT * FROM actors;
SELECT * FROM castings;
SELECT * FROM movies;

--1. List the ids of all actors who appeared in “Big Sleep, The”.
SELECT id FROM actors
WHERE id IN(
    SELECT actorid FROM castings
    WHERE movieid = (
        SELECT id FROM movies
        WHERE title = 'Big Sleep, The')
        )
;
-- same but with join
SELECT a.id FROM actors AS a
JOIN castings AS c ON a.id = c.actorid
JOIN movies AS m ON c.movieid = m.id
WHERE m.title = 'Big Sleep, The';



-- 2. List chronologically the names of the films made by the director of “Citizen Kane”
SELECT m.title, m.yr
FROM movies AS m
JOIN movies AS m2 ON m.director = m2.director
WHERE m2.title = 'Citizen Kane'
ORDER BY m.yr;


-- 3. List the names of all actors who appeared in “Big Sleep, The”.
SELECT a.name FROM actors AS a
JOIN castings AS c ON a.id = c.actorid
JOIN movies AS m ON c.movieid = m.id
WHERE m.title = 'Big Sleep, The';


-- 4. List the ids of all films that were either made in the 1950s or had Elizabeth Taylor in them.
SELECT DISTINCT m.id FROM movies AS m 
JOIN castings AS c ON m.id = c.movieid
JOIN actors AS a ON c.actorid = a.id
WHERE (m.yr BETWEEN 1950 AND 1959) OR a.name = 'Elizabeth Taylor';
-- should use distinct cuz you get duplicates


-- 5. List the name and scores of the film(s) with the best score.
SELECT m.title, m.score
FROM movies AS m
WHERE m.score = (SELECT MAX(score) FROM movies);


-- 6. List the ids of the actors with at least 10 films to their credit.
SELECT a.id, count(m.title) AS movie_count
FROM actors AS a
JOIN castings AS c ON a.id = c.actorid
JOIN movies AS m ON c.movieid = m.id
GROUP BY a.id 
HAVING count(m.title) >= 10;


-- 7. List the names of the actors with at at least 10 films to their credit.
SELECT a.name, count(m.title) AS movie_count
FROM actors AS a
JOIN castings AS c ON a.id = c.actorid
JOIN movies AS m ON c.movieid = m.id
GROUP BY a.id 
HAVING count(m.title) >= 10;

-- 8. List the name and scores of the film(s) with scores within 10% of the the best score.
-- idk man this is from gpt
SELECT m.title, m.score
FROM movies AS m
WHERE m.score >= (SELECT MAX(score) FROM movies) * 0.9
AND m.score <= (SELECT MAX(score) FROM movies);
-- this is not done

-- 9. List the names of all the actors that appeared in the most terrible films (those with scores below 3.0).
SELECT a.name FROM actors AS a
JOIN castings AS c ON a.id = c.actorid
JOIN movies AS m ON c.movieid = m.id
WHERE m.score < 3;

-- 10. List the names and scores of the films with the best and the worst scores.
SELECT m1.title, m1.score
FROM movies AS m1 
WHERE m1.score = (SELECT MIN(score) FROM movies)
OR m1.score = (SELECT MAX(score) FROM movies);

-- 11. List the years and films made before the first film made by the director of ’Citizen Kane’.
SELECT title, yr 
FROM movies
WHERE yr < ( 
    SELECT MIN(yr) FROM movies
    WHERE director = (
        SELECT director FROM movies
        WHERE title = 'Citizen Kane')
        )
;

-- 12. List the years and films made after the first film made by the director of ’Citizen Kane’.
SELECT title, yr 
FROM movies
WHERE yr > ( 
    SELECT MIN(yr) FROM movies
    WHERE director = (
        SELECT director FROM movies
        WHERE title = 'Citizen Kane')
        )
;

-- 13. List all the films with a score at least as good as the best film made in the 1940s.
SELECT title 
FROM movies
WHERE score >= (
    SELECT Max(score)
    FROM movies
    WHERE yr = 1940)
; 

-- 14. What is the greatest number of films made by any director?
SELECT director, count(*)
FROM movies
GROUP BY director
ORDER BY count(*) DESC;

-- 15. List the director id and the number of films of the director with the greatest number of films
SELECT director, MAX(movies_made) FROM (
    SELECT director, count(*) AS movies_made
    FROM movies
    GROUP BY director)
;

-- 16. List, in chronological order, all the films by the director with the greatest number of films.
SELECT m.title, m.yr
FROM movies AS m
WHERE m.director = (
    SELECT director
    FROM movies
    GROUP BY director
    HAVING COUNT(*) = (
        SELECT MAX(count)
        FROM (
            SELECT COUNT(*) AS count
            FROM movies
            GROUP BY director
        ) AS director_counts
    )
)
ORDER BY m.yr;

-- 17. List all the films starring Diane Keaton made by the director of “Bananas”.
SELECT m.title
FROM movies AS m
JOIN castings AS c ON m.id = c.movieid
JOIN actors AS a ON c.actorid = a.id
WHERE a.name = 'Diane Keaton'
AND m.director = (
    SELECT director
    FROM movies
    WHERE title = 'Bananas'
);
