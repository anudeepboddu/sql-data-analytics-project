-- Cumulative Analysis - Aggregate the data progressively over time
-- Helps to understand whether our business is growing or declining
-- Calculate the total sales per month
-- and running total of sales over time (month) and rolling/moving average

SELECT
order_date,
total_sales,
-- Aggregate Window functions
SUM(total_sales) OVER(ORDER BY order_date) AS running_total_sales,
AVG(avg_price) OVER(ORDER BY order_date) AS moving_average_price
FROM 
-- Subquery (Derived table)
(SELECT
DATETRUNC(month, order_date) AS order_date,
SUM(sales_amount) AS total_sales,
AVG(price) as avg_price
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(month, order_date)) t


-- Calculate the total sales per month
-- and running total of sales over time, moving/rolling/running average/mean (year)

SELECT
order_date,
total_sales,
-- Aggregate Window functions
SUM(total_sales) OVER( ORDER BY order_date) AS running_total_sales,
AVG(avg_price) OVER(ORDER BY order_date) AS moving_average_price
FROM 
-- Subquery (Derived table)
(SELECT
DATETRUNC(year, order_date) AS order_date,
SUM(sales_amount) AS total_sales,
AVG(price) as avg_price
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(year, order_date)) t		


