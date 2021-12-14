use Instacart;

select*
from orders;

#1 Create a table that shows the days of the week with the most orders and least orders
select count(order_number), order_dow
from orders
group by order_dow 
order by count(order_number) desc limit 1;

select count(order_number), order_dow
from orders
group by order_dow
order by count(order_number) asc limit 1;

#2 What percentage of orders are made during daytime (8am-5pm)? Round the result to 2 digits to decimal.

with t1 as 
(
select count(*) as numberOfOrders
from orders
where order_hour_of_day between 8 and 17
),
t2 as
(
select count(order_id) as total_orders
from orders
)
select round(100 * (numberofOrders/total_orders),2) as daytime_order_pct
from t1, t2;

#3 (a) If the company wants to give discount for customers’ reorders. At what time should the company launch the discount event? 
 #Find the top 3 prime times for re-orders. Prime time is measured by the reorder counts. 
 #Your results should look like Wednesday 3am, etc.

create view all_orders as
select *
from order_products__prior 
union
select *
from order_products__train;


select order_dow as week_day, order_hour_of_day as Hour_of_day, count(*) as numOrders
from all_orders ao join orders o on (ao.order_id = o.order_id)
where ao.reordered = 1
group by order_dow, order_hour_of_day
order by numOrders desc limit 3;

#3b The company wants to attract new customers by launching promotion events. 
 #At what time should the company launch the promotion to customers who place his/her first order? 
 #Find the top 3 prime times for customers’ first orders.
 
select order_dow as week_day, order_hour_of_day as Hour_of_day, count(*) as numOrders
from all_orders ao join orders o on (ao.order_id = o.order_id)
where ao.reordered = 0
group by order_dow, order_hour_of_day
order by numOrders desc limit 3;

#4 How often do the users reorder items? To answer this question, you need to show the number of users reorder items for each days_since_prior. 

 select days_since_prior, count(*) as num_reordered
 from all_orders ao join orders o on (ao.order_id = o.order_id)
 group by days_since_prior
 order by num_reordered desc;
 

#8 For each of the top 5 users who placed the highest number of orders, what is the average days interval of this user’s orders? 
with t1 as 
(
select user_id, count(*) as numorders
from orders
group by user_id
order by numOrders desc limit 5
),
t2 as 
(
select user_id, avg(days_since_prior) as avg_time
from orders
group by user_id
)
select t1.user_id, numOrders, avg_time
from t1 join t2 on (t1.user_id = t2.user_id)
group by t1.user_id
order by avg_time;


#9 Show days_since_prior and the average reorder rate of each days_since_prior. 
 #Round the average of reordered as 2 digits to decimal. Sort the result set by days_since_prior. 
 
 with t1 as 
 (
 select days_since_prior, count(*) as num_reordered
 from all_orders ao join orders o on (ao.order_id = o.order_id)
 where reordered = 1
 group by days_since_prior
 order by days_since_prior desc
 )
 select days_since_prior, round(avg(num_reordered),2) as reorder_date
 from t1
 group by days_since_prior
 order by days_since_prior desc;

