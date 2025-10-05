SELECT c.region,
       p.name AS product_name,
       SUM(t.amount) AS total_sales,
       RANK() OVER (PARTITION BY c.region ORDER BY SUM(t.amount) DESC) AS rank_in_region
FROM transactions t
JOIN customers c ON t.customer_id = c.customer_id
JOIN products p ON t.product_id = p.product_id
GROUP BY c.region, p.name;
