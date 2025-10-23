--Create a database
CREATE DATABASE retail_project 

--use the database
use retail_project

--Create a table
CREATE TABLE retail_sale
            (
                transaction_id INT PRIMARY KEY,	
                sale_date DATE,	 
                sale_time TIME,	
                customer_id	INT,
                gender	VARCHAR(15),
                age	INT,
                category VARCHAR(15),	
                quantiy	INT,
                price_per_unit FLOAT,	
                cogs	FLOAT,
                total_sale FLOAT
            );

SELECT * FROM retail_sale;

SELECT COUNT(*) FROM retail_sale;

--Data Cleaning

SELECT * FROM retail_sale
WHERE transactions_id IS NULL 
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantiy IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;


DELETE FROM retail_sale 
WHERE transactions_id IS NULL 
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantiy IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;

    -- Data Exploration

    -- How many sales we have?

SELECT COUNT(*) as total_sale FROM retail_sale;


-- How many uniuque customers we have ?

SELECT DISTINCT customer_id as total_sale FROM retail_sale;

SELECT COUNT(DISTINCT customer_id) as total_sale FROM retail_sale;

SELECT DISTINCT category FROM retail_sale;

SELECT COUNT(DISTINCT gender) AS TOTAL_Gender FROM retail_sale;

SELECT gender, count(*) as Total FROM retail_sale GROUP BY gender

-- Data Analysis 

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05

SELECT * FROM retail_sale WHERE sale_date = '2022-11-05';

-- Q.2 Write a SQL query to calculate the total sales (total_sale) for each category.

SELECT category, SUM(total_sale) as net_sale, COUNT(*) as total_orders FROM retail_sale GROUP BY category;

-- Q.3 Find the total sales (total_sale) for all transactions.

SELECT SUM(total_sale) as total FROM retail_sale

-- Q.4 Calculate the average total_sale per customer.

SELECT customer_id, AVG(total_sale) AS AvgSale FROM retail_sale GROUP BY customer_id;

-- Q.5 Find total sales grouped by age ranges: <25, 25-35, 35-50, >50.
SELECT 
  CASE 
    WHEN age < 25 THEN '<25'
    WHEN age BETWEEN 25 AND 35 THEN '25-35'
    WHEN age BETWEEN 36 AND 50 THEN '36-50'
    ELSE '>50'
  END AS AgeGroup,
  SUM(total_sale) AS TotalSales
FROM retail_sale
GROUP BY Age;

-- Q.6 Write a SQL query to find the top 5 customers based on the highest total sales 


SELECT customer_id, total_sales
FROM (
    SELECT 
        customer_id,
        SUM(total_sale) AS total_sales,
        ROW_NUMBER() OVER (ORDER BY SUM(total_sale) DESC) AS rn
    FROM retail_sale
    GROUP BY customer_id
) AS ranked_customers
WHERE rn <= 5;
