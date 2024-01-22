CREATE DATABASE IF NOT EXISTS lab_mysql;

USE lab_mysql;

DROP TABLE IF EXISTS cars;

CREATE TABLE cars (
vehicle_ID INT PRIMARY KEY UNIQUE NOT NULL,
manufacturer VARCHAR(20),
model VARCHAR(20),
year DATETIME,
color VARCHAR(20));

DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
customer_ID INT PRIMARY KEY UNIQUE NOT NULL,
name VARCHAR(20), 
phone_number INT,
email_address VARCHAR(20),
city VARCHAR(20),
state_province VARCHAR(20),
country VARCHAR(20),
postal_code VARCHAR(20));

DROP TABLE IF EXISTS sales_person;

CREATE TABLE sales_person (
staff_ID INT PRIMARY KEY UNIQUE NOT NULL,
name VARCHAR(20),
store VARCHAR(20));

DROP TABLE IF EXISTS invoice;

CREATE TABLE invoice (
invoice_num INT PRIMARY KEY UNIQUE NOT NULL,
date DATETIME,
car VARCHAR(20),
customer VARCHAR(20),
salesperson VARCHAR(20),
staff_ID INT,
customer_ID INT,
vehicle_ID INT);

ALTER TABLE invoice
ADD CONSTRAINT fk_staff_id
FOREIGN KEY (staff_ID) REFERENCES sales_person(staff_ID);

ALTER TABLE invoice
ADD CONSTRAINT fk_cust_id
FOREIGN KEY (customer_ID) REFERENCES customers(customer_ID);

ALTER TABLE invoice
ADD CONSTRAINT fk_cars_id
FOREIGN KEY (vehicle_ID) REFERENCES cars(vehicle_ID);


