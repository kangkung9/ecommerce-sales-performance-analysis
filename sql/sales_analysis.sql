
-- =====================================================
-- PROJECT: E-Commerce Sales Performance Analysis
-- DATABASE: PostgreSQL
-- DATASET: Sample Superstore
-- =====================================================


-- 1. DATA OVERVIEW
SELECT COUNT(*) AS total_rows
FROM public.superstore;


-- 2. DATA QUALITY CHECK
SELECT
    COUNT(*) FILTER (WHERE order_id IS NULL) AS missing_order_id,
    COUNT(*) FILTER (WHERE customer_id IS NULL) AS missing_customer_id,
    COUNT(*) FILTER (WHERE sales IS NULL) AS missing_sales,
    COUNT(*) FILTER (WHERE profit IS NULL) AS missing_profit
FROM public.superstore;


-- 3. KEY PERFORMANCE INDICATORS
SELECT
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    SUM(quantity) AS total_quantity,
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(DISTINCT customer_id) AS total_customers
FROM public.superstore;


-- 4. SALES AND PROFIT BY CATEGORY
SELECT
    category,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    ROUND(
        SUM(profit) / NULLIF(SUM(sales), 0) * 100, 2
    ) AS profit_margin_percentage
FROM public.superstore
GROUP BY category
ORDER BY total_sales DESC;


-- 5. SALES AND PROFIT BY REGION
SELECT
    region,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    ROUND(
        SUM(profit) / NULLIF(SUM(sales), 0) * 100, 2
    ) AS profit_margin_percentage
FROM public.superstore
GROUP BY region
ORDER BY total_sales DESC;


-- 6. PROFIT BY SUB-CATEGORY
SELECT
    sub_category,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM public.superstore
GROUP BY sub_category
ORDER BY total_profit ASC;


-- 7. MONTHLY SALES AND PROFIT TREND
SELECT
    DATE_TRUNC('month', order_date)::date AS month,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM public.superstore
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY month;


-- 8. TOP 10 LOSS-MAKING PRODUCTS
SELECT
    product_name,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM public.superstore
GROUP BY product_name
HAVING SUM(profit) < 0
ORDER BY total_profit ASC
LIMIT 10;

