

CREATE TABLE Exams(
    code VARCHAR(9),
    title CHAR(20),
    date DATETIME,
    -- using float for hours because it can be 1.5 or similar
    duration INTEGER, 
    location VARCHAR(50),
    number_of_students INTEGER,
    PRIMARY KEY (code)
);

INSERT INTO Exams
VALUES ('098767878', 'Introduction to Relational Databases', '2023-11-20 12:30:20', 100, 'Brookfield Bulding', 100),
('098768898', 'Systems Organisation', '2023-15-20 11:30:00', 150, 'Western Gateway Bulding', 60),
('096765898', 'Economic Reasoning', '2023-20-20 12:00:10', 90, 'Boole Library', 120);

SELECT * FROM Exams;

UPDATE Exams
SET duration = duration + 10
WHERE duration = 90;

DELETE FROM Exams
WHERE number_of_students <= 6;

SELECT code, title, location FROM Exams
WHERE duration > 90
AND date LIKE '2016-12-01';


-- this is not right cuz I have number of students as my count
SELECT 
    location AS venue,
    MIN(date) AS first_date,
    MAX(date) AS last_date,
    COUNT(DISTINCT code) AS total_exam_sittings
FROM Exams
GROUP BY location;
