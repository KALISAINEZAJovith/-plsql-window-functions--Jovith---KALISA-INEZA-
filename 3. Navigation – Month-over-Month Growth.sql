WITH monthly_sales AS (
    SELECT DATE_FORMAT(sale_date, '%Y-%m') AS month,
           SUM(amount) AS sales
    FROM transactions
    GROUP BY DATE_FORMAT(sale_date, '%Y-%m')
)
SELECT month,
       sales,
       LAG(sales, 1) OVER (ORDER BY month) AS prev_month,
       ROUND(((sales - LAG(sales, 1) OVER (ORDER BY month)) / 
              NULLIF(LAG(sales, 1) OVER (ORDER BY month), 0)) * 100, 2) AS growth_percent
FROM monthly_sales;
