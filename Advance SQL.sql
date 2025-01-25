-- Q.11 Calclulate percentage contribution of each pizza type to total revenue

SELECT 
    pizza_types.category,
    ROUND(SUM(order_details.quantity * pizzas.price) / (SELECT 
                    ROUND(SUM(order_details.quantity * pizzas.price),
                                2) AS total_sale
                FROM
                    order_details
                        JOIN
                    pizzas ON pizzas.pizza_id = order_details.pizza_id) * 100,
            2) AS revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizzas.pizza_type_id = pizza_types.pizza_type_id
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizza_types.category
ORDER BY revenue DESC;
 
 -- Q.12 Analyse the cummulative revenue genrated over time 
 
 select date,sum(revenue) over (order by date) as cum_revenue 
 from
 (select orders.date,sum(order_details.quantity*pizzas.price) as revenue 
 from order_details join pizzas
 on pizzas.pizza_id = order_details.pizza_id
 join orders
 on orders.order_id=order_details.order_id
 group by orders.date ) as Sales;
 
 
 -- Q.13 Determine the top 3 most orderd pizzas types based on revenue for each pizza category
 
select category,name,revenue  from 
(select category , name, revenue , rank() over (partition by category order by revenue desc)  as rn
 from 
 (SELECT 
     pizza_types.category ,
    pizza_types.name,
    SUM(order_details.quantity * pizzas.price) AS revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizzas.pizza_type_id = pizza_types.pizza_type_id
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizza_types.category ,pizza_types.name) as a ) as b
 where rn>=3;