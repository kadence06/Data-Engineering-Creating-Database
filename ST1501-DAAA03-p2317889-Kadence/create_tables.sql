use SPAI2317889

-----------------------------------------------------------------------------

drop table if  EXISTS Orders;
drop table if EXISTS Model;
drop table if EXISTS Solution;
drop table if EXISTS Customer;
drop table if EXISTS Employee;
drop table if EXISTS Dataset;
drop table if EXISTS ModelType;



create table Customer (
    CustID VARCHAR(255) NOT NULL PRIMARY KEY,
    Last_Name VARCHAR(255),
    First_Name VARCHAR(255),
    CompanyName VARCHAR(255),
    Contact VARCHAR(255)
);

insert into Customer (CustID, First_Name, Last_Name, Contact, CompanyName)
values
('c1231', 'Macie', 'Chew', '21313445', 'Power AI Ltd.'),
('c2231', 'June', 'Gu', '23591312', 'Fish and Dogs'),
('c3231', 'Miller', 'Wu', '34513265', 'Smart Commute'),
('c4231', 'Paul', 'Halim', '11390442', 'B&C Furniture'),
('c5231', 'Bella', 'Tan', '75813435', 'City Drainage'),
('c6231', 'Kiara', 'Sakura', '24634521', 'City Power'),
('c7231', 'Bowen', 'Han', '75643524', 'Country Development');

-----------------------------------------------------------------------------

create table Employee (
    EmployeeID VARCHAR(255) NOT NULL PRIMARY KEY,
    Last_Name VARCHAR(255),
    First_Name VARCHAR(255),
    Contact VARCHAR(255),
    Gender CHAR(1)
);

insert into Employee (EmployeeID, First_Name, Last_Name, Contact, Gender)
values
('s1111', 'Peter', 'Phua', '142524124', 'M'),
('s2222', 'George', 'Mason', '344324251', 'M'),
('s3333', 'Francis', 'Lee', '234235246', 'M'),
('s4444', 'Alice', 'Wong', '324567342', 'F'),
('s5555', 'William', 'Chong', '893456114', 'M'),
('s6666', 'Brilliant', 'Dior', '907456251', 'F');

-----------------------------------------------------------------------------

create table Dataset (
    DatasetID VARCHAR(255) NOT NULL PRIMARY KEY,
    Name VARCHAR(255)
);

insert into Dataset (DatasetID, Name)
values
('d1', 'Adult'),
('d2', 'River'),
('d3', 'Arizona'),
('d4', 'Vermont'),
('d5', 'Covertype'),
('d6', 'Iris');

-----------------------------------------------------------------------------

create table ModelType (
    ModelCode VARCHAR(255) NOT NULL PRIMARY KEY,
    Model_Type VARCHAR(50),
);

insert into ModelType (ModelCode, Model_Type)
values 
('DT', 'Decision Tree'),
('NN', 'Neural Network'),
('LogR', 'Logistic Regression'),
('RF', 'Random Forest'),
('SVM', 'Support Vector Machine'),
('NB', 'Naive Bayes'),
('LR', 'Linear Regression'),
('kNN', 'k-Nearest Neighbour');

-----------------------------------------------------------------------------

create table Model (
    ModelID VARCHAR(255) NOT NULL PRIMARY KEY,
    ModelCode VARCHAR(255),
    Training_Date DATE,
    Accuracy DECIMAL(5,2),
    ParentModelID VARCHAR(255),
    DatasetID VARCHAR(255),
	FOREIGN KEY (ModelCode) REFERENCES ModelType(ModelCode),
    FOREIGN KEY (ParentModelID) REFERENCES Model(ModelID),
    FOREIGN KEY (DatasetID) REFERENCES Dataset(DatasetID)
);

insert into Model (ModelID, ModelCode, Training_Date, Accuracy, ParentModelID, DatasetID)
values
('m1000','DT','2024-01-01',95.6,NULL,'d1'),
('m1001', 'LR','2024-01-05',60.4,NULL,'d2'),
('m1002','RF','2024-01-07',95.3,NULL,'d3'),
('m1003','DT','2024-01-08',53.2,NULL,'d4'),
('m1004','LR','2024-01-11',52.9,NULL,'d2'),
('m1005','LR','2024-01-15',91.7,'m1001','d5'),
('m1006','RF','2024-01-17',85.7,NULL, 'd3'),
('m1007','kNN','2024-01-22',85.7,NULL, 'd5'),
('m1008','SVM','2024-01-23',50.6,NULL, 'd3'),
('m1009','kNN','2024-01-24',51.9,'m1007','d2'),
('m1010','DT','2024-01-27',93.7,'m1003','d2'),
('m1011','SVM','2024-01-30',83.1,NULL,'d4'),
('m1012','SVM','2024-02-06',97.6,'m1011','d2'),
('m1013','kNN','2024-02-07',90.3,'m1009','d2'),
('m1014','kNN','2024-02-08',59.3,NULL,'d2'),
('m1015','RF','2024-02-12',59.4,'m1006','d6'),
('m1016','NB','2024-03-04',70.6,NULL,'d3'),
('m1017','NN','2024-03-06',95.5,NULL,'d6'),
('m1018','LogR','2024-03-12',54.1,NULL,'d2'),
('m1019','NN','2024-03-15',96.8,NULL,'d6'),
('m1020','NN','2024-03-17',85.5,'m1019','d4'),
('m1021','LogR','2024-03-21',60.2,NULL,'d5'),
('m1022','RF','2024-03-22',67.1,NULL, 'd4'),
('m1023','NN','2024-03-27',90.5,'m1020','d6'),
('m1024','RF','2024-03-28',85.9,'m1015','d3');

-----------------------------------------------------------------------------

create table Orders (
    OrderID VARCHAR(255) NOT NULL PRIMARY KEY,
    ReqAccu BIT, 
    Completion_Date DATE,
    Model_Type CHAR(50),
    CustID VARCHAR(255),
    OrderDate DATE,
    FOREIGN KEY (CustID) REFERENCES Customer(CustID)
);

insert into Orders (OrderID, ReqAccu, Completion_Date, Model_Type, CustID, OrderDate)
values
('o080214', 1, '2024-04-22', 'Decision Tree', 'c5231', '2024-04-21'),
('o241134', 1, '2024-07-01', NULL, 'c7231', '2024-05-01'),
('o214132', 0, '2024-05-01', 'Logistic Regression', 'c7231', '2024-04-08'),
('o174143', 1, '2024-04-18', NULL, 'c7231', '2024-04-14'),
('o22031', 0, '2024-04-27', NULL, 'c2231', '2024-04-05'),
('o31421', 1, '2025-01-01', NULL, 'c6231', '2024-04-11'),
('o00001', 1, '2024-05-31', 'Support Vector Machine,Random Forest', 'c1231', '2024-05-02'),
('o11213', 1, '2024-04-11', 'Support Vector Machine', 'c1231', '2024-04-03'),
('o12345', 1, '2024-06-30', NULL, 'c3231', '2024-04-05'),
('o12346', 1, '2024-04-30', NULL, 'c3231', '2024-04-05');

-----------------------------------------------------------------------------

create table Solution (
    OrderID VARCHAR(255),
    ModelID VARCHAR(255),
    EmployeeID VARCHAR(255),
    AssignmentDate DATE,
    PRIMARY KEY (OrderID, ModelID, EmployeeID),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
    FOREIGN KEY (ModelID) REFERENCES Model(ModelID)
);

insert into Solution(OrderID, ModelID, EmployeeID, AssignmentDate)
values
('o080214', 'm1018', 's2222', '2024-04-22'),
('o080214', 'm1003', 's3333', '2024-04-22'),
('o080214', 'm1010', 's4444', '2024-04-22'),
('o214132', 'm1021', 's5555', '2024-04-09'),
('o174143', 'm1008', 's4444', '2024-04-14'),
('o22031', 'm1013', 's1111', '2024-04-11'),
('o22031', 'm1013', 's3333', '2024-04-12'),
('o22031', 'm1013', 's2222', '2024-04-15'),
('o22031', 'm1013', 's4444', '2024-04-07'),
('o22031', 'm1013', 's6666', '2024-04-27'),
('o22031', 'm1013', 's5555', '2024-04-28'),
('o22031', 'm1022', 's1111', '2024-04-19'),
('o31421', 'm1001', 's2222', '2024-04-15'),
('o31421', 'm1002', 's2222', '2024-04-15'),
('o00001', 'm1012', 's1111', '2024-05-02'),
('o00001', 'm1022', 's6666', '2024-05-02'),
('o00001', 'm1013', 's5555', '2024-05-02'),
('o11213', 'm1003', 's3333', '2024-04-10'),
('o11213', 'm1011', 's3333', '2024-04-08'),
('o11213', 'm1012', 's3333', '2024-04-09'),
('o11213', 'm1012', 's4444', '2024-04-04'),
('o12345', 'm1018', 's1111', '2024-05-31'),
('o12345', 'm1019', 's3333', '2024-05-31'),
('o12346', 'm1015', 's2222', '2024-05-31'),
('o12346', 'm1023', 's4444', '2024-05-31'),
('o12346', 'm1021', 's6666', '2024-05-31');

-----------------------------------------------------------------------------
