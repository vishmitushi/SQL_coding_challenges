create database ecommerce;
use ecommerce;

create table customer(
customer_id int primary key,
firstname varchar(50),
lastname varchar(50),
email varchar(50),
address varchar(50),
);

create table product(
product_id int primary key,
name varchar(50),
description text,
price decimal(10,2),
stockQuantity int
);

select p.name,min(p.stockQuantity) from product as p
group by p.name;

select firstname from customer
where firstname like 'O%';

create table orders(
orderid int primary key,
customerid int foreign key(customerid) references customer(customer_id) on delete cascade,
orderdate date,
totalamount decimal(10,2)
);

select p.product_id from product as p
join cart as c on c.product_id=p.product_id
where p.product_id is null;

select c.customer_id,avg(o.totalamount) as average from orders as o
join customer as c on c.customer_id=o.customerid
group by c.customer_id
order by average;

select sum(o.totalamount) as total_revenue from orders as o
-- percentage wala kuch



create table cart(
cart_id int primary key,
customerid int foreign key(customerid) references customer(customer_id) on delete cascade,
product_id int foreign key(product_id) references product(product_id) on delete cascade,
quantity int
);

create table orderitem(
order_item_id int primary key,
orderid int foreign key(orderid) references orders(orderid) on delete cascade,
product_id int foreign key(product_id) references product(product_id) on delete cascade,
quantity int
);

alter table orderitem add itemAmount DECIMAL(10, 2);

insert into customer values
(1, 'John','Doe', 'johndoe@example.com', '123 Main St, City'), 
(2, 'Jane', 'Smith', 'janesmith@example.com', '456 Elm St, Town'),
(3, 'Robert', 'Johnson', 'robert@example.com', '789 Oak St, Village'),
(4, 'Sarah', 'Brown', 'sarah@example.com', '101 Pine St, Suburb'), 
(5, 'David', 'Lee', 'david@example.com', '234 Cedar St, District' ),
(6, 'Laura', 'Hall', 'laura@example.com', '567 Birch St, County'), 
(7, 'Michael', 'Davis', 'michael@example.com', '890 Maple St, State'),
(8, 'Emma', 'Wilson' , 'emma@example.com', '321 Redwood St, Country'),
(9, 'William', 'Taylor', 'william@example.com', '432 Spruce St, Province'),
(10, 'Olivia','Adams', 'olivia@example.com', '765 Fir St, Territory');

insert into product values
(1, 'Laptop', 'High-performance laptop', 800.00, 10), 
(2, 'Smartphone', 'Latest smartphone', 600.00, 15 ),
(3, 'Tablet', 'Portable tablet', 300.00, 20 ),
(4, 'Headphones', 'Noise-canceling', 150.00, 30), 
(5, 'TV','4K Smart TV', 900.00, 5 ),
(6, 'Coffee Maker', 'Automatic coffee maker', 50.00, 25), 
(7, 'Refrigerator', 'Energy-efficient', 700.00, 10 ),
(8, 'Microwave Oven', 'Countertop microwave', 80.00, 15),
(9, 'Blender', 'High-speed blender', 70.00, 20),
(10, 'Vacuum Cleaner',' Bagless vacuum cleaner', 120.00, 10);

insert into orders values
(1,1,'2023-01-05',1200),
(2,2,'2023-02-10',900),
(3,3,'2023-03-15',300),
(4,4,'2023-04-20',150),
(5,5,'2023-05-25',180),
(6,6,'2023-06-30',400),
(7,7,'2023-07-05',700),
(8,8,'2023-08-10',160),
(9,9,'2023-09-15',140),
(10,10,'2023-10-20',1400);

INSERT INTO cart VALUES
    (1, 1, 1, 2),
    (2, 1, 3, 1),
    (3, 2, 2, 3),
    (4, 3, 4, 4),
    (5, 3, 5, 2),
    (6, 4, 6, 1),
    (7, 5, 1, 1),
    (8, 6, 10, 2),
    (9, 6, 9, 3),
    (10, 7, 7, 2);

INSERT INTO orderitem VALUES
    (1, 1, 1, 2, 1600.00),
    (2, 1, 3, 1, 300.00),
    (3, 2, 2, 3, 1800.00),
    (4, 3, 5, 2, 1800.00),
    (5, 4, 4, 4, 600.00),
    (6, 4, 6, 1, 50.00),
    (7, 5, 1, 1, 800.00),
    (8, 5, 2, 2, 1200.00),
    (9, 6, 10, 2, 240.00),
    (10, 6, 9, 3, 210.00);

-- 1. Update refrigerator product price to 800.
update product set price=800 where name='Refrigerator';
select * from product;

-- 2. Remove all cart items for a specific customer.
delete from cart where customerid = 6;
select * from cart;

-- 3. Retrieve Products Priced Below $100.
SELECT *
FROM PRODUCT
WHERE (price<100.00);

--4) Find Products with Stock Quantity Greater Than 5.
SELECT *
FROM PRODUCT
WHERE (stockQuantity>5);

--5) Retrieve Orders with Total Amount Between $500 and $1000.
SELECT *
FROM ORDERS
WHERE totalamount BETWEEN 500.00 AND 1000.00;

--6)
SELECT *
FROM PRODUCT
WHERE (name LIKE '%r');

--7)

SELECT *
FROM CART
WHERE (customerid=5);

--8)
SELECT DISTINCT CUSTOMER.[firstname],Customer.[lastname], ORDERS.orderdate
FROM CUSTOMER INNER JOIN ORDERS 
ON CUSTOMER.customer_id = ORDERS.customerid
WHERE YEAR(ORDERS.orderdate) = 2023;

--9)

SELECT [name], MIN(stockQuantity) AS min_stock
FROM PRODUCT
GROUP BY [name];

--10)
SELECT CUSTOMER.customer_ID, CUSTOMER.firstname, SUM(ORDERS.totalamount) AS total_amount_spent
FROM CUSTOMER
LEFT JOIN ORDERS ON CUSTOMER.customer_ID = ORDERS.customerid
GROUP BY CUSTOMER.customer_ID, CUSTOMER.firstname;

--11)
SELECT CUSTOMER.customer_ID, CUSTOMER.firstname, avg(ORDERS.totalamount) AS total_amount_spent
FROM CUSTOMER
LEFT JOIN ORDERS ON CUSTOMER.customer_ID = ORDERS.customerid
GROUP BY CUSTOMER.customer_ID, CUSTOMER.firstname;

--12)
SELECT CUSTOMER.customer_ID, CUSTOMER.firstname, COUNT(ORDERS.orderid) AS order_count
FROM CUSTOMER LEFT JOIN ORDERS ON CUSTOMER.customer_ID = ORDERS.customerid
GROUP BY CUSTOMER.customer_ID, CUSTOMER.firstname;

--13)

SELECT CUSTOMER.customer_ID, CUSTOMER.firstname, MAX(ORDERS.totalamount) AS max_order_amount
FROM CUSTOMER LEFT JOIN ORDERS ON CUSTOMER.customer_ID = ORDERS.customerid
GROUP BY CUSTOMER.customer_ID, CUSTOMER.[firstname];

--14)
SELECT CUSTOMER.customer_ID, CUSTOMER.firstname, SUM(ORDERS.[totalamount]) as Total_Order_Amount
FROM CUSTOMER
INNER JOIN ORDERS ON CUSTOMER.customer_ID = ORDERS.customerid
GROUP BY CUSTOMER.customer_ID, CUSTOMER.firstname
HAVING SUM(ORDERS.[totalamount]) > 1000.00;

--15)
SELECT *
FROM PRODUCT
WHERE product_ID NOT IN (SELECT DISTINCT product_id FROM CART);

--16)

SELECT *
FROM CUSTOMER
WHERE customer_ID NOT IN (SELECT DISTINCT customerid FROM ORDERS);

--17)
SELECT PRODUCT.product_ID, PRODUCT.name, 
(SUM(orderitem.itemAmount) / (SELECT SUM(orderitem.itemAmount) FROM orderitem)) * 100 AS percent_Revenue
FROM PRODUCT LEFT JOIN orderitem
ON PRODUCT.product_ID = orderitem.product_id
GROUP BY PRODUCT.product_ID, PRODUCT.name;

--18)
SELECT * 
FROM PRODUCT
WHERE [stockQuantity]=(SELECT MIN(stockQuantity) FROM PRODUCT);

--19)

SELECT * FROM [dbo].[CUSTOMER]
WHERE [customer_ID]=(SELECT [customer_id] FROM [ORDERS] 
WHERE [totalamount]=(SELECT MAX([totalamount]) FROM [ORDERS])
);

-- customer who placed high value order

select * from orders;
select top 1 c.firstname,count(o.customerid) as nooforders,o.totalamount from customer as c
join orders as o on c.customer_id=o.customerid
group by c.firstname,o.totalamount
order by o.totalamount desc; 

-- using subquery
select c.firstname,c.customer_id,o.totalamount from customer as c
where o.totalamount =(select max(o.totalamount) as highest_pay from orders as o)

select customerid,sum(totalamount) from orders
group by customerid
order by sum(totalamount);

select c.* from cart as c
join customer as cus on c.customerid=cus.customer_id
where cus.email = 'janesmith@example.com'

select * from cart 
where customerid = (select customer_id from customer 
where email = 'janesmith@example.com')

select * from customer