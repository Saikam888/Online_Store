create database OnlineStore;

use OnlineStore;

#create tables

create table customers (
customer_id int primary key,
name varchar(50),
email varchar(50),
city varchar(50)
);

create table products(
product_id int primary key,
product_name varchar(50),
category varchar(50),
price decimal(10,2)
);

create table orders (
order_id int primary key,
customer_id int,
order_date date,
foreign key (customer_id) references customers(customer_id)
);

create table order_items(
item_id int primary key,
order_id int,
product_id int,
quantity int,
foreign key (order_id) references orders(order_id),
foreign key (product_id) references products(product_id)
);

insert into customers values
(1, 'Rahul Sharma', 'rahul@gmail.com', 'Hyderabad'),
(2, 'Priya Singh', 'priya@gmail.com', 'Mumbai'),
(3, 'Amit Verma', 'amit@gmail.com', 'Delhi'),
(4, 'Sneha Reddy', 'sneha@gmail.com', 'Chennai');

INSERT INTO Products VALUES
(101, 'Laptop', 'Electronics', 55000),
(102, 'Mobile', 'Electronics', 22000),
(103, 'Keyboard', 'Accessories', 1500),
(104, 'Headphones', 'Accessories', 3000);

INSERT INTO Orders VALUES
(501, 1, '2024-05-12'),
(502, 2, '2024-06-01'),
(503, 1, '2024-06-15'),
(504, 3, '2024-07-20');

INSERT INTO Order_Items VALUES
(1, 501, 101, 1),
(2, 501, 103, 2),
(3, 502, 102, 1),
(4, 503, 104, 1),
(5, 503, 102, 1),
(6, 504, 103, 3);

#1 ️ List all orders with customer name and order date
-- Question: Show order_id, customer name, and order date
SELECT o.order_id, c.name AS customer_name, o.order_date
FROM Orders o
INNER JOIN Customers c ON o.customer_id = c.customer_id;

# 2 Show each order with product names included
-- Question: Show order_id and product names
SELECT o.order_id, p.product_name
FROM Orders o
INNER JOIN Order_Items oi ON o.order_id = oi.order_id
INNER JOIN Products p ON oi.product_id = p.product_id;

# 3 List all customers and their orders (include customers with no orders)
-- Question: Show all customers and their orders (if any)
SELECT c.customer_id, c.name AS customer_name, o.order_id, o.order_date
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id;

# 4 Display order_id, product_name, price, quantity for each ordered item
-- Question: Show details of each order item
SELECT oi.order_id, p.product_name, p.price, oi.quantity
FROM Order_Items oi
INNER JOIN Products p ON oi.product_id = p.product_id;

# 5 Show customer name and all products they purchased (unique list)
-- Question: List customer and products purchased
SELECT DISTINCT c.name AS customer_name, p.product_name
FROM Customers c
INNER JOIN Orders o ON c.customer_id = o.customer_id
INNER JOIN Order_Items oi ON o.order_id = oi.order_id
INNER JOIN Products p ON oi.product_id = p.product_id;

# 6 List orders with total items (sum of quantity)
-- Question: Show total items per order
SELECT o.order_id, SUM(oi.quantity) AS total_items
FROM Orders o
INNER JOIN Order_Items oi ON o.order_id = oi.order_id
GROUP BY o.order_id;

# 7 Display customers who ordered products from category 'Electronics'
-- Question: Customers who bought Electronics
SELECT DISTINCT Customers.name AS customer_name
FROM Customers
INNER JOIN Orders ON Customers.customer_id = Orders.customer_id
INNER JOIN Order_Items ON Orders.order_id = Order_Items.order_id
INNER JOIN Products ON Order_Items.product_id = Products.product_id
WHERE Products.category = 'Electronics';

# 8 Find products that have never been ordered
-- Question: Products never ordered
SELECT p.product_id, p.product_name
FROM Products p
LEFT JOIN Order_Items oi ON p.product_id = oi.product_id
WHERE oi.item_id IS NULL;

# 9 Show all customers and the product names they purchased, including customers with NO purchases
-- Question: Customers and their purchased products, include customers with no orders
SELECT c.name AS customer_name, p.product_name
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
LEFT JOIN Order_Items oi ON o.order_id = oi.order_id
LEFT JOIN Products p ON oi.product_id = p.product_id
ORDER BY c.name;

# 10 List orders with customer name and total order value (sum of price × qty)
-- Question: Show total order value per order with customer name
SELECT o.order_id, c.name AS customer_name, SUM(p.price * oi.quantity) AS total_order_value
FROM Orders o
INNER JOIN Customers c ON o.customer_id = c.customer_id
INNER JOIN Order_Items oi ON o.order_id = oi.order_id
INNER JOIN Products p ON oi.product_id = p.product_id
GROUP BY o.order_id, c.name;
