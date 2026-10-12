create table if not exists authors (
    id SERIAL PRIMARY KEY,
    name varchar(255) not null,
    country varchar(255)
);
create table if not exists books (
    id SERIAL PRIMARY KEY,
    title varchar(255) not null,
    price DECIMAL(10, 2) not null,
    author_id INT NOT NULL REFERENCES authors(id) ON DELETE RESTRICT
);

create table if not exists customers(
    id SERIAL PRIMARY KEY,
    name varchar(255) not null
);

create table if not exists orders(
    id SERIAL PRIMARY KEY,
    ordered_at timestamp DEFAULT CURRENT_TIMESTAMP,
    customer_id INT NOT NULL REFERENCES customers(id) ON DELETE CASCADE
);

create table if not exists order_item(
    quantity INT DEFAULT 1,
    cost DECIMAL(10, 2) not null,
    order_id INT REFERENCES orders(id) ON DELETE SET NULL,
    book_id INT REFERENCES books(id) ON DELETE SET NULL,
    PRIMARY KEY (order_id, book_id)
);

TRUNCATE order_item, orders, customers, books, authors RESTART IDENTITY CASCADE;

INSERT INTO authors (name, country) VALUES
 ('George Orwell',           'UK'),
 ('Jane Austen',             'UK'),
 ('Haruki Murakami',         'Japan'),
 ('Gabriel Garcia Marquez',  'Colombia'),
 ('Naguib Mahfouz',          'Egypt'),
 ('Agatha Christie',         'UK'),
 ('Stephen King',            'USA'),
 ('Toni Morrison',           'USA'),
 ('Paulo Coelho',            'Brazil'),
 ('Leo Tolstoy',             'Russia'),
 ('Fyodor Dostoevsky',       'Russia'),
 ('Ahdaf Soueif',            'Egypt'),
 ('Anonymous',               NULL),   -- NULL country, has 1 book
 ('New Writer',              'Canada'), -- no books
 ('Debut Author',            NULL);     -- no books, NULL country
-- ---------------------------------------------------------------------
-- BOOKS (30)
-- ---------------------------------------------------------------------
INSERT INTO books ( title, price, author_id) VALUES
 ('1984',                           12.99, 1),
 ('Animal Farm',                     9.99, 1),
 ('Homage to Catalonia',            11.50, 1),
 ('Pride and Prejudice',             8.99, 2),
 ('Emma',                            9.49, 2),
 ('Sense and Sensibility',           8.49, 2),
 ('Norwegian Wood',                 14.99, 3),
 ('Kafka on the Shore',             16.99, 3),
 ('1Q84',                           19.99, 3),
 ('One Hundred Years of Solitude',  15.99, 4),
 ('Love in the Time of Cholera',    14.49, 4),
 ('Cairo Trilogy',                  24.99, 5),
 ('Midaq Alley',                    10.99, 5),
 ('Children of the Alley',          13.49, 5),
 ('Murder on the Orient Express',   10.49, 6),
 ('And Then There Were None',       10.99, 6),
 ('Death on the Nile',              10.79, 6),
 ('The Shining',                    15.49, 7),
 ('It',                             21.99, 7),
 ('Misery',                         14.99, 7),
 ('Beloved',                        13.99, 8),
 ('Song of Solomon',                12.99, 8),
 ('The Alchemist',                  11.99, 9),
 ('War and Peace',                  22.99, 10),
 ('Anna Karenina',                  17.99, 10),
 ('Crime and Punishment',           13.99, 11),
 ('The Brothers Karamazov',         16.49, 11),
 ('The Map of Love',                15.00, 12),
 ('Mystery Manuscript',              7.99, 13), -- never ordered
 ('The Idiot',                      14.49, 11); -- never ordered
-- -- --------------------------------------------------------------------
-- -- CUSTOMERS (12)  -- ids 11 and 12 will have no orders
-- -- ---------------------------------------------------------------------
INSERT INTO customers (name) VALUES
 ('Ahmed Hassan'),
 ('Sara Ali'),
 ('Omar Khaled'),
 ('Layla Mostafa'),
 ('John Smith'),
 ('Emily Clark'),
 ('Yusuf Ibrahim'),
 ('Mona Samir'),
 ('Karim Adel'),
 ('Nora Fathy'),
 ('Hassan Tarek'),  -- no orders
 ('Dina Wael');     -- no orders

-- ---------------------------------------------------------------------
-- ORDERS 1-30 (hand-written, easy to trace by eye)
-- ---------------------------------------------------------------------
INSERT INTO orders (ordered_at, customer_id) VALUES
 ('2025-01-05 10:15', 1),
 ('2025-01-12 14:30', 2),
 ('2025-01-20 09:05', 3),
 ('2025-02-02 17:45', 1),
 ('2025-02-14 12:00', 4),
 ('2025-02-28 18:20', 5),
 ('2025-03-03 11:10', 6),
 ('2025-03-15 16:40', 2),
 ('2025-03-22 13:25', 7),
 ('2025-04-01 08:50', 8),
 ('2025-04-10 19:05', 1),
 ('2025-04-18 15:15', 9),
 ('2025-05-05 10:30', 3),
 ('2025-05-21 12:45', 10),
 ('2025-06-07 09:35', 4),
 ('2025-06-30 20:10', 5),
 ('2025-07-04 14:00', 6),
 ('2025-07-19 11:55', 2),
 ('2025-08-08 16:25', 7),
 ('2025-08-25 13:05', 8),
 ('2025-09-09 10:00', 1),
 ('2025-09-30 18:40', 9),
 ('2025-10-12 12:20', 10),
 ('2025-11-01 15:50', 3),
 ('2025-11-27 09:15', 4),
 ('2025-12-15 17:30', 5),
 ('2026-01-10 11:00', 6),
 ('2026-02-14 14:45', 2),
 ('2026-03-08 10:10', 7),
 ('2026-04-20 16:00', 1);

-- ORDER ITEMS for orders 1-30: (order_id, book_id, quantity )
INSERT INTO order_item (order_id, book_id, quantity, cost) VALUES
(1, 1, 2, 12.99),
(1, 4, 1, 8.99),
(2, 7, 1, 14.99),
(2, 10, 2, 15.99),
(3, 12, 1, 24.99),
(3, 15, 2, 10.49),
(4, 2, 3, 9.99),
(4, 18, 1, 15.49),
(5, 5, 1, 9.49),
(5, 13, 2, 10.99),
(6, 19, 1, 21.99),
(6, 21, 2, 13.99),
(7, 8, 1, 16.99),
(7, 23, 2, 11.99),
(8, 3, 1, 11.50),
(8, 16, 2, 10.99),
(9, 9, 1, 19.99),
(9, 24, 1, 22.99),
(10, 11, 2, 14.49),
(10, 22, 1, 12.99),
(11, 6, 1, 8.49),
(11, 17, 2, 10.79),
(12, 14, 1, 13.49),
(12, 25, 1, 17.99),
(13, 20, 2, 14.99),
(13, 26, 1, 13.99),
(14, 27, 1, 16.49),
(14, 28, 2, 15.00),
(15, 1, 1, 12.99),
(15, 12, 1, 24.99),
(16, 4, 2, 8.99),
(16, 18, 1, 15.49),
(17, 7, 1, 14.99),
(17, 19, 1, 21.99),
(18, 10, 2, 15.99),
(18, 15, 1, 10.49),
(19, 13, 1, 10.99),
(19, 23, 3, 11.99),
(20, 5, 2, 9.49),
(20, 24, 1, 22.99),
(21, 2, 1, 9.99),
(21, 21, 1, 13.99),
(22, 8, 2, 16.99),
(22, 16, 1, 10.99),
(23, 11, 1, 14.49),
(23, 25, 2, 17.99),
(24, 3, 1, 11.50),
(24, 26, 2, 13.99),
(25, 14, 2, 13.49),
(25, 27, 1, 16.49),
(26, 6, 1, 8.49),
(26, 20, 2, 14.99),
(27, 9, 1, 19.99),
(27, 22, 1, 12.99),
(28, 17, 2, 10.79),
(28, 28, 1, 15.00),
(29, 12, 1, 24.99),
(29, 24, 2, 22.99),
(30, 1, 1, 12.99),
(30, 29, 1, 7.99);





