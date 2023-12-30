-- Introduction

-- This is the dataset of credit card approval, it will give the information whether customer is aprroved or rejected for credit card. 

-- Data Description:
-- It contain 1548 observation with 19 variabes.

-- ID 				: Client ID
-- Gender 			: Gender Information
-- Car_Owner 		: Having Car or not
-- Property_Owner 	: Having property or not
-- Children_count 	: No of Children
-- Annual_income 	: Annual Income
-- Type_Income 		: Income type
-- Education_level 	: Education Level
-- Marital_status 	: Marital Status
-- Housing_type 	: Living Style
-- Age 				: Age of Client in Days
-- Employed_days 	: No of Employement in days
-- Mobile_phone		: Having Mobile Mobile Phone or not
-- Work_Phone		: Having Work Phone or not
-- Phone			: Having Phone or not
-- Email_id			: Having Email_id or not
-- Type_Occupation 	: Occuaption type
-- Family_Members 	: No of Family members
-- label 			: Application status ( 0 is application approved and 1 is application rejected).  



CREATE DATABASE Credit_Card;			# creating a Database of Credit_Card

USE Credit_card;						# Using this database to perform query 

select * from master_dataset;   		# Name of the original cleaned datset.

-- Applying appropriate normalization techniques (upto 3 NF) to divide it into multiple tables.

-- Creating a Table  `Type_Income` with a new primary key column Type_income_id. This table consists names of the Income type. 
CREATE TABLE Type_Income(
Type_Income_id INT NOT NULL PRIMARY KEY auto_increment ,
Type_Income VARCHAR(30)
);

ALTER TABLE Type_income AUTO_INCREMENT=100;      # using this statement so that the Type_Income_id starts from 100 and increment by 1

-- inserting the distinct value of Type_Income and each value is assigned to Type_Income_id which will be referred later in the Customer table
INSERT INTO Type_Income (Type_Income)
SELECT DISTINCT Type_Income 
FROM master_dataset;             				
                                                    

SELECT * FROM Type_Income;						# viewing the created Type_income table


-- Creating a Table  `Education` with a new primary key column Education_id. This table consists names of the Education level.
CREATE TABLE Education (
Education_id INT NOT NULL PRIMARY KEY auto_increment ,
Education_level VARCHAR(30)
);

-- inserting the distinct value of Education level and each value is assigned to Education_id which will be referred later in the Customer table
INSERT INTO Education (Education_level)
SELECT DISTINCT Education_level 
FROM master_dataset; 

SELECT * FROM Education;			# viewing the created Education table


-- Creating a Table  `Marital_status` with a new primary key column Marital_status_id. This table consists names of the Marital_status.
CREATE TABLE Marital_status(
Marital_status_id INT NOT NULL PRIMARY KEY auto_increment ,
Marital_status VARCHAR(30)
);

-- using this statement so that the Marital_status_id starts from 100 and increment by 1
ALTER TABLE Marital_status AUTO_INCREMENT=100;    


-- inserting the distinct value of Marital_status and each value is assigned to Marital_status_id which will be referred later in the Customer table
INSERT INTO Marital_status (Marital_status)
SELECT DISTINCT Marital_status
FROM master_dataset;             


SELECT * FROM Marital_status;			# viewing the created Marital_status table


-- Creating a Table  `Housing_type` with a new primary key column Housing_type_id. This table consists names of the Housing_type.
CREATE TABLE Housing_type(
Housing_type_id INT NOT NULL PRIMARY KEY auto_increment ,
Housing_type VARCHAR(30)
);

-- using this statement so that the Housing_type_id starts from 100 and increment by 1
ALTER TABLE Housing_type AUTO_INCREMENT=100;      

--  inserting the distinct value of Housing_type and each value is assigned to Housing_type_id which will be referred later in the Customer table
INSERT INTO Housing_type (Housing_type)
SELECT DISTINCT Housing_type
FROM master_dataset;            

SELECT * FROM Housing_type;				# viewing the created Housing_type table


-- Creating a Table  `Occupation` with a new primary key column Occupation_id. This table consists names of the Occupation type.
CREATE TABLE Occupation(
Occupation_id INT NOT NULL PRIMARY KEY auto_increment ,
Occupation VARCHAR(50)
);

-- using this statement so that the Occupation_id starts from 100 and increment by 1
ALTER TABLE Occupation AUTO_INCREMENT=100;      


--  inserting the distinct value of Occupation type and each value is assigned to Occupation_id which will be referred later in the Customer table
INSERT INTO Occupation (Occupation)
SELECT DISTINCT Type_Occupation
FROM master_dataset;             

SELECT * FROM Occupation;				# viewing the created Occupation table


/*
Creation of Whole_data  which is going to contain unique id’s of table which we created with help of various joins.
After creation of link table, we will delete both master_dataset and this table with the help of drop function.
*/

-- Merging of all tables

CREATE TABLE Whole_data AS(
SELECT * FROM master_dataset M
JOIN Type_Income 
USING (Type_Income)
JOIN Education 
USING (Education_level)
JOIN Marital_status
USING (Marital_status)
JOIN Housing_type
USING (Housing_type)
JOIN Occupation AS O
ON M.Type_Occupation = O.Occupation

);

-- Creation of Customer table which will contain customer information. 
CREATE TABLE Customer (
SELECT ID,Gender,Car_Owner,Property_Owner,Children_count,Annual_income,Type_Income_id, 
Education_id, Marital_status_id, Housing_type_id, Age,Employed_days,Mobile_phone,Work_Phone,
Phone,Email_id,Occupation_id, Family_Members,label
FROM Whole_data
);

SELECT * FROM Customer;				# viewing the created Customer table


-- Droping the Whole_data and master_datset table. 
DROP TABLE Whole_data;
DROP TABLE master_dataset;