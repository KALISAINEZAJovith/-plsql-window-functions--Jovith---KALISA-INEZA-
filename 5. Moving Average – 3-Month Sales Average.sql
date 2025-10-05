WITH monthly_sales AS (
    SELECT DATE_FORMAT(sale_date, '%Y-%m') AS month,
           SUM(amount) AS sales
    FROM transactions
    GROUP BY DATE_FORMAT(sale_date, '%Y-%m')
)
SELECT month,
       sales,
       ROUND(AVG(sales) OVER (ORDER BY month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW), 2) AS moving_avg_3m
FROM monthly_sales;
