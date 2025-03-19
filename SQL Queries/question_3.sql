SELECT 
    o.store_code,
    SUM(o.product_quantity * p.sale_price) AS total_sales
FROM orders o
JOIN dim_products p ON o.product_code = p.product_code
JOIN dim_stores ds ON o.store_code = ds.store_code  
WHERE EXTRACT(YEAR FROM o.order_date::DATE) = 2022
  AND ds.country = 'Germany'  
GROUP BY o.store_code
ORDER BY total_sales DESC
LIMIT 1;
