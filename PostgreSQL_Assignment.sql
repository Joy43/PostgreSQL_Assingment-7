-- ----------- create table books --------------
CREATE TABLE books (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL,
    published_year INT NOT NULL
);

-- ---------insert books data----------
INSERT INTO books (title, author, price, stock, published_year) VALUES
('The Pragmatic Programmer', 'Andrew Hunt', 40.00, 10, 1999),
('Clean Code', 'Robert C. Martin', 35.00, 5, 2008),
('You Do not Know JS', 'Kyle Simpson', 30.00, 8, 2014),
('Refactoring', 'Martin Fowler', 50.00, 3, 1999),
('Database Design Principles', 'Jane Smith', 20.00, 0, 2018);

SELECT * FROM books;
DROP TABLE books;

-- -------- create customers table --------------
CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(80) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    joined_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert customer data
INSERT INTO customers (name, email) VALUES
('Alice', 'alice@email.com'),
('Bob', 'bob@email.com'),
('Charlie', 'charlie@email.com');

-- Retrieve data from customers table
SELECT * FROM customers;
 DROP TABLE customers;

-- -------- create orders table -------------
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    customer_id INTEGER NOT NULL REFERENCES customers(id) ,
    book_id INTEGER NOT NULL REFERENCES books(id) ,
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ----------- Insert orders data w-----------

INSERT INTO orders (customer_id, book_id, quantity) VALUES
(1, 2, 1), 
(2, 1, 2), 
(3, 1, 3),  
(1, 3, 1);  

-- Retrieve data from orders table
SELECT * FROM orders;
DROP TABLE orders;



/* ---------------------------
1️⃣ Find books that are out of stock.
title Database Design Principles
 --------------------------------- 
 */
SELECT title FROM books
WHERE stock=0;

/* **********************************

2️⃣ Retrieve the most expensive book in the store.

Sample Output:

| id  | title       | author        | price | stock | published_year |
| --- | ----------- | ------------- | ----- | ----- | -------------- |
| 4   | Refactoring | Martin Fowler | 50.00 | 3     | 1999           |

 *****************************************************           */

SELECT id,title,author,price,stock,published_year FROM books
WHERE price=(SELECT max(price) FROM books);


/* 

 3️⃣ Find the total number of orders placed by each customer.

Sample Output:

| name    | total_orders |
| ------- | ------------ |
| Alice   | 2            |
| Bob     | 1            |


 */

SELECT customers.name, COUNT(*) AS total_orders 
FROM orders
JOIN customers ON orders.customer_id = customers.id
GROUP BY customers.name;


/* 
*******************
4️⃣ Calculate the total revenue generated from book sales.
************************
 */
SELECT SUM(books.price * orders.quantity) AS total_revenue
FROM orders
JOIN books ON orders.book_id = books.id;
;

/* 
*******************************
5️⃣ List all customers who have placed more than one order.
**********************************
 */

SELECT customers.name, COUNT(*) AS orders_count
FROM orders
JOIN customers ON orders.customer_id = customers.id
GROUP BY customers.id, customers.name
HAVING COUNT(orders.customer_id) > 1;

/* 
*******************
6️⃣ Find the average price of books in the store.
Sample Output:
*********************
 */

 SELECT ROUND(avg(books.price),2) AS avg_book_price FROM books;


 /* ***************************************
 
  7️⃣  Increase the price of all books published before 2000 by 10%.

Sample Output: (No table output, but affected rows will be updated accordingly.)

| id  | title                        | author             | price  | stock | published_year |
|-----|------------------------------|--------------------|--------|-------|----------------|
| 1   | The Pragmatic Programmer     | Andrew Hunt        | 44.00  | 10    | 1999           |
| 2   | Clean Code                   | Robert C. Martin   | 35.00  | 5     | 2008           |
| 3   | You Don't Know JS            | Kyle Simpson       | 30.00  | 8     | 2014           |
| 4   | Refactoring                  | Martin Fowler      | 55.00  | 3     | 1999           |
| 5   | Database Design Principles   | Jane Smith         | 20.00  | 0     | 2018           |
 
 *************************************************
  */
  UPDATE books
SET price = price * 1.10
WHERE published_year < 2000;
SELECT *FROM books;

 /* 
 **********************
 8️⃣ Delete customers who haven't placed any orders.

Sample Output: (No table output, but affected rows will be removed accordingly.)
 
  */
DELETE FROM customers
WHERE id NOT IN (SELECT customer_id FROM orders);

