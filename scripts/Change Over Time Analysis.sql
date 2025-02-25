-- change over time Analysis - To track trends and identify seasonality in your data.

-- Analyze sales performance over time 

-- Day level sales performance
SELECT 
order_date,
SUM(sales_amount) as daily_sales
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY order_date
ORDER BY order_date;

-- Changes over months - Detailed insights to discover seasonality in your data
SELECT 
MONTH(order_date) as order_month,
SUM(sales_amount) as monthly_sales,
COUNT(distinct customer_key) as total_customers,
SUM(quantity) as total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY MONTH(order_date)
ORDER BY MONTH(order_date);

-- Changes over years - A high level overview insights that helps with strategic decision-making
SELECT 
YEAR(order_date) as order_year,
SUM(sales_amount) as yearly_sales,
COUNT(distinct customer_key) as total_customers,
SUM(quantity) as total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date)
ORDER BY YEAR(order_date);

SELECT
YEAR(order_date) as order_year,
MONTH(order_date) as order_month,
SUM(sales_amount) as yearly_sales,
COUNT(distinct customer_key) as total_customers,
SUM(quantity) as total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY YEAR(order_date), MONTH(order_date);

-- DATETRUNC() - Rounds a date or timestamp to a specified date part.
-- It always rounds date to the first date of month/first date of year as per first argument
SELECT
DATETRUNC(month, order_date) as order_date,
SUM(sales_amount) as yearly_sales,
COUNT(distinct customer_key) as total_customers,
SUM(quantity) as total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(month, order_date)
ORDER BY DATETRUNC(month, order_date);

SELECT
	DATETRUNC(year, order_date) AS order_date,
	SUM(sales_amount) AS yearly_sales,
	COUNT(DISTINCT customer_key) AS total_customers,
	SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date is not null
GROUP BY datetrunc(year, order_date)
ORDER BY datetrunc(year, order_date);

-- FORMAT() - Remember that you can't sort data by order date as this function returns string output
SELECT
	FORMAT(order_date, 'yyyy-MMM') AS order_date,
	SUM(sales_amount) AS yearly_sales,
	COUNT(DISTINCT customer_key) AS total_customers,
	SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date is not null
GROUP BY FORMAT(order_date, 'yyyy-MMM')
ORDER BY FORMAT(order_date, 'yyyy-MMM');
