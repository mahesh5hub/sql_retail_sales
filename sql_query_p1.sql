use p1_retail_sales;


create table retail_sales
(
transactions_id	INT PRIMARY KEY ,
sale_date	DATE,
sale_time	TIME,
customer_id	INT,
gender	VARCHAR(15),
age	INT,
category	VARCHAR(15),
quantity	INT,
price_per_unit	FLOAT,
cogs	FLOAT,
total_sale FLOAT
);

select * from retail_sales;


select count(*) from retail_sales;

select * from retail_sales
where transactions_id is null;

select * from retail_sales;
where sale_date is null;

select * from retail_sales
where sale_time is null;

-- DATA CLEANING
select * from retail_sales
where transactions_id is null
or
sale_date is null
or 
sale_time is null
or 
gender is null
or 
category is null
or 
quantity is null
or
price_per_unit is null
or 
cogs is null 
or
total_sale is null;

-- Data exploration 

-- how many sales we have ??
select count(*) as total_sales from retail_sales;

-- How many unique customers we have ??

select count(distinct customer_id) as total_sales from retail_sales; 

-- How many unique category we have ??

select distinct category from retail_sales; 

-- Data Analysis & Business key Problem & Answers

-- Q.1 Write a SQL query to retrieve all columns for sales made on 2022-11-05

SELECT 
    *
FROM
    retail_sales
WHERE
    sale_date = '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 2 in the month of Nov-2022-11

SELECT 
    *
FROM
    retail_sales
WHERE
    category = 'Clothing'
        AND sale_date = '2022-11-11'
        AND quantity >= 2;
        
 -- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.  
 
 SELECT 
    category, SUM(total_sale) AS net_sale
FROM
    retail_sales
GROUP BY category;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

select category , round(avg(age) ) avg_age
from retail_sales
where category = 'Beauty';

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

select * from retail_sales
where total_sale > 1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

SELECT 
    category, gender, COUNT(*) AS total_trans
FROM
    retail_sales
GROUP BY category , gender
ORDER BY category;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
  
  
  select year, month,avg_sale from (
SELECT 
    YEAR(sale_date) as year,
    MONTH(sale_date) as month,
    AVG(total_sale) AS avg_sale,
	RANK() OVER (PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) AS rnk
FROM
    retail_sales
GROUP BY YEAR(sale_date) , MONTH(sale_date) ) as T1
where rnk = 1 ;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

SELECT 
    customer_id, SUM(total_sale) AS total_sale
FROM
    retail_sales
GROUP BY customer_id
ORDER BY total_sale DESC
LIMIT 5;


-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

SELECT 
    COUNT(DISTINCT customer_id) as unique_customer, 
    category
FROM
    retail_sales
GROUP BY category;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

with hourly_sale as 
(
select *,
case
when hour(sale_time) < 12 then 'Morning' 
when hour(sale_time) between 12 and 17 then 'Afternoon'
else 'Evening'
end as shift 
from retail_sales)
SELECT 
    shift, COUNT(*) AS total_orders
FROM
    hourly_sale
GROUP BY shift;


