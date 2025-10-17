CREATE DATABASE AmazonDB;

USE AmazonDB;

CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    registration_date DATE NOT NULL,
    plan ENUM('Basic', 'Standard', 'Premium') DEFAULT 'Basic'
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    price decimal(10,2) NOT NULL,
    category VARCHAR(100) NOT NULL,
    stock INT NOT NULL
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    order_date DATE NOT NULL,
    total_amount decimal(10,2) NOT NULL
);

ALTER TABLE Orders ADD COLUMN user_id  INT NOT NULL;

ALTER TABLE Orders
ADD CONSTRAINT fk_constraint_name
FOREIGN KEY (user_id)
REFERENCES Users (user_id);

CREATE TABLE OrderDetails (
    order_details_id INT PRIMARY KEY AUTO_INCREMENT,
    quantity INT NOT NULL
);

ALTER TABLE OrderDetails ADD COLUMN order_id  INT NOT NULL;
ALTER TABLE OrderDetails ADD COLUMN product_id  INT NOT NULL;
ALTER TABLE OrderDetails ADD CONSTRAINT order_id_fk FOREIGN KEY (order_id) REFERENCES Orders (order_id);
ALTER TABLE OrderDetails ADD CONSTRAINT product_id_fk FOREIGN KEY (product_id) REFERENCES Products (product_id);


INSERT INTO Users (name, email, registration_date, plan) VALUES
('Alice Johnson', 'alice.j@example.com', '2024-01-15', 'Premium'),
('Bob Smith', 'bob.s@example.com', '2024-02-01', 'Basic'),
('Charlie Brown', 'charlie.b@example.com', '2024-03-10', 'Premium'),
('Daisy Ridley', 'daisy.r@example.com', '2024-04-12', 'Basic');


INSERT INTO products (name, price, category, stock) VALUES
('Echo Dot', 49.99, 'Electronics', 120),
('Kindle Paperwhite', 129.99, 'Books', 50),
('Fire Stick', 39.99, 'Electronics', 80),
('Yoga Mat', 19.99, 'Fitness', 200),
('Wireless Mouse', 24.99, 'Electronics', 150);


INSERT INTO Orders (user_id, order_date, total_amount) VALUES
(1, '2024-05-01', 79.98),
(2, '2024-05-03', 129.99),
(1, '2024-05-04', 49.99),
(3, '2024-05-05', 24.99);


INSERT INTO OrderDetails (order_id, product_id, quantity) VALUES
(1, 1, 2),
(2, 2, 1),
(3, 1, 1),
(4, 5, 1);

-- 1. List all customers who have made purchases of more than $80.
SELECT users.user_id, users.name, orders.total_amount 
FROM users
INNER JOIN orders ON users.user_id = orders.user_id
WHERE orders.total_amount > 80


-- 2. Retrieve all orders placed in the last 280 days along with the customer name and email.
-- SELECT CURDATE(), CURDATE() - INTERVAL 280 DAY FROM DUAL;
SELECT users.name, users.email, orders.order_date 
FROM users
INNER JOIN orders ON users.user_id = orders.user_id
WHERE orders.order_date <= CURDATE() - INTERVAL 280 DAY 

-- 3. Find the average product price for each category.
SELECT category, SUM(price) FROM products group by category

-- 4. List all customers who have purchased a product from the category Electronics. 


-- 5. Find the total number of products sold and the total revenue generated for each product.
SELECT orderdetails.
FROM orderdetails 
