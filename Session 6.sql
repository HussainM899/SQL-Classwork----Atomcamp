#CTE - Common Table Expression
/* CTE is a way to structure complex queries for better understanding 
and readability*/

#Find customers who use more data than the avg data used
#you want 3 things from this ques
#Customers, data used >avg data used
select customer_id, data_used from service_usage;

select customer_id, data_used, avg(data_used) as avg_data_used
where data_used>avg_data_used
from service_usage;

with averagedataused as 
(select avg(data_used) as avg_data from service_usage)
select su.customer_id
from service_usage su, averagedataused adu
where su.data_used>adu.avg_data
group by su.customer_id;


#Find out the most recent feedback from each customer
select customer_id, max(feedback_date) as latest_date
from feedback
group by customer_id;


#Find out the most recent feedback from each customer

select customer_id, feedback_date from feedback;

with max_feedback_date as 
(select customer_id, max(feedback_date) as latest_date 
from feedback group by customer_id)

select f.customer_id, f.rating, f.feedback_text, mdf.latest_date
from feedback f
inner join max_feedback_date mfd on f.customer_id = mfd.customer_id;
 

-- CTE to find the most recent feedback date for each customer
WITH max_feedback_date AS (
    SELECT customer_id, MAX(feedback_date) AS latest_date 
    FROM feedback 
    GROUP BY customer_id
)

-- Join the feedback table with the CTE to get the most recent feedback
SELECT f.customer_id, f.rating, f.feedback_text, mfd.latest_date
FROM feedback f
INNER JOIN max_feedback_date mfd ON f.customer_id = mfd.customer_id;


