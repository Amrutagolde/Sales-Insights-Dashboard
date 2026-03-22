---Products with Price Higher than Category Average

SELECT *
FROM products_fixed p
WHERE price > (
    SELECT AVG(price)
    FROM products_fixed p2
    WHERE p2.category = p.category
);


---- Categories with Highest Average Rating

SELECT category, AVG(rating) AS avg_rating
FROM products_fixed
GROUP BY category
ORDER BY avg_rating DESC;


---- Most Reviewed Product in Each Warehouse

SELECT warehouse, product_name, MAX(reviews) AS max_reviews
FROM products_fixed
GROUP BY warehouse, product_name
ORDER BY warehouse, max_reviews DESC;


----  High-Price Products + Discount + Supplier

SELECT product_name, category, price, discount, supplier
FROM products_fixed p
WHERE price > (
    SELECT AVG(price)
    FROM products_fixed p2
    WHERE p2.category = p.category
);


---- Top 2 Products with Highest Rating per Category

WITH RankedProducts AS (
    SELECT *,
           RANK() OVER (PARTITION BY category ORDER BY rating DESC) AS rank_within_cat
    FROM products_fixed
)
SELECT *
FROM RankedProducts
WHERE rank_within_cat <= 2;


----  Return Policy Analysis: Count, Avg Stock, Total Stock, Weighted Avg Rating

SELECT 
    return_policy_duration,
    COUNT(*) AS product_count,
    AVG(stock) AS avg_stock,
    SUM(stock) AS total_stock,
    SUM(rating * reviews) * 1.0 / NULLIF(SUM(reviews), 0) AS weighted_avg_rating
FROM products_fixed
GROUP BY return_policy_duration
ORDER BY return_policy_duration;


select * from products_fixed;

