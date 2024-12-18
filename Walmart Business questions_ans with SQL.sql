Select * From walmart;
DROP TABLE if exists walmart;
----
Select count(*) From walmart;

SELECT
payment_method, COUNT(*)
FROM walmart
GROUP BY payment_method;

SELECT 
COUNT(DISTINCT Branch)
FROM walmart;

-- Walmart Business Problems --

--1. Analyze Payment Methods and Sales
--● Question: What are the different payment methods, and how many transactions and
--items were sold with each method?
SELECT PAYMENT_METHOD,
COUNT(*) AS NO_OF_PAYMENTS, SUM(QUANTITY) AS NO_OF_SOLD
FROM WALMART
GROUP BY PAYMENT_METHOD;

--2. Identify the Highest-Rated Category in Each Branch
--● Question: Which category received the highest average rating in each branch?
SELECT BRANCH, CATEGORY, AVG(RATING) AS AVG_RATING,
RANK() OVER(PARTITION BY BRANCH ORDER BY AVG(RATING) DESC) AS RANK
FROM WALMART
GROUP BY BRANCH, CATEGORY;

--3. Determine the Busiest Day for Each Branch
--● Question: What is the busiest day of the week for each branch based on transaction
--volume?
SELECT * 
FROM ( SELECT BRANCH,
         TO_CHAR(TO_DATE(DATE, 'DD/MM/YY'),'DAY') AS DAY_NAME,
		 COUNT(*) AS NO_TRANSACTIONS,
		 RANK() OVER(PARTITION BY BRANCH ORDER BY COUNT(*) DESC) AS RANK

FROM WALMART 
GROUP BY BRANCH, DAY_NAME)
WHERE RANK = 1;

--4. Top-Selling Categories:
--Question: Which product category generates the highest revenue?
SELECT CATEGORY AS PRODUCT_CATEGORY , 
      SUM(TOTAL) AS TOTAL_REVENUE
FROM WALMART
GROUP BY PRODUCT_CATEGORY
ORDER BY TOTAL_REVENUE
LIMIT 1;

--5. Peak Sales Times:
--Question: During which hours of the day do most transactions occur?
SELECT 
    CAST(SPLIT_PART(time, ':', 1) AS INTEGER) AS transaction_hour,
	COUNT(*) AS transaction_count
FROM 
   walmart
GROUP BY 
   transaction_hour
ORDER BY
   transaction_count DESC 
LIMIT 1;   

--6. City-Wise Performance:
--Question: Which city has the highest average transaction value? 
SELECT CITY, AVG(TOTAL) AS AVG_TRANSACTION_VALUE
FROM WALMART
GROUP BY CITY
ORDER BY AVG_TRANSACTION_VALUE DESC
LIMIT 1;

--7. Stock Optimization:
--Question: Which product categories require frequent restocking based on quantities sold?
SELECT CATEGORY, SUM(QUANTITY) AS TOTAL_QUANTITIES_SOLD
FROM WALMART
GROUP BY CATEGORY
ORDER BY TOTAL_QUANTITIES_SOLD DESC;

--8. Question: What is the most frequently used payment method in each branch?
WITH cte 
AS
(SELECT 
	branch,
	payment_method,
	COUNT(*) as total_trans,
	RANK() OVER(PARTITION BY branch ORDER BY COUNT(*) DESC) as rank
FROM walmart
GROUP BY branch, payment_method
)
SELECT *
FROM cte
WHERE rank = 1;

--9. Identify Branches with Highest Revenue Decline Year-Over-Year
--● Question: Which branches experienced the largest decrease in revenue compared to
--the previous year? (current year 2023 and last year 2022)
SELECT *,
EXTRACT(YEAR FROM TO_DATE(date, 'DD/MM/YY')) as formated_date
FROM walmart

-- 2022 sales
WITH revenue_2022
AS
(SELECT 
	branch,
	SUM(total) as revenue
	FROM walmart
	WHERE EXTRACT(YEAR FROM TO_DATE(date, 'DD/MM/YY')) = 2022
	Group BY 1
),

revenue_2023
AS
(SELECT 
	branch,
	SUM(total) as revenue
	FROM walmart
	WHERE EXTRACT(YEAR FROM TO_DATE(date, 'DD/MM/YY')) = 2023
	GROUP BY 1
)

SELECT 
	ls.branch,
	ls.revenue as last_year_revenue,
	cs.revenue as cr_year_revenue,
	ROUND(
		(ls.revenue - cs.revenue)::numeric/
		ls.revenue::numeric * 100, 
		2) as rev_dec_ratio
FROM revenue_2022 as ls
JOIN
revenue_2023 as cs
ON ls.branch = cs.branch
WHERE 
	ls.revenue > cs.revenue
ORDER BY 4 DESC
LIMIT 5

--10. Analyze Sales Shifts Throughout the Day
--● Question: How many transactions occur in each shift (Morning, Afternoon, Evening)
--across branches?
SELECT BRANCH, 
CASE 
   WHEN EXTRACT(HOUR FROM(TIME::TIME)) < 12 THEN 'MORNING'
   WHEN EXTRACT(HOUR FROM(TIME::TIME)) BETWEEN 12 AND 17 THEN 'AFTERNOON'
   ELSE 'EVENING'
END DAY_TIME,
COUNT(*)
FROM WALMART
GROUP BY 1, 2
ORDER BY 1, 3 DESC;