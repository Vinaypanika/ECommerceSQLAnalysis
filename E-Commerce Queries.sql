
--Customer Analysis

--1. How many unique customers have placed orders?
select count(distinct customer_id) Total_customer from customers;

--2. Which state has the highest number of customers?
select state, count(*) as total_customers
from customers
group by state
order by count(*) desc;

--3. What is the total number of orders placed by each customer?
select o.customer_id,c.f_name,c.l_name,
count(*) as total_orders from orders as o
inner join customers as c on c.customer_id=o.customer_id
group by o.customer_id,c.f_name,c.l_name
order by count(*) desc;

--4 Find the average number of orders per customer.
select count(order_id)/count(distinct customer_id) as average_orders from orders;

---------------------------------------------------------------------------------------
---Order & Sales Analysis

--5. What is the total revenue generated from all orders?
select sum(total_price) as Total_revenue from order_items;

--6. What is the average order value (AOV) across all transactions?
select sum(total_price)/count( distinct order_id) as AOV from order_items;

--7. Identify the top 5 best-selling products based on quantity sold.
select top 5 o.product_id,p.product_name,sum(o.quantity) as quantity_sold
from order_items as o
inner join products as p on p. product_id = o.product_id
group by o.product_id,p.product_name
order by sum(o.quantity) desc;

-- 8. What are the top 5 worst-performing products based on sales?
select top 5 o.product_id,p.product_name,sum(o.quantity) as quantity_sold
from order_items as o
inner join products as p on p. product_id = o.product_id
group by o.product_id,p.product_name
order by sum(o.quantity);

--9. What is the total number of orders placed each month?

select datename(month, order_date) as month, year(order_date) as year, count(*) as total_orders
from orders
group by datename(month, order_date), month(order_date), year(order_date)
order by year(order_date), month(order_date);

--10. Which month had the highest total sales?
select datename(month, o.order_date) as month,year(o.order_date) as year,
sum(oi.total_price) as total_sales
from orders as o
inner join order_items as oi on oi.order_id = o.order_id
group by datename(month, o.order_date), month(o.order_date),year(o.order_date)
order by sum(total_price) desc;

--11. What is the total revenue per product category?
select c.category_name,sum(o.total_price) as Total_revenue from categories as c
inner join products as p on p.category_id = c.category_id
inner join order_items as o on o.product_id = p.product_id
group by c.category_name 
order by sum(o.total_price) desc ;

---------------------------------------------------------------------------------
--Inventory Management

--12. Which product has the lowest stock remaining?
select top 1 i.product_id,p.product_name,i.stock_remaining as stock_remaining
from inventory as i
inner join products as p on p.product_id = i.product_id
order by i.stock_remaining;

--13. What is the total stock value for each product?
select p.product_name,sum(i.stock_remaining*p.price) as Stock_value
from products as p
inner join inventory as i on i.product_id = p.product_id
group by p.product_name
order by Stock_value desc;

--14. Which products need restocking soon? (Stock < 10 units)
select i.product_id,p.product_name,i.stock_remaining from inventory as i
inner join products as p on i.product_id = p.product_id
where stock_remaining < 10
order by stock_remaining;

--15. Top 5 sellers who generate the most revenue?
select top 5 s.seller_id, s.seller_name, sum(oi.total_price) as total_revenue
from sellers as s
inner join products as p on p.seller_id = s.seller_id
inner join order_items as oi on oi.product_id = p.product_id
group by s.seller_id, s.seller_name
order by sum(oi.total_price) desc;

--16. What is the average product price for each seller?
select s.seller_name,avg(p.price) as Avg_price from sellers as s
inner join products as p on p.seller_id = s.seller_id
group by s.seller_name
order by s.seller_name;

---------------------------------------------------------------------------
-- Payment & Refund Analysis
--17. What is the most commonly used payment mode?
select payment_mode, count(*) as Total_count 
from payments
group by payment_mode
order by count(*) desc;

--18. What percentage of orders have a failed payment status?
select (select count(*) as failed_payments from payments
where payment_status = 'Failed')*100.0/count(*) as failure_percentage
from  payments;

--------------------------------------------------------------------------------

--Shipping & Delivery Analysis
--19. What is the average delivery time for orders?
select avg(datediff(day,o.order_date,s.shipping_date)) as avg_time_in_days
from shipping as s
inner join orders as o on s.order_id = o.order_id;

--20. What percentage of orders have been returned?
select 
(select count(*) from shipping where return_date is not null)*100.0/
count(*) as Return_percentage from shipping;


--21. What is the most common order status?

select order_status, count(*) as total_count
from orders
group by order_status
order by total_count desc;

--22. What is the most profitable product category?
select c.category_name, sum((o.price_per_unit-p.cogs)*o.quantity) as total_profit
from categories as c
inner join products as p on p.category_id = c.category_id
inner join order_items as o on o.product_id = p.product_id
group by c.category_name
order by total_profit desc;

/* note COGS stands for Cost of Goods Sold. 
It refers to the direct costs associated with producing the goods sold by a company. */

--23. Which customers contribute to the top 10% of revenue?
with cte_spending as 
	(select o.customer_id,sum(oi.total_price) as total_spending,
	percent_rank() over(order by sum(oi.total_price) desc) as percent_ranking
	from order_items as oi 
	inner join orders as o on oi.order_id = o.order_id
	group by o.customer_id)
select customer_id,total_spending
from cte_spending
where percent_ranking <=0.1
order by total_spending desc;

--24. What is the reorder rate of products?
select product_id, count(distinct order_id) as total_order,
(count(order_id) - count(distinct order_id))*100.0/count(distinct order_id) as reorder_rate
from order_items
group by product_id
order by reorder_rate desc;

