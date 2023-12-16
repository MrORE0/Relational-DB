-- Add 10 new rows to the hotels table with hotel_num starting from 7
INSERT INTO hotels (hotel_num, hotel_name, city)
VALUES
    (7, 'Grand Plaza Hotel', 'New York'),
    (8, 'Ritz Carlton', 'Los Angeles'),
    (9, 'Parisian Charm Hotel', 'Paris'),
    (10, 'Tokyo Towers Inn', 'Tokyo'),
    (11, 'Sydney Harbor Hotel', 'Sydney'),
    (12, 'Rome Renaissance Resort', 'Rome'),
    (13, 'Cancun Beachfront Resort', 'Cancun'),
    (14, 'Mumbai Majesty Hotel', 'Mumbai'),
    (15, 'Cape Town Serenity Lodge', 'Cape Town'),
    (16, 'Dubai Oasis Retreat', 'Dubai');

-- Add 10 new rows to the rooms table
INSERT INTO rooms (room_num, hotel_num, room_type, price)
VALUES
    (101, 7, 'Deluxe Suite', 300),
    (102, 7, 'Standard Double', 200),
    (201, 8, 'Presidential Suite', 500),
    (202, 8, 'Executive Single', 250),
    (301, 9, 'Eiffel View Double', 350),
    (302, 9, 'Chic Parisian Suite', 450),
    (401, 10, 'Tokyo Tower Suite', 400),
    (501, 11, 'Harbor View Double', 380),
    (601, 12, 'Roman Villa Suite', 600),
    (701, 13, 'Oceanfront Suite', 450);

-- Add 10 new rows to the bookings table
INSERT INTO bookings (hotel_num, guest_num, arr_date, dep_date, room_num)
VALUES
    (7, 4, '2023-01-15', '2023-01-20', 101),
    (7, 5, '2023-02-10', '2023-02-15', 102),
    (8, 6, '2023-03-05', '2023-03-10', 201),
    (9, 7, '2023-04-20', '2023-04-25', 301),
    (10, 8, '2023-05-12', '2023-05-17', 401),
    (11, 9, '2023-06-08', '2023-06-13', 501),
    (12, 10, '2023-07-01', '2023-07-06', 601),
    (13, 11, '2023-08-18', '2023-08-23', 701),
    (14, 12, '2023-09-22', '2023-09-27', 102),
    (15, 13, '2023-10-15', '2023-10-20', 202);

-- Add 10 new rows to the guests table with guest_num starting from 4
INSERT INTO guests (guest_num, guest_name, guest_address)
VALUES
    (4, 'Michael Johnson', '123 Park Ave, New York'),
    (5, 'Emily Davis', '456 Sunset Blvd, Los Angeles'),
    (6, 'Sophie Lefevre', '789 Rue de Rivoli, Paris'),
    (7, 'Kenji Tanaka', '1-2-3 Ginza, Tokyo'),
    (8, 'Isabella Smith', '15 Circular Quay, Sydney'),
    (9, 'Alessandro Rossi', 'Via del Corso, Rome'),
    (10, 'Maria Hernandez', 'Playa Delfines, Cancun'),
    (11, 'Raj Kapoor', 'Juhu Beach, Mumbai'),
    (12, 'Lerato Ndlovu', 'Table Mountain Rd, Cape Town'),
    (13, 'Fatima Al-Maktoum', 'Palm Jumeirah, Dubai');

