SELECT * FROM likes;
SELECT * FROM persons;

SELECT L1.person_id AS person1_id, L1.food AS food1, L2.person_id AS person2_id, L2.food AS food2
FROM likes L1
CROSS JOIN likes L2
WHERE L1.person_id <> L2.person_id
ORDER BY L1.person_id, L2.person_id, L1.food, L2.food;

-- 9
SELECT L1.person_id AS person1_id, L1.food AS food1, L2.person_id AS person2_id, L2.food AS food2
FROM likes L1
JOIN likes L2 ON L1.person_id = L2.person_id AND L1.food < L2.food
ORDER BY L1.person_id, food1, food2;

SELECT L1.person_id AS person_id, L1.food AS food1, L2.food AS food2
FROM likes L1
JOIN likes L2 ON L1.person_id = L2.person_id AND L1.food < L2.food
ORDER BY L1.person_id, food1, food2;

-- both nutella and pizza
SELECT person_id
FROM likes
WHERE food = 'Pizza' AND person_id IN (SELECT person_id FROM likes WHERE food = 'Nutella');


SELECT DISTINCT person_id
FROM likes
WHERE food = 'Pizza' OR food = 'Nutella';


SELECT first_name FROM persons JOIN likes ON persons.person_id = likes.person_id
WHERE town = 'Cork' AND food = 'Beer';

SELECT * FROM persons AS p1 CROSS JOIN persons AS p2
WHERE p1.person_id < p2.person_id;

SELECT p1.first_name, p1.last_name 
FROM persons AS p1 
JOIN persons AS p2 ON p1.person_id = p2.person_id
WHERE p1.birth_date = p2.birth_date 
AND p1.person_id <> p2.person_id;
-- for some reason doesn't execute but chat gpt says its fine 
--  okay the problem was that this columns are in both tables and 
-- we need to specify from which table are we selecting

SELECT food, COUNT(person_id) AS favorite_count
FROM likes
GROUP BY food
ORDER BY favorite_count DESC;


SELECT DISTINCT first_name, last_name 
FROM persons JOIN likes 
ON persons.person_id = likes.person_id
WHERE food NOT LIKE 'Beer';

SELECT DISTINCT L1.person_id AS person1_id, L2.person_id AS person2_id, L1.food
FROM likes L1
JOIN likes L2 ON L1.food = L2.food
WHERE L1.person_id < L2.person_id;

SELECT p1.county, f1.food, COUNT(*) AS like_amount
FROM persons AS p1 
JOIN likes AS f1 
ON p1.person_id = f1.person_id
GROUP BY food;


SELECT p1.county, COUNT(*) AS beer_lovers
FROM persons AS p1
JOIN likes AS f1 ON p1.person_id = f1.person_id
WHERE f1.food = 'Beer'
GROUP BY p1.county
ORDER BY beer_lovers DESC;

SELECT p2.first name, p2.last name
FROM persons AS p1 JOIN knows as k JOIN persons AS p2
ON p1.person_id = k.person_id AND k.friend_id = p2.person_id
WHERE p1.first name = ”Aoife” AND p1.last name = ”Ahern”
INTERSECT
SELECT p2.first name, p2.last name
FROM persons AS p1 JOIN knows as k JOIN persons AS p2
ON p1.person_id = k.person_id AND k.friend id = p2.person_id
WHERE p1.first name = ”Declan” AND p1.last name = ”Duffy”;

SELECT first_name, last_name 
FROM persons 
WHERE person_id IN
    (SELECT person_id 
    FROM knows
    WHERE friend_id = 
        (SELECT person_id 
        FROM persons
        WHERE first_name = 'Aoife' AND last_name = 'Ahern')
    INTERSECT
    SELECT person_id 
    FROM knows
    WHERE friend_id = 
        (SELECT person_id 
        FROM persons
        WHERE first_name = 'Declan' AND last_name = 'Duffy')
    )
;


SELECT first_name,last_name
from persons    
join knows
on knows.person_id=persons.person_id
where friend_id !=
(select person_id
FROM persons
where first_name = 'Aoife' AND last_name = 'Ahern'
)




SELECT first_name, last_name 
FROM persons 
WHERE person_id IN
    (SELECT person_id 
    FROM knows
    WHERE friend_id !=
        (SELECT person_id 
        FROM persons
        WHERE first_name = 'Aoife' AND last_name = 'Ahern'));


SELECT first_name, last_name
FROM persons
WHERE birth_date = (SELECT MIN(birth_date) FROM persons)
OR birth_date = (SELECT MAX(birth_date) FROM persons);


SELECT p.county, count(*)
FROM persons AS p
JOIN likes AS f ON p.person_id = f.person_id
WHERE f.food = 'Pizza'
GROUP BY p.county;
-- these do the same mine in up gpt is down
-- This query effectively selects the amount of 
-- people who like pizza in every county 
SELECT p.county, COUNT(*) AS county_pizza_lovers
FROM persons AS p
JOIN likes AS f ON p.person_id = f.person_id
WHERE f.food = 'Pizza'
GROUP BY p.county;

