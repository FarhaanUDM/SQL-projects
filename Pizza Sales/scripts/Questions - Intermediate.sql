-- INTERMEDIATE QUESTIONS
-- Join the necessary tables to find the total quantity of each pizza category ordered
SELECT 
    pizza_types.category,
    SUM(order_details.quantity) AS category_qty
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY category
ORDER BY category_qty DESC;




-- Determine the distribution of orders by hour of the day.
SELECT 
    COUNT(order_id) as No_of_orders, HOUR(order_time) AS hours
FROM
    orders
GROUP BY hours
ORDER BY hours;




-- Join relevant tables to find the category-wise distribution of pizzas
SELECT 
    category, COUNT(pizza_type_id)
FROM
    pizza_types
GROUP BY category;




-- Group the orders by date and calculate the average number of pizzas ordered per day
SELECT 
    ROUND(AVG(pizzas_sold), 0) AS Avg_per_Day
FROM
    (SELECT 
        orders.order_date, SUM(quantity) AS pizzas_sold
    FROM
        orders
    JOIN order_details ON orders.order_id = order_details.order_id
    GROUP BY order_date
    ORDER BY order_date) AS orders_qty;



-- Determine the top 3 most ordered pizza types based on revenue

select pizza_types.name, round(sum(order_details.quantity * pizzas.price),0) as revenues from
pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details
on pizzas.pizza_id = order_details.pizza_id
group by pizza_types.name
order by revenues desc limit 3;


