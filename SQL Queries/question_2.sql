SELECT 
    EXTRACT(MONTH FROM o.order_date::DATE) AS month,
    SUM(o.product_quantity * p.sale_price) AS total_sales
FROM orders o
JOIN dim_products p ON o.product_code = p.product_code
WHERE EXTRACT(YEAR FROM o.order_date::DATE) = 2022 
GROUP BY month
ORDER BY total_sales DESC
LIMIT 1;
