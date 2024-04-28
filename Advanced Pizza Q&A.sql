-- Advanced:
-- 1. Calculate the percentage contribution of each pizza type to total revenue.
SELECT 
    pt.category,
    (100 * ROUND(SUM(p.price * od.quantity), 2)) / (SELECT 
            ROUND(SUM(pizzas.price * order_details.quantity),
                        2)
        FROM
            pizzas
                JOIN
            order_details ON pizzas.pizza_id = order_details.pizza_id) AS revenue
FROM
    order_details od
        JOIN
    pizzas p ON p.pizza_id = od.pizza_id
        JOIN
    pizza_types pt ON pt.pizza_type_id = p.pizza_type_id
GROUP BY pt.category;
-- 2. Analyze the cumulative revenue generated over time.
with cte as(
			select o.order_date as dateof, sum(p.price*od.quantity) as revenue
            from pizzas p 
            join order_details od 
            on p.pizza_id = od.pizza_id 
			join orders o on od.order_id = o.order_id 
            group by o.order_date)
	select dateof, sum(revenue) over( order by dateof) as cum_revenue from cte;
-- 3. Determine the top 3 most ordered pizza types based on revenue for each pizza category.
with cte as(
SELECT 
     pt.category, pt.pizza_type_id,SUM(p.price * od.quantity) AS revenue, rank() over(partition by pt.category order by SUM(p.price * od.quantity) desc) as rankno
FROM
    pizzas p
        JOIN
    order_details od ON p.pizza_id = od.pizza_id join pizza_types pt on pt.pizza_type_id = p.pizza_type_id
GROUP BY  pt.category,pt.pizza_type_id
ORDER BY pt.category )
select category, pizza_type_id, revenue from cte where rankno < 4;