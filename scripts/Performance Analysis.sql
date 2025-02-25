-- Performance Analysis	
-- Comparing the current value to a target value
-- Current measure - Target measure
-- Current Sales - Average Sales
-- Current Year Sales - Previous Year Sales
-- Current Sales - Lowest/Highest Sales
-- Aggregate Window functions and Lead/Lag functions will be used

/* Analyze the yearly performance of products by comparing their sales
   to both the average sales performance of the product and previous year's sales */

   WITH yearly_product_sales AS (
	   SELECT
		   YEAR(f.order_date) AS order_year,
		   p.product_name,
		   SUM(f.sales_amount) AS current_sales
	   FROM [gold].[fact_sales] f
	   LEFT JOIN gold.dim_products p
	   ON f.product_key = p.product_key
	   WHERE f.order_date IS NOT NULL
	   GROUP BY YEAR(f.order_date), p.product_name
   )
   SELECT 
	   order_year, 
	   product_name, 
	   current_sales,
	   AVG(current_sales) OVER(PARTITION BY product_name) AS avg_sales,
	   current_sales - AVG(current_sales) OVER(PARTITION BY product_name) AS diff_avg,
	   CASE	WHEN current_sales - AVG(current_sales) OVER(PARTITION BY product_name) < 0 THEN 'Below Avg'
			WHEN current_sales - AVG(current_sales) OVER(PARTITION BY product_name) > 0 THEN 'Above Avg'
			ELSE 'Avg'
		END AS avg_change,
		LAG(current_sales) OVER(PARTITION BY product_name ORDER BY order_year) AS py_sales,
		current_sales - LAG(current_sales) OVER(PARTITION BY product_name ORDER BY order_year) AS diff_py,
		CASE WHEN current_sales - LAG(current_sales) OVER(PARTITION BY product_name ORDER BY order_year) < 0 THEN 'Decrease'
			 WHEN current_sales - LAG(current_sales) OVER(PARTITION BY product_name ORDER BY order_year) > 0 THEN 'Increase'
			 ELSE 'No Change'
		END AS py_change
   FROM yearly_product_sales
   ORDER BY product_name, order_year;