-- ADVANCED QUESTIONS
-- Calculate the percentage contribution of each pizza type to total revenue

SELECT 
    pizza_types.category,
    ROUND(SUM(order_details.quantity * pizzas.price) / (SELECT 
                    ROUND(SUM(order_details.quantity * pizzas.price),
                                2) AS total_revenue
                FROM
                    order_details
                        JOIN
                    pizzas ON order_details.pizza_id = pizzas.pizza_id) * 100,
            2) AS percentage_revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizza_types.category
ORDER BY percentage_revenue DESC;




-- Analyze the cumulative revenue generated over time.

select order_date, round(sum(total_revenue_day) over(order by order_date),2) as cumulative_revenue 
from
(select orders.order_date, sum(order_details.quantity * pizzas.price) as total_revenue_day from
orders join order_details
on orders.order_id = order_details.order_id
join pizzas
on order_details.pizza_id = pizzas.pizza_id
group by order_date 
order by order_date) as sales;




-- Determine the top 3 most ordered pizza types based on revenue for each pizza category
select name,revenues from
(select category,name,revenues, rank() over(partition by category order by revenues desc) as results from
(select pizza_types.category,pizza_types.name, sum(order_details.quantity * pizzas.price) as revenues
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details 
on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.category, pizza_types.name) as cat_name_revenues) as b
where results <= 3;

