-- Ecommerce Sales Analysis
-- Author: Gaurav Raghuvanshi
-- Dataset: basket_details + customer_details

-- 1. Total Orders Overview
SELECT 
    COUNT(*) AS total_orders,
    SUM(basket_count) AS total_items_sold,
    COUNT(DISTINCT customer_id) AS unique_customers
FROM basket_details;

-- 2. Top 10 Products by Units Sold
SELECT 
    product_id,
    SUM(basket_count) AS total_units_sold
FROM basket_details
GROUP BY product_id
ORDER BY total_units_sold DESC
LIMIT 10;

-- 3. Sales by Month
SELECT 
    DATE_TRUNC('month', basket_date::date) AS month,
    SUM(basket_count) AS total_items_sold
FROM basket_details
GROUP BY month
ORDER BY month;

-- 4. Customer Age Analysis
SELECT 
    CASE 
        WHEN customer_age < 25 THEN 'Under 25'
        WHEN customer_age BETWEEN 25 AND 35 THEN '25-35'
        WHEN customer_age BETWEEN 36 AND 45 THEN '36-45'
        ELSE 'Above 45'
    END AS age_group,
    COUNT(*) AS total_customers
FROM customer_details
GROUP BY age_group
ORDER BY total_customers DESC;

-- 5. Gender wise Purchase Analysis
SELECT 
    cd.sex,
    COUNT(bd.product_id) AS total_orders,
    SUM(bd.basket_count) AS total_items
FROM basket_details bd
INNER JOIN customer_details cd 
    ON bd.customer_id = cd.customer_id
GROUP BY cd.sex
ORDER BY total_orders DESC;

-- 6. Most Loyal Customers (Highest Orders)
SELECT 
    bd.customer_id,
    cd.customer_age,
    cd.sex,
    cd.tenure,
    COUNT(*) AS total_orders,
    SUM(bd.basket_count) AS total_items
FROM basket_details bd
INNER JOIN customer_details cd 
    ON bd.customer_id = cd.customer_id
GROUP BY bd.customer_id, cd.customer_age, cd.sex, cd.tenure
ORDER BY total_orders DESC
LIMIT 10;