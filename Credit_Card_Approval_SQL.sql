                 -- Credit_Card_Analysis--

USE Credit_card ;	
	
SELECT 
    Type_Income, ROUND(AVG(Annual_income), 2) AS Income
FROM
    Customer
        INNER JOIN
    type_income USING (Type_income_id)
GROUP BY Type_Income;

-- Q2. Find the female owners of cars and property.
SELECT 
    ID, Gender, Car_Owner, Property_Owner
FROM
    Customer
WHERE
    Gender = 'F' AND Car_Owner = 'Y'
        AND Property_Owner = 'Y';

-- Q3. Find the male customers who are staying with their families.
SELECT 
    ID, Gender, Family_members
FROM
    customer
WHERE
    Gender = 'M'
        AND Family_Members IS NOT NULL;

-- Q4. Please list the top five people having the highest income.
WITH Top_5 AS (
SELECT ID, Gender, Annual_income, DENSE_RANK () OVER (ORDER BY Annual_income DESC) AS Ranking  FROM customer)
SELECT * FROM Top_5 WHERE Ranking BETWEEN 1 AND 5;

-- Q5. How many married people are having bad credit?
SELECT 
    COUNT(ID) No_Of_Customer, Marital_status, label
FROM
    customer
        INNER JOIN
    marital_status USING (Marital_status_id)
WHERE
    Marital_status = 'Married' AND label = 1;


-- Q6. What is the highest education level and what is the total count?
SELECT 
    COUNT(ID) Total_Customer, Education_level
FROM
    Customer
        INNER JOIN
    Education USING (Education_id)
WHERE
    Education_level = 'Academic degree';


-- Q7. Between married males and females, who is having more bad credit? 
SELECT 
    COUNT(*) Total_Customer, Gender, Marital_status, label
FROM
    Customer
        INNER JOIN
    marital_status USING (Marital_status_id)
WHERE
    Marital_status = 'Married' AND label = 1
GROUP BY Gender
ORDER BY Total_Customer DESC
LIMIT 1;