select * from order_details limit 10;
-- --1. Retrieve the total number of orders placed.
select count(order_id) as no_of_orders from orders;
-- 2. Calculate the total revenue generated from pizza sales.
SELECT 
    ROUND(SUM(pizzas.price * order_details.quantity),
            2) AS total_revenue
FROM
    pizzas
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id;
-- 3. Identify the highest-priced pizza.
SELECT 
    pt.name, p.price
FROM
    pizza_types pt
        JOIN
    pizzas p ON pt.pizza_type_id = p.pizza_type_id
ORDER BY p.price DESC
LIMIT 1;
-- 4. Identify the most common pizza size ordered.
SELECT 
    od.pizza_id, COUNT(od.pizza_id) AS cntp
FROM
    order_details od
        JOIN
    pizzas p ON od.pizza_id = p.pizza_id
GROUP BY od.pizza_id
ORDER BY cntp DESC;
-- 5. List the top 5 most ordered pizza types along with their quantities.
SELECT 
    pizza_types.name pizza, SUM(order_details.quantity) AS quant
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY quant DESC
LIMIT 5; 

