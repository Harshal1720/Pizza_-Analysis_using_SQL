show databases;
use pizzasalesanalysis;
describe order_details;
describe orders;
describe pizza_types;
describe pizzas;

SELECT * FROM orders;
SELECT * FROM order_details;
SELECT * FROM pizza_types;
SELECT * FROM pizzas;


-- Q.1 Retrive total number of order placed
SELECT 
    COUNT(order_id) AS total_orders
FROM
    orders;

-- Q.2 Calculate total revenue genrated from pizza sale
SELECT 
    ROUND(SUM(order_details.quantity * pizzas.price),
            2) AS total_sale
FROM
    order_details
        JOIN
    pizzas ON pizzas.pizza_id = order_details.pizza_id;

-- Q.3 Identify the highest price pizza

SELECT 
    pizza_types.name, pizzas.price AS price
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
ORDER BY price DESC
LIMIT 5;

-- Q.4 Identify most comman pizza size ordered

SELECT 
    pizzas.size,
    COUNT(order_details.order_details_id) AS Order_count
FROM
    order_details
        JOIN
    pizzas ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizzas.size
ORDER BY Order_count DESC;

-- Q.5 List top 5 most ordered pizza types along with their quantities 

SELECT 
    pizza_types.name, SUM(order_details.quantity) AS Quantity
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizza_types.name
ORDER BY Quantity DESC
LIMIT 5;

-- Q.6  Join the necessary tables to find the total quantity of each pizza category ordered 

SELECT 
    pizza_types.category AS Category,
    SUM(order_details.quantity) AS Quantity
FROM
    pizza_types
        JOIN
    pizzas ON pizzas.pizza_type_id = pizza_types.pizza_type_id
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY Category
ORDER BY Quantity DESC;

-- Q.7 Determine the distribution of orders by hours of the day 

SELECT 
    HOUR(orders.time) AS Hr, COUNT(order_id) AS count
FROM
    orders
GROUP BY Hr;

-- Q.8 Join relevant tables to find the category wise distribution of pizzas 

SELECT 
    category, COUNT(name)
FROM
    pizza_types
GROUP BY category;

-- Q.9 Group the orders by date and calculate the average number of pizzas ordered per day 

SELECT 
    ROUND(AVG(Quantity), 0)
FROM
    (SELECT 
        orders.date, SUM(order_details.quantity) AS Quantity
    FROM
        orders
    JOIN order_details ON order_details.order_id = orders.order_id
    GROUP BY orders.date) AS Order_Quantity;
    
    -- Q.10 Determine the top 3 most ordered pizzas based on revenue
    
SELECT 
    pizza_types.name,
    SUM(order_details.quantity * pizzas.price) AS Revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizzas.pizza_type_id = pizza_types.pizza_type_id
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizza_types.name
ORDER BY Revenue DESC
LIMIT 3


 

