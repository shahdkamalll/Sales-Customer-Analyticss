use FashionStore
select * from dbo.campaigns
select * from dbo.channels
select * from dbo.customers
select * from dbo.products
select * from dbo.sales
select * from dbo.salesitems
select * from dbo.stock


select distinct country from sales




select distinct channel from campaigns


SELECT channel, COUNT(campaign_name) AS total_campaigns
FROM campaigns
GROUP BY channel


 




select campaign_name , channel ,discount_type
from campaigns
where discount_type = 'fixed';









select count(customer_id)as customers_count,country 
from customers
group by country 
order by customers_count DESC;

SELECT country, COUNT(sale_id) AS sales_count
FROM dbo.sales
GROUP BY country
ORDER BY sales_count DESC;
 
select* from customers 

select count(customer_id) as total_customers ,age_range
from customers
group by age_range 
order by total_customers desc;

select distinct product_name from products
select distinct brand from products
select distinct category from products
select distinct size from products

select count(customer_id)  , channel
from sales
group by channel 

select sum(item_total) as total_revenue
from salesitems


select sum(item_total) as total_revenue,channel
from salesitems
group by channel;


select sum(item_total) as total_revenue,channel
from salesitems
where discounted = 1 
group by channel

SELECT 
    discounted,
    SUM(item_total) AS total_revenue
FROM salesitems
GROUP BY discounted;



select distinct discount_value from campaigns


-- Calculate total revenue per category

select sum(s.item_total) as total_per_category,p.category
from products p join salesitems s
on p.product_id = s.product_id
group by p.category
order by total_per_category desc;



-- total revenue per category & size
SELECT 
    p.category,
    p.size,
    SUM(s.item_total) AS total_revenue
FROM products p
JOIN salesitems s 
  ON p.product_id = s.product_id
GROUP BY p.category, p.size
ORDER BY p.category, total_revenue DESC;


-- Most ordered size per category

WITH size_rank AS (
    SELECT 
        p.category,
        p.size,
        SUM(s.quantity) AS total_orders,
        RANK() OVER (PARTITION BY category ORDER BY SUM(quantity) DESC) AS rnk
    FROM salesitems s join products p
    on p.product_id = s.product_id
    GROUP BY category, size
)
SELECT category, size, total_orders
FROM size_rank
WHERE rnk = 1;


-- Least ordered size per category

WITH size_rank AS (
    SELECT 
        p.category,
        p.size,
        SUM(s.quantity) AS total_orders,
        RANK() OVER (PARTITION BY category ORDER BY SUM(quantity) asc) AS rnk
    FROM salesitems s join products p
    on p.product_id = s.product_id
    GROUP BY category, size
)
SELECT category, size, total_orders
FROM size_rank
WHERE rnk = 1;



select sum (total_amount) from sales
select sum (item_total) from salesitems


SELECT s.discounted, SUM(s.total_amount) AS total_sales, COUNT(s.sale_id) AS total_orders
FROM sales s
GROUP BY s.discounted;

SELECT si.product_id,p.product_name, SUM(si.quantity) AS total_qty, SUM(si.item_total) AS revenue
FROM salesitems si join products p
on p.product_id = si.product_id
GROUP BY si.product_id,product_name
ORDER BY total_qty desc;
SELECT DISTINCT *
FROM salesitems;

select* from salesitems

SELECT *
FROM stock
ORDER BY country, stock_quantity DESC;


select distinct country from stock;