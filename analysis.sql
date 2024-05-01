--------------------------------------------------------------------
--------------------------------------------------------------------
----------------------GENERIC QUESTIONS-----------------------------

-- How many unique cities does the data have?
SELECT DISTINCT(city)
FROM sales;

-- In which city is each branch?
SELECT DISTINCT(branch), city
FROM sales;

--------------------------------------------------------------------
--------------------------------------------------------------------
----------------------PRODUCT QUESTIONS-----------------------------

-- How many unique product lines does the data have?
SELECT COUNT(DISTINCT(product_line)) AS product_count
FROM sales;

-- What is the most common payment method?
SELECT 
	payment_method,
	COUNT(payment_method) AS method_count
FROM sales
GROUP BY payment_method
ORDER BY method_count DESC;

-- What is the most selling product line?
SELECT
	product_line,
	COUNT(product_line) AS product_count
FROM sales
GROUP BY product_line
ORDER BY product_count DESC;

-- What is the toal revenue by month?
SELECT
	month_name,
	SUM(total) AS revenue
FROM sales
GROUP BY month_name
ORDER BY revenue DESC;

-- What month had the largest COGS?
SELECT
	month_name,
	SUM(cogs) as cogs_total
FROM sales
GROUP BY month_name
ORDER BY cogs_total DESC;

-- What is the city with the largest revenue?
SELECT
	city, 
	SUM(total) AS revenue
FROM sales
GROUP BY city
ORDER BY revenue DESC;

-- What product line had the largest VAT?
SELECT
	product_line,
	AVG(VAT) AS avg_vat
FROM sales
GROUP BY product_line
ORDER BY avg_vat DESC;

-- Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales.
SELECT
	product_line,
	(CASE
		WHEN SUM(total)> AVG(total) THEN 'Good'
		ELSE 'Bad'
END) AS product_review
FROM sales
GROUP BY  product_line;

-- Which branch sold more products than average product sold?
SELECT
	branch,
	SUM(quantity) AS qty
FROM sales
GROUP BY branch
HAVING SUM(quantity) > AVG(quantity);


-- What is the most common product line by gender?
SELECT
	gender,
	product_line,
	COUNT(gender) AS total_cnt
FROM sales
GROUP BY gender, product_line
ORDER BY total_cnt DESC;


-- What is the average rating of each product line?
SELECT
	product_line,
	ROUND(AVG(rating), 2) AS avg_rating
FROM sales
GROUP BY product_line
ORDER BY avg_rating DESC;


--------------------------------------------------------------------
--------------------------------------------------------------------
----------------------SALES QUESTIONS-----------------------------

-- Number of sales made in each time of the city per weekday.
SELECT 
	city,
	day_name,
	time,
	COUNT(*) AS num_sales,
	SUM(total) AS total_revenue
FROM sales
GROUP BY city, day_name, time
ORDER BY city, day_name, time;

-- Which of the customer types brings the most revenue?
SELECT
	customer_type,
	SUM(total) AS revenue
FROM sales
GROUP BY customer_type
ORDER BY revenue DESC;

-- Which city has the largest tax percent/VAT (Value Added Tax)
SELECT 
	city, 
	ROUND(SUM(VAT), 2) as total_vat
FROM sales
GROUP BY city
ORDER BY total_vat DESC;

-- Which customer type pays the most in VAT?
SELECT 
	customer_type, 
	ROUND(SUM(VAT), 2) as total_vat
FROM sales
GROUP BY customer_type
ORDER BY total_vat DESC;

--------------------------------------------------------------------
--------------------------------------------------------------------
----------------------Customer QUESTIONS-----------------------------

-- How many unique customer types does the data have?
SELECT COUNT(DISTINCT(customer_type)) AS num_unique_customer_type
FROM sales;

-- How many unique payment methods does the data have?
SELECT COUNT(DISTINCT(payment_method)) AS num_unique_payment_methods
FROM sales;

-- Which customer type buys the most?
SELECT 
	customer_type,
	COUNT(*) AS cnt
FROM sales
GROUP BY customer_type;

-- What is the gender of most of the customers?
SELECT
	gender,
	COUNT(*) AS gender_cnt
FROM sales
GROUP BY gender
ORDER BY gender_cnt DESC;

-- what is the gender distribution per branch?
SELECT
	branch,
	gender,
	COUNT(*) AS cnt
FROM sales
GROUP BY branch, gender
ORDER BY cnt DESC;
	
-- Which time of the day do customers give most ratings?
SELECT
	time_of_day,
	COUNT(rating) rating_cnt
FROM sales
GROUP BY time_of_day
ORDER BY rating_cnt DESC;

-- Which time of the day do customers give most ratings per branch?
SELECT
	branch,
	time_of_day,
	COUNT(rating) AS rating_cnt
FROM sales
GROUP BY branch, time_of_day
ORDER BY rating_cnt DESC;

-- Which day of the week has the best average rating?
SELECT
	day_name,
	ROUND(AVG(rating), 2) AS avg_rating
FROM sales	
GROUP BY day_name
ORDER BY 
	(CASE
		WHEN day_name = 'Sunday' THEN 1
		WHEN day_name = 'Monday' THEN 2
		WHEN day_name = 'Tuesday' THEN 3
		WHEN day_name = 'Wednesday'	THEN 4
		WHEN day_name = 'Thursday' THEN 5
		WHEN day_name = 'Friday' THEN 6
		WHEN day_name = 'Saturday' THEN 7
	END) ASC;

-- Which day of the week has the best average ratings per branch?
SELECT
	branch,
	day_name,
	ROUND(AVG(rating), 2) AS avg_rating
FROM sales
GROUP BY branch, day_name
ORDER BY branch,
(CASE 
        WHEN day_name = 'Sunday' THEN 1
        WHEN day_name = 'Monday' THEN 2
        WHEN day_name = 'Tuesday' THEN 3
        WHEN day_name = 'Wednesday' THEN 4
        WHEN day_name = 'Thursday' THEN 5
        WHEN day_name = 'Friday' THEN 6
        WHEN day_name = 'Saturday' THEN 7
    END);