SELECT customer_id,
       SUM(amount) AS total_spent,
       NTILE(4) OVER (ORDER BY SUM(amount) DESC) AS spending_quartile
FROM transactions
GROUP BY customer_id;
