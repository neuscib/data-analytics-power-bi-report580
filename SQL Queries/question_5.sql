SELECT 
    p.category,  
    SUM((p.sale_price - p.cost_price) * o.product_quantity) AS total_profit
FROM orders o
JOIN dim_products p ON o.product_code = p.product_code
JOIN dim_stores ds ON o.store_code = ds.store_code
WHERE EXTRACT(YEAR FROM o.order_date::DATE) = 2021 
  AND ds.country = 'UK' 
  AND ds.region = 'Wiltshire'  
GROUP BY p.category
ORDER BY total_profit DESC
LIMIT 1;


