create database pizza_sales;
use	pizza_sales;

# 1 Total Sales Per Pizzas

SELECT 
    p.pizza_id,
    pt.name,
    SUM(od.quantity) AS total_quantity,
    SUM(p.price * od.quantity) AS total_sales
FROM
    order_details od
        JOIN
    pizzas AS p ON od.pizza_id = p.pizza_id
        JOIN
    pizza_types AS pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY p.pizza_id , pt.name;

# 2 Orders by Date and time

SELECT 
    o.order_id,
    o.date,
    o.time,
    COUNT(od.pizza_id) AS total_pizzas
FROM
    orders AS o
        JOIN
    order_details AS od ON o.order_id = od.order_id
GROUP BY o.order_id , o.date , o.time
ORDER BY o.date , o.time;

# 3 Most popular pizza type

SELECT 
    pt.category, COUNT(od.pizza_id) AS total_orders
FROM
    order_details AS od
        JOIN
    pizzas AS p ON od.pizza_id = p.pizza_id
        JOIN
    pizza_types AS pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category
ORDER BY total_orders DESC;

# 4 Sales by Pizza size

SELECT 
    p.size, SUM(p.price * od.quantity) AS total_sales
FROM
    order_details AS od
        JOIN
    pizzas AS p ON od.pizza_id = p.pizza_id
GROUP BY p.size;

# 5 Total number of orders  by date

SELECT 
    o.date, COUNT(o.order_id) AS total_orders
FROM
    orders AS o
GROUP BY o.date
ORDER BY o.date;

# 6 Order Frequency by time 
SELECT 
    HOUR(o.time) AS hour, COUNT(o.order_id) AS total_orders
FROM
    orders AS o
GROUP BY hour
ORDER BY hour;

# 7 Average order value

SELECT 
    AVG(order_total) AS average_order_value
FROM
    (SELECT 
        o.order_id, SUM(p.price * od.quantity) AS order_total
    FROM
        order_details AS od
    JOIN pizzas AS p ON od.pizza_id = p.pizza_id
    JOIN orders AS o ON od.order_id = o.order_id
    GROUP BY o.order_id) AS Average_value;
    
# 8  Order trend by day of week

SELECT 
    DAYOFWEEK(o.date) AS day_of_week,
    SUM(p.price * od.quantity) AS total_sales
FROM
    order_details AS od
        JOIN
    pizzas AS p ON od.pizza_id = p.pizza_id
        JOIN
    orders AS o ON od.order_id = o.order_id
GROUP BY day_of_week
ORDER BY day_of_week;

#  9  sales trend by month

SELECT 
    DATE_FORMAT(o.date, '%Y-%m') AS month,
    SUM(p.price * od.quantity) AS total_sales
FROM
    order_details AS od
        JOIN
    pizzas AS p ON od.pizza_id = p.pizza_id
        JOIN
    orders AS o ON od.order_id = o.order_id
GROUP BY month
ORDER BY month;

# 10 Total Orders and Revenue per day

SELECT 
    o.date,
    COUNT(o.order_id) AS total_orders,
    SUM(p.price * od.quantity) AS ttotal_revenue
FROM
    orders AS o
        JOIN
    order_details AS od ON o.order_id = od.order_id
        JOIN
    pizzas AS p ON od.pizza_id = p.pizza_id
GROUP BY o.date
ORDER BY o.date;
