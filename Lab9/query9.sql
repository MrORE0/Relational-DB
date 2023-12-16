-- hotels(hotel_num, hotel_name, city)
-- rooms(room_num, hotel_num, room_type, price)
-- bookings(hotel_num, guest_num, arr_date, dep_date, room_num)
-- guests(guest_num, guest_name, guest_address)


-- 1. List full details of all hotels in Cork
SELECT * FROM hotels
WHERE city = "Cork";

-- 2. List names and addresses of all guests living in Limerick ordered by name.
SELECT guest_name, guest_address FROM guests
where guest_address LIKE "%Limerick"
ORDER BY guest_name;

-- 3. List the ids of all double rooms priced lower than €70.00, in ascending order of price
SELECT room_num from rooms
Where room_type = "double" AND price < 70;

-- 4. List bookings for which no dep date has been specified.
SELECT * FROM bookings
WHERE dep_date IS NULL;

-- 5. How many hotels are there in total?
SELECT count(DISTINCT hotel_num) AS total_num_of_hotels FROM hotels;

-- 6. List the ids of each hotel with the number of rooms it has for less than e 70.00
SELECT hotels.hotel_num, COUNT(DISTINCT rooms.room_num) AS room_count
FROM hotels
JOIN rooms ON hotels.hotel_num = rooms.hotel_num
WHERE rooms.price < 70
GROUP BY hotels.hotel_num;

-- 7. List the names of each hotels with the number of rooms it has for less than e 70.00
SELECT hotels.hotel_name, COUNT(DISTINCT rooms.room_num) AS room_count
FROM hotels
JOIN rooms ON hotels.hotel_num = rooms.hotel_num
WHERE rooms.price < 70
GROUP BY hotels.hotel_name;

-- 8. How many hotels are there that have double rooms for under e 70.00?
SELECT count(*) FROM rooms
WHERE room_type LIKE "%double%" AND price < 70;

-- 9. What is the average price per room over all?
SELECT avg(price) FROM rooms;

-- 10. What is the average price per room in Cork?
SELECT avg(price) from (
    SELECT price from rooms
    JOIN hotels ON hotels.hotel_num = rooms.hotel_num
    WHERE hotels.city = "Cork")
    ;

-- 11. What is the average price per double room in Cork?
SELECT avg(price) from (
    SELECT price from rooms
    JOIN hotels ON hotels.hotel_num = rooms.hotel_num
    WHERE hotels.city = "Cork" AND rooms.room_type LIKE "%double%")
    ;

-- 12. How many bookings have been made for November for each hotel? (Count a booking if 
-- the arrival date occurs within that month.)
SELECT count(*) FROM bookings
WHERE arr_date LIKE "____-11-__";

-- 13. List the price and type of all rooms in the “Hotel Splendide”.
SELECT r.price, r.room_type FROM rooms AS r
JOIN hotels AS h ON r.hotel_num = h.hotel_num
WHERE h.hotel_name = "Hotel Splendide";

-- !!!!!
-- 14. List the names of all the hotels in Galway together with the number of rooms in each
SELECT h.hotel_name, count(r.room_num) FROM hotels AS h
JOIN rooms AS r ON h.hotel_num = r.hotel_num
WHERE h.city = "Galway"
GROUP BY h.hotel_name;

-- 15. List all the guests with a booking at the “Hotel Splendide” for the month of January
SELECT g.guest_name, b.arr_date, b.dep_date FROM guests AS g
JOIN bookings AS b ON g.guest_num = b.guest_num 
JOIN hotels AS h ON b.hotel_num = h.hotel_num
WHERE h.hotel_name = "Hotel Splendide" AND b.dep_date LIKE "____-01-__";

-- !!!!!
-- 16. List all pairs of (different) hotels that have the same name
SELECT h1.hotel_name, h1.hotel_num AS hotel_num_1, h2.hotel_num AS hotel_num_2
FROM hotels AS h1
JOIN hotels AS h2 ON h1.hotel_name = h2.hotel_name AND h1.hotel_num <> h2.hotel_num;

-- !!!!!
-- 17. List the names of all the guests currently staying at the “Hotel California”, ordered by checkout date.
SELECT g.guest_name
FROM guests AS g2
JOIN bookings AS b ON g.guest_num = b.guest_num
JOIN hotels AS h ON b.hotel_num = h.hotel_num
WHERE h.hotel_name = 'Hotel California'
      AND b.arr_date <= DATE('now')
      AND b.dep_date >= DATE('now')
ORDER BY b.dep_date;

-- !!!!
-- 18. List all customers who have separate bookings for two distinct hotels in two different cities for the same dates
SELECT
    g.guest_name,
    MAX(h1.hotel_name) AS hotel_one,
    MAX(h2.hotel_name) AS hotel_two,
    b.arr_date,
    b.dep_date
FROM
    guests AS g
JOIN
    bookings AS b ON g.guest_num = b.guest_num
JOIN
    hotels AS h1 ON b.hotel_num = h1.hotel_num
JOIN
    hotels AS h2 ON h1.hotel_num < h2.hotel_num AND h1.city <> h2.city
GROUP BY
    g.guest_num, b.arr_date, b.dep_date
ORDER BY
    b.dep_date;






