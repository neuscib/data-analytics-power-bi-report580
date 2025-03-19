DROP VIEW IF EXISTS store_sales_summary;

CREATE VIEW store_sales_summary AS
SELECT 
    o.store_code,
    SUM(o.product_quantity * p.sale_price) AS total_sales,
    SUM(o.product_quantity * p.sale_price) * 100.0 / SUM(SUM(o.product_quantity * p.sale_price)) OVER () AS percentage_of_total_sales,
    COUNT(DISTINCT o.product_code) AS order_count
FROM orders o
JOIN dim_products p ON o.product_code = p.product_code
GROUP BY o.store_code;
