
DROP DATABASE IF EXISTS `WIA2001GroupProject`;
CREATE DATABASE `WIA2001GroupProject`;
USE `WIA2001GroupProject`;

# The language we used in SQL code is Oracle SQL
## We have 20 entities

# Create 20 Entities
## Create Users entity
CREATE TABLE Users ( 
user_id INT PRIMARY KEY NOT NULL, 
username VARCHAR(64), 
email VARCHAR(64), 
password VARCHAR(12), 
status VARCHAR(10), 
login_date VARCHAR(64) 
);

## Create Customer entity
CREATE TABLE Customer ( 
customer_id VARCHAR(5) PRIMARY KEY NOT NULL, 
user_id INT, 
gender VARCHAR(6), 
address VARCHAR(128), 
city VARCHAR(32), 
zip_code VARCHAR(5), 
CONSTRAINT fk_Users_Customer_user_id FOREIGN KEY(user_id) REFERENCES Users(user_id) 
);

## Create Owner entity
CREATE TABLE Owner ( 
owner_id VARCHAR(6) PRIMARY KEY NOT NULL, 
address VARCHAR(128), 
user_id INT, 
CONSTRAINT fk_Users_Owner_user_id FOREIGN KEY(user_id) REFERENCES Users(user_id) 
);

## Create Role entity
CREATE TABLE Role ( 
role_id varchar(3) PRIMARY KEY NOT NULL, 
role_name varchar(64) 
);

## Create User_Has_Role entity
CREATE TABLE User_Has_Role( 
role_id VARCHAR(3) NOT NULL, 
user_id INT NOT NULL, 
CONSTRAINT fk_role_role_id FOREIGN KEY (role_id) REFERENCES Role(role_id) , 
CONSTRAINT fk_Users_user_id FOREIGN KEY (user_id) REFERENCES Users(user_id) 
);

## Create Salary_position entity
Create Table Salary_position(
position_name VARCHAR(64) PRIMARY KEY, 
base_rate FLOAT NOT NULL, 
overtime_rate FLOAT NOT NULL 
);

## Create Position entity
Create Table `Position`( 
position_id VARCHAR(3) NOT NULL PRIMARY KEY, 
position_name VARCHAR(64) NOT NULL, 
CONSTRAINT fk_Salary_position_name FOREIGN KEY(position_name)REFERENCES Salary_position(position_name) 
);

## Create Staff entity
CREATE TABLE Staff ( 
staff_id VARCHAR(5) PRIMARY KEY NOT NULL, 
user_id INT, 
position_id VARCHAR(3), 
staff_name VARCHAR(64), 
staff_no INT, 
ic_no VARCHAR(14), 
gender VARCHAR(6), 
address VARCHAR(128), 
city VARCHAR(32), 
zip_code VARCHAR(5), 
CONSTRAINT FK_Users_Staff_user_id FOREIGN KEY (user_id) REFERENCES Users (user_id), 
CONSTRAINT FK_Users_Staff_position_id FOREIGN KEY (position_id) REFERENCES Position (position_id) 
);

## Create Supplier_contract entity
CREATE TABLE Supplier_contract( 
contract_id VARCHAR(6) PRIMARY KEY NOT NULL, 
contract_description VARCHAR(128) NOT NULL, 
start_date VARCHAR(64) NOT NULL, 
end_date VARCHAR(64) DEFAULT('current') NOT NULL 
);

## Create Supplier_order_product entity
CREATE TABLE Supplier_order_product( 
serial_no VARCHAR(6) PRIMARY KEY NOT NULL, 
quantity INT DEFAULT(0) NOT NULL, 
price_per_unit FLOAT NOT NULL
);

## Create Supplier_order entity
CREATE TABLE Supplier_order( 
supplier_order_id VARCHAR(6) PRIMARY KEY NOT NULL, 
total_amount FLOAT NOT NULL, 
serial_no VARCHAR(6) NOT NULL, 
CONSTRAINT fk_Supplier_serial_no FOREIGN KEY(serial_no) REFERENCES Supplier_order_product(serial_no) 
);

## Create PIC entity
CREATE TABLE PIC( 
pic_name VARCHAR(64) NOT NULL PRIMARY KEY, 
pic_phone VARCHAR(16) NOT NULL 
);

## Create Supplier entity
CREATE TABLE Supplier( 
supplier_id VARCHAR(4) PRIMARY KEY NOT NULL, 
supplier_name VARCHAR(64) NOT NULL, 
address VARCHAR(128) NOT NULL, 
pic_name VARCHAR(64) NOT NULL, 
contract_id VARCHAR(6) NOT NULL, 
supplier_order_id VARCHAR(6) NOT NULL, 
CONSTRAINT fk_supplier_contract_id FOREIGN KEY(contract_id) REFERENCES Supplier_contract(contract_id), 
CONSTRAINT fk_order_supplier_order_id FOREIGN KEY(supplier_order_id) REFERENCES Supplier_order(supplier_order_id) 
);

## Create Product entity
Create Table Product ( 
prod_id VARCHAR(6) PRIMARY KEY, 
supplier_id VARCHAR(4) NOT NULL, 
serial_no VARCHAR(6) NOT NULL, 
name VARCHAR(128), 
type VARCHAR(128), 
price_per_quantity FLOAT NOT NULL, 
CONSTRAINT fk_prod_supplier_id FOREIGN KEY(supplier_id) REFERENCES Supplier(supplier_id) 
);

## Create Product_order entity
CREATE TABLE Product_order( 
Numbers INT PRIMARY KEY NOT NULL, 
order_id VARCHAR(4), 
prod_id VARCHAR(6) NOT NULL, 
payment_id VARCHAR(6) NOT NULL, 
quantity INT NOT NULL, amount FLOAT NOT NULL, 
CONSTRAINT fk_prod_id FOREIGN KEY(prod_id) REFERENCES Product(prod_id) 
);

## Create Payment entity
CREATE TABLE Payment( 
payment_id VARCHAR(6) PRIMARY KEY, 
customer_id VARCHAR(6) NOT NULL, 
payment_method VARCHAR(64) DEFAULT('CASH') NOT NULL 
);

## Create Service_name_card entity
CREATE TABLE Service_name_card( 
service_description VARCHAR(128) NOT NULL, 
price FLOAT NOT NULL,
type_of_card VARCHAR(64), 
layout VARCHAR(32), 
size_of_card VARCHAR(16), 
quantity_card INT, 
payment_id VARCHAR(6), 
CONSTRAINT fk_name_card_payment_id FOREIGN KEY(payment_id) REFERENCES Payment(payment_id) 
);

## Create Service_photostat_printing entity
CREATE TABLE Service_photostat_printing( 
service_description VARCHAR(128) NOT NULL, 
price FLOAT NOT NULL, 
type_of_paper VARCHAR(64), 
color_ofpaper VARCHAR(32), 
size_of_paper VARCHAR(16), 
payment_id VARCHAR(6), 
CONSTRAINT FK_payment_id FOREIGN KEY(payment_id) REFERENCES Payment(payment_id) 
);

## Create Service_laminating entity
CREATE TABLE Service_laminating( 
service_description VARCHAR(128), 
price FLOAT NOT NULL, 
size_of VARCHAR(16), 
payment_id VARCHAR(6), 
CONSTRAINT fk_laminating_payment_id FOREIGN KEY(payment_id) REFERENCES Payment(payment_id) 
);

## Create Service_rubber_stamp entity
CREATE TABLE Service_rubber_stamp( 
service_description VARCHAR(64), 
price FLOAT NOT NULL, 
shape_of VARCHAR(32) DEFAULT('DEFAULT') NOT NULL, 
size_of VARCHAR(16), 
type_of VARCHAR(64) DEFAULT('DEFAULT') NOT NULL, 
payment_id VARCHAR(6), 
CONSTRAINT fk_rubber_stamp_payment_id FOREIGN KEY(payment_id) REFERENCES Payment(payment_id) 
);

## -----------------------------------------------------------------------------------------------------------------------

# Insert
## Insert into Users entity
INSERT INTO Users 
VALUES(1,'Eng Kit Ang', 'KitAng1994@gmail.com', '********', 'online', '12-12-2022'); 
INSERT INTO Users 
VALUES(2,'Ali Yusuf', 'Ali233@gmail.com', '**********', 'offline', '12-12-2022'); 
INSERT INTO Users 
VALUES(3,'Eric Eng', 'ericeng02@gmail.com', '**********', 'online', '12-12-2022'); 
INSERT INTO Users 
VALUES(4,'Jun Bin', 'junbin123@gmail.com', '************', 'offline', '12-12-2022');

## Insert into Customer entity
INSERT INTO Customer 
VALUES('C0001',2,'Male','Ipoh, Perak', 'Perak', '30300'); 
INSERT INTO Customer 
VALUES('C0002',4,'Male','Ipoh, Perak', 'Perak', '30250');

## Insert into Owner entity
INSERT INTO Owner 
VALUES('AD0001', 'Ipoh, Perak',1);

## Insert into Role entity
INSERT INTO Role 
VALUES('R01', 'Customer'); 
INSERT INTO Role 
VALUES('R02', 'Owner'); 
INSERT INTO Role 
VALUES('R03', 'Staff'); 
INSERT INTO Role 
VALUES('R04', 'Supplier');

## Insert into User_Has_Role entity
INSERT INTO User_Has_Role 
VALUES('R02', 1); 
INSERT INTO User_Has_Role 
VALUES('R01', 2); 
INSERT INTO User_Has_Role 
VALUES('R03', 3); 
INSERT INTO User_Has_Role 
VALUES('R01', 4);

## Insert into Salary_position entity
INSERT INTO Salary_position 
VALUES('Cleaner', 2000, 2250); 
INSERT INTO Salary_position 
VALUES('Accountant', 2500, 2500); 
INSERT INTO Salary_position 
VALUES('Counter Servicer', 1500, 1500); 
INSERT INTO Salary_position 
VALUES('Salesman', 1500, 2000); 
INSERT INTO Salary_position 
VALUES('Stationery Worker', 2000, 2000); 
INSERT INTO Salary_position 
VALUES('Cargo Mover', 2000, 2100); 
INSERT INTO Salary_position 
VALUES('Name Card Servicer', 1500, 1500); 
INSERT INTO Salary_position 
VALUES('Photostat Servicer', 1500, 1500); 
INSERT INTO Salary_position 
VALUES('Rubber Stamp Servicer', 1500, 1500); 
INSERT INTO Salary_position 
VALUES('Laminating Servicer', 1500, 1500);

## Insert into Position entity
INSERT INTO Position 
VALUES('P01', 'Cleaner'); 
INSERT INTO Position 
VALUES('P02', 'Accountant');
INSERT INTO Position 
VALUES('P03', 'Counter Servicer'); 
INSERT INTO Position 
VALUES('P04', 'Salesman'); 
INSERT INTO Position 
VALUES('P05', 'Stationery Worker'); 
INSERT INTO Position 
VALUES('P06', 'Cargo Mover'); 
INSERT INTO Position 
VALUES('P07', 'Name Card Servicer'); 
INSERT INTO Position 
VALUES('P08', 'Photostat Servicer'); 
INSERT INTO Position 
VALUES('P09', 'Rubber Stamp Servicer'); 
INSERT INTO Position 
VALUES('P10', 'Laminating Servicer');

## Insert into Staff entity
INSERT INTO Staff 
VALUES('S0001', 3, 'P03', 'Eric Eng', 1, '020101-12-1333', 'Male', 'Ipoh, Perak', 'Perak', '30300');

## Insert into Supplier_contract entity
INSERT INTO Supplier_contract(contract_id, contract_description, start_date) 
VALUES('145566', 'Paper distributor', '12/1/2009'); 
INSERT INTO Supplier_contract(contract_id, contract_description, start_date) 
VALUES('123102', 'Stationery supplier', '16/8/2007'); 
INSERT INTO Supplier_contract(contract_id, contract_description, start_date) 
VALUES('131602', 'Paper distributor', '5/3/2017'); 
INSERT INTO Supplier_contract 
VALUES('102322', 'Stationery supplier', '31/12/2002', '31/1/2004');

## Insert into Supplier_order_product entity
INSERT INTO Supplier_order_product 
VALUES('151515', 50, 14); 
INSERT INTO Supplier_order_product 
VALUES('233267', 60, 13.6); 
INSERT INTO Supplier_order_product 
VALUES('429323', 120, 0.7); 
INSERT INTO Supplier_order_product 
VALUES('678900', 300, 0.7); 
INSERT INTO Supplier_order_product 
VALUES('832970', 100, 1.5); 
INSERT INTO Supplier_order_product 
VALUES('561006', 100, 1.2);

## Insert into Supplier_order entity
INSERT INTO Supplier_order 
VALUES('A002', 1516, '151515'); 
INSERT INTO Supplier_order 
VALUES('S005', 64, '429323'); 
INSERT INTO Supplier_order 
VALUES('FW300', 3120, '678900'); 
INSERT INTO Supplier_order 
VALUES('YB500', 270, '832970');

## Insert into PIC entity
INSERT INTO PIC 
VALUES('Hugo Show', '016-242 2665'); 
INSERT INTO PIC 
VALUES('Kok Tung Lee', '05-241 2642'); 
INSERT INTO PIC 
VALUES('Ho Kai Chong', '011-2320 8087'); 
INSERT INTO PIC 
VALUES('Wong Yan Yan', '011-1060 3029');

## Insert into Supplier entity
INSERT INTO Supplier 
VALUES('2345', 'pelangi', 'Puchong, Selangor', 'Hugo Show', '145566', 'A002'); 
INSERT INTO Supplier 
VALUES('1276', 'magnum', 'Ipoh, Perak', 'Kok Tung Lee', '123102', 'S005'); 
INSERT INTO Supplier 
VALUES('8876', 'Lucky Star', 'Kuala Lumpur', 'Ho Kai Chong', '131602', 'FW300'); 
INSERT INTO Supplier 
VALUES('1456', 'Faber Castell', 'Seremban, Negeri Sembilan', 'Wong Yan Yan', '102322', 'YB500');
INSERT INTO Product 
VALUES('P00003', '8876', '832970', 'A4 paper', 'A4 paper', 2.20); 
INSERT INTO Product 
VALUES('P00004', '1456', '233267', 'Faber Castell Colour Pencil', 'Colour Pencil', 18.0);

## Insert into Product entity
INSERT INTO Product 
VALUES('P00001', '2345', '151515', 'SPM Math', 'Exercise Book', 19.90); 
INSERT INTO Product 
VALUES('P00002', '1276', '429323', 'Gel Red Pen', 'Red Pen', 1.00);

## Insert into Product_order entity
INSERT INTO Product_order 
VALUES(1, '1000', 'P00001', '1', 1, 19.90); 
INSERT INTO Product_order 
VALUES(2, '1000', 'P00002', '1', 4, 4.00); 
INSERT INTO Product_order 
VALUES(3, '1000', 'P00003', '1', 2, 4.40); 
INSERT INTO Product_order 
VALUES(4, '1001', 'P00004', '2', 1, 18.00);

## Insert into Payment entity
INSERT INTO Payment 
VALUES('1000', 'C0001', 'Touch and Go'); 
INSERT INTO Payment(payment_id, customer_id) 
VALUES('1001', 'C0002');

## Insert into Service_name_card entity
INSERT INTO Service_name_card 
VALUES('picture.jpg', 10.00, 'Default', 'Default', 'Default', 1, '1000');

## Insert into Service_photostat_printing entity
INSERT INTO Service_photostat_printing 
VALUES('book.pdf', 13.20, 'A4 paper', 'Black white', 'Default', '1000');

## Insert into Service_laminating entity
INSERT INTO Service_laminating 
VALUES('picture.png', 15.00, 'Default', '1001');

## Insert into Service_rubber_stamp entity
INSERT INTO Service_rubber_stamp 
VALUES('assignment', 18.80, 'Default', '5cm x 2cm', 'Default', '1001');

## -----------------------------------------------------------------------------------------------------------------------