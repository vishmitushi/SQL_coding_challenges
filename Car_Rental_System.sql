create database Car_rental_system;
use Car_rental_system;

create table vehicle(
vehicleid int primary key,
make varchar(50) not null,
model varchar(50) not null,
year int not null,
dailyrate decimal(10,2) not null,
status bit not null,
passengerCapacity int not null,
engineCapacity int not null,
);

create table customer(
customerid int primary key,
firstname varchar(50) not null,
lastname varchar(50) not null,
email varchar(50) unique,
phonenumber char(15) unique,
);

select top 1 l.leaseid,p.paymentamount,c.firstname,c.lastname from lease as l 
join payment as p on l.leaseid = p.leaseid
join customer as c on c.customerid = l.customerid
order by p.paymentamount desc;

create table lease(
leaseid int primary key,
vehicleid int foreign key(vehicleid) references vehicle(vehicleid) on delete cascade,
customerid int foreign key(customerid) references customer(customerid) on delete cascade,
startdate date,
enddate date,
type varchar(50) check (type IN ('Daily', 'Monthly')),
);

select top 1 l.*,p.* from lease as l
join payment as p on p.leaseid = l.leaseid
order by p.paymentamount desc;

select * from lease where leaseid in (select leaseid from payment having paymentamount = max(paymentamount);

-- total payments by each customer

create table payment(
paymentid int primary key,
leaseid int foreign key(leaseid) references lease(leaseid) on delete cascade,
paymentdate date not null,
paymentamount decimal(10,2) not null,
);

insert into vehicle values 
    (1, 'Toyota', 'Camry', 2022, 50.00, 1, 4, 1450),
    (2, 'Honda', 'Civic', 2023, 45.00, 1, 7, 1500),
    (3, 'Ford', 'Focus', 2022, 48.00, 0,4, 1400),
    (4, 'Nissan', 'Altima', 2023, 52.00, 1, 7, 1200),
    (5, 'Chevrolet', 'Malibu', 2022, 47.00, 1, 4, 1800),
    (6, 'Hyundai', 'Sonata', 2023, 49.00, 0, 7, 1400),
    (7, 'BMW', '3 Series', 2023, 60.00, 1, 7, 2499), 
    (8, 'Mercedes', 'C-Class', 2022, 58.00, 1, 8, 2499),
    (9, 'Audi', 'A4', 2022, 55.00, 0, 4, 2599),
    (10, 'Lexus', 'ES', 2023, 54.00, 1, 4, 2500);

INSERT INTO customer VALUES 
 (1, 'John', 'Doe', 'johndoe@example.com', '555-555-5555'),
 (2, 'Jane', 'Smith', 'janesmith@example.com', '555-123-4567'),
 (3, 'Robert', 'Johnson', 'robert@example.com', '555-789-1234'),
 (4, 'Sarah', 'Brown', 'sarah@example.com', '555-456-7890'),
 (5, 'David', 'Lee', 'david@example.com', '555-987-6543'),
 (6, 'Laura', 'Hall', 'laura@example.com', '555-234-5678'),
 (7, 'Michael', 'Davis', 'michael@example.com', '555-876-5432'),
 (8, 'Emma', 'Wilson', 'emma@example.com', '555-432-1098'),
 (9, 'William', 'Taylor', 'william@example.com', '555-321-6547'),
 (10, 'Olivia', 'Adams', 'olivia@example.com', '555-765-4321');

INSERT INTO lease values
    (1, 1, 1, '2023-01-01', '2023-01-05', 'Daily'),
    (2, 2, 2, '2023-02-15', '2023-02-28', 'Monthly'),
    (3, 3, 3, '2023-03-10', '2023-03-15', 'Daily'),
    (4, 4, 4, '2023-04-20', '2023-04-30', 'Monthly'),
    (5, 5, 5, '2023-05-05', '2023-05-10', 'Daily'),
    (6, 4, 3, '2023-06-15', '2023-06-30', 'Monthly'),
    (7, 7, 7, '2023-07-01', '2023-07-10', 'Daily'),
    (8, 8, 8, '2023-08-12', '2023-08-15', 'Monthly'),
    (9, 3, 3, '2023-09-07', '2023-09-10', 'Daily'),
    (10, 10, 10, '2023-10-10', '2023-10-31', 'Monthly');

insert into lease values (11,4,5,'2023-07-01', '2023-07-10','Monthly');
insert into lease values (12,5,6,'2023-07-01', '2023-07-10','Monthly');
select * from lease;

insert into payment values
(1, 1, '2023-01-03', 200.00),
(2, 2, '2023-02-20', 1000.00),
(3, 3, '2023-03-12', 75.00 ),
(4, 4, '2023-04-25', 900.00),
(5, 5, '2023-05-07', 60.00),
(6, 6, '2023-06-18', 1200.00),
(7, 7, '2023-07-03', 40.00),
(8, 8, '2023-08-14', 1100.00),
(9, 9, '2023-09-09', 80.00),
(10 ,10 ,'2023-10-25', 1500.00);

insert into payment values (11,11,'2023-11-22',300);

-- 1. Update the daily rate for a Mercedes car to 68.
update vehicle
set dailyrate = 68
where make = 'Mercedes';

-- 2. Delete a specific customer and all associated leases and payments.
delete from customer
where customerid=1;

-- 3. Rename the "paymentDate" column in the Payment table to "transactionDate".
EXEC sp_rename 'Payment.paymentDate', 'transactionDate';


-- 4. Find a specific customer by email.
select * from customer
where email='emma@example.com';

-- 5. Get active leases for a specific customer.
SELECT * FROM Lease
WHERE customerID = 5
AND endDate >= GETDATE();

-- 6. Find all payments made by a customer with a specific phone number.
SELECT Payment.*, Lease.startDate, Lease.endDate, Vehicle.make, Vehicle.model
FROM Payment
 JOIN Lease ON Payment.leaseID = Lease.leaseID
JOIN Vehicle ON Lease.vehicleID = Vehicle.vehicleID
 JOIN Customer ON Lease.customerID = Customer.customerID
WHERE Customer.phoneNumber = '555-987-6543';


-- 7. Calculate the average daily rate of all available cars.
SELECT AVG(dailyrate) AS avgDailyRate
FROM Vehicle
WHERE status = 1;

-- 8. Find the car with the highest daily rate.
SELECT *
FROM Vehicle
ORDER BY dailyRate DESC
OFFSET 0 ROWS
FETCH NEXT 1 ROWS ONLY;

-- 9. Retrieve all cars leased by a specific customer.
SELECT Vehicle.*,firstname +' '+ lastname as Customername
FROM Vehicle
JOIN lease ON Vehicle.vehicleID = Lease.vehicleID
JOIN Customer ON Lease.customerID = Customer.customerID
WHERE lease.customerid = 5;

-- 10. Find the details of the most recent lease.
SELECT *
FROM Lease
ORDER BY startDate DESC
OFFSET 0 ROWS
FETCH NEXT 1 ROWS ONLY;

-- 11. List all payments made in the year 2023.
SELECT *
FROM Payment
WHERE YEAR([transactionDate]) = 2023;

-- 12. Retrieve customers who have not made any payments.
SELECT * FROM Customer
WHERE customerid NOT IN (SELECT DISTINCT customerid FROM payment);

-- 13. Retrieve Car Details and Their Total Payments.
SELECT
    Vehicle.vehicleID,
    Vehicle.make,
    Vehicle.model,
    Vehicle.year,
    Vehicle.dailyRate,
    Vehicle.status,
    Vehicle.passengerCapacity,
    Vehicle.engineCapacity,
    SUM(Payment.paymentamount) AS totalPayments
FROM
    Vehicle
LEFT JOIN Lease ON Vehicle.vehicleID = Lease.vehicleID
LEFT JOIN Payment ON Lease.leaseID = Payment.leaseID
GROUP BY
    Vehicle.vehicleID,
    Vehicle.make,
    Vehicle.model,
    Vehicle.year,
    Vehicle.dailyRate,
    Vehicle.status,
    Vehicle.passengerCapacity,
    Vehicle.engineCapacity;

-- 14. Calculate Total Payments for Each Customer.
SELECT
    Customer.customerID,
    Customer.firstName,
    Customer.lastName,
    SUM(Payment.paymentamount) AS totalPayments
FROM
    Customer
LEFT JOIN Lease ON Customer.customerID = Lease.customerID
LEFT JOIN Payment ON Lease.leaseID = Payment.leaseID
GROUP BY
    Customer.customerID,
    Customer.firstName,
    Customer.lastName;

-- 15. List Car Details for Each Lease.
SELECT 
	Lease.leaseID,
	Lease.vehicleID,
	Lease.customerID,
	Lease.startDate,
	Lease.endDate,
	Lease.type,
	Vehicle.make,
	Vehicle.model,
	Vehicle.dailyRate,
	Vehicle.status,
	Vehicle.passengerCapacity,
	Vehicle.engineCapacity
FROM Lease
JOIN Vehicle ON Lease.vehicleID = Vehicle.vehicleID;

-- 16. Retrieve Details of Active Leases with Customer and Car Information.
SELECT Lease.*, Customer.firstName, Customer.lastName, Vehicle.make, Vehicle.model
FROM Lease
JOIN Customer ON Lease.customerID = Customer.customerID
JOIN Vehicle ON Lease.vehicleID = Vehicle.vehicleID
WHERE endDate >= GETDATE();

-- 17. Find the Customer Who Has Spent the Most on Leases.
SELECT
    Customer.customerID,
    Customer.firstName,
    Customer.lastName,
    SUM(Payment.paymentamount) AS totalPayments
FROM
    Customer
LEFT JOIN Lease ON Customer.customerID = Lease.customerID
LEFT JOIN Payment ON Lease.leaseID = Payment.leaseID
GROUP BY
    Customer.customerID, Customer.firstName, Customer.lastName
ORDER BY
    totalPayments DESC
OFFSET 0 ROWS
FETCH NEXT 1 ROWS ONLY;

-- 18. List All Cars with Their Current Lease Information.
SELECT Vehicle.*, Lease.startDate, Lease.endDate, Customer.firstName, Customer.lastName
FROM Vehicle
LEFT JOIN Lease ON Vehicle.vehicleID = Lease.vehicleID
LEFT JOIN Customer ON Lease.customerID = Customer.customerID


select * from vehicle;
select * from payment;
select * from customer;
select * from lease;

-- car details for each lease
select * from vehicle as v
join lease as l on l.vehicleid=v.vehicleid


-- highest daily rate
select top 1 * from vehicle as v
order by dailyrate desc;

select * from vehicle;

-- specific customer payment
select c.firstname,p.paymentamount from customer as c
join lease as l on l.customerid = c.customerid
join payment as p on p.leaseid = l.leaseid
where c.phonenumber = '555-987-6543'

select * from customer
select * from payment
select * from lease

select c.firstname,l.vehicleid,l.enddate from customer as c 
join lease as l on l.customerid = c.customerid
where l.enddate > GETDATE();