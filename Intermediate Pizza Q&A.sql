-- Intermediate:
-- 1. Join the necessary tables to find the total quantity of each pizza category ordered.
SELECT 
    pt.category AS category, SUM(od.quantity) AS quant
FROM
    pizza_types pt
        JOIN
    pizzas p ON pt.pizza_type_id = p.pizza_type_id
        JOIN
    order_details od ON od.pizza_id = p.pizza_id
GROUP BY pt.category
ORDER BY quant DESC;
-- 2. Determine the distribution of orders by hour of the day.
SELECT 
    HOUR(order_time) AS hours, COUNT(order_id) orders
FROM
    orders
GROUP BY hours
ORDER BY hours;
-- 3. Join relevant tables to find the category-wise distribution of pizzas.
SELECT 
    pt.category AS categori, COUNT(od.quantity) AS quant
FROM
    order_details od
        JOIN
    pizzas p ON od.pizza_id = p.pizza_id
        JOIN
    pizza_types pt ON pt.pizza_type_id = p.pizza_type_id
GROUP BY categori
ORDER BY quant DESC;
-- 4. Group the orders by date and calculate the average number of pizzas ordered per day.
with cte as (
             select o.order_date as dateof, sum(od.quantity) as quantity 
             from orders o join order_details od 
             on o.order_id = od.order_id group by dateof)
			 select round(avg(quantity),0) as avg_quant from cte;
-- 5. Determine the top 3 most ordered pizza types based on revenue.
SELECT 
    p.pizza_type_id, SUM(p.price * od.quantity) AS revenue
FROM
    pizzas p
        JOIN
    order_details od ON p.pizza_id = od.pizza_id
GROUP BY p.pizza_type_id
ORDER BY revenue DESC
LIMIT 3;
