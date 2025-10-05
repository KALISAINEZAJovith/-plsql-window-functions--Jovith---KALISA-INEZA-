SELECT
    month,
    monthly_sales,
    SUM(monthly_sales) OVER (ORDER BY month) AS running_total
FROM (
    SELECT DATE_FORMAT(sale_date, '%Y-%m') AS month,
                 SUM(amount) AS monthly_sales
    FROM transactions
    GROUP BY DATE_FORMAT(sale_date, '%Y-%m')
) AS monthly
ORDER BY month;
