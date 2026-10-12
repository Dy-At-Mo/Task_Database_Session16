-- 1) get the number of books for each author, Include authors with none. =>
SELECT
    a.id,
    a.name,
    COUNT(b.id) AS book_count
FROM authors AS a
LEFT JOIN books AS b
    ON a.id = b.author_id
GROUP BY a.id, a.name
ORDER BY a.id;

-- 2) get authors with more than 3 books. =>
SELECT
    a.id,
    a.name,
    COUNT(b.id) AS book_count
FROM authors AS a
INNER JOIN books AS b
    ON a.id = b.author_id
GROUP BY a.id, a.name
HAVING COUNT(b.id) > 3
ORDER BY book_count DESC;

-- 3) get countries that have more than 1 authors =>
SELECT
    country,
    COUNT(*) AS author_count
FROM authors
WHERE country IS NOT NULL
GROUP BY country
HAVING COUNT(*) > 1
ORDER BY author_count DESC;

-- 4) get top 5 customers by total order price. =>
SELECT
    c.id,
    c.name,
    SUM(oi.quantity * oi.cost) AS total_spent
FROM customers AS c
INNER JOIN orders AS o
    ON c.id = o.customer_id
INNER JOIN order_item AS oi
    ON o.id = oi.order_id
GROUP BY c.id, c.name
ORDER BY total_spent DESC
LIMIT 5;

-- 5) get customers that spent more than 100 in total =>
SELECT
    c.id,
    c.name,
    SUM(oi.quantity * oi.cost) AS total_spent
FROM customers AS c
INNER JOIN orders AS o
    ON c.id = o.customer_id
INNER JOIN order_item AS oi
    ON o.id = oi.order_id
GROUP BY c.id, c.name
HAVING SUM(oi.quantity * oi.cost) > 100
ORDER BY total_spent DESC;

-- 6) get customers with no orders =>
SELECT
    c.id,
    c.name
FROM customers AS c
LEFT JOIN orders AS o
    ON c.id = o.customer_id
WHERE o.id IS NULL;

-- 7) get book that were never ordered =>
SELECT
    b.id,
    b.title,
    b.price
FROM books AS b
LEFT JOIN order_item AS oi
    ON b.id = oi.book_id
WHERE oi.book_id IS NULL;

-- 8) get top 5 books by number sold (not total price) with author name =>
SELECT
    b.id,
    b.title,
    a.name AS author_name,
    SUM(oi.quantity) AS total_sold
FROM books AS b
INNER JOIN authors AS a
    ON b.author_id = a.id
INNER JOIN order_item AS oi
    ON b.id = oi.book_id
GROUP BY b.id, b.title, a.name
ORDER BY total_sold DESC
LIMIT 5;

-- 9) get total amount sold per country =>
SELECT
    a.country,
    SUM(oi.quantity * oi.cost) AS total_amount_sold
FROM authors AS a
INNER JOIN books AS b
    ON a.id = b.author_id
INNER JOIN order_item AS oi
    ON b.id = oi.book_id
WHERE a.country IS NOT NULL
GROUP BY a.country
ORDER BY total_amount_sold DESC;

-- 10) get customers with less than 2 orders =>
SELECT
    c.id,
    c.name,
    COUNT(o.id) AS order_count
FROM customers AS c
LEFT JOIN orders AS o
    ON c.id = o.customer_id
GROUP BY c.id, c.name
HAVING COUNT(o.id) < 2
ORDER BY order_count, c.id;

-- 11) get orders with 3 or more different books =>
SELECT
    o.id AS order_id,
    o.ordered_at,
    COUNT(DISTINCT oi.book_id) AS different_books
FROM orders AS o
INNER JOIN order_item AS oi
    ON o.id = oi.order_id
GROUP BY o.id, o.ordered_at
HAVING COUNT(DISTINCT oi.book_id) >= 2
ORDER BY different_books DESC, o.id;




