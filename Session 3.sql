#CLASS 3
/* Aggregation, Group by, having, conditional statements - case
aggregation functions - sum, max, min, count, avg*/

#Find the average monthly rate for each service type in service packages
select * from service_packages;
select service_type, round(avg(monthly_rate),1) as average_monthly_rate 
from service_packages
group by service_type;

/* Identify the customer who has used the most data in a single service_usage_record*/

select * from service_usage;
select customer_id, max(data_used) as max_data_used
from service_usage
group by customer_id
order by max_data_used desc
limit 1;

/* Calculate the total minutes by all customers for mobile services*/

select sum(minutes_used) as total_minutes_used
from service_usage 
where service_type = "Mobile";

/*Show the total amount due by each customer by 
only for those who have a total amount greater than 100*/
select customer_id, round(sum(amount_due),0) as total_amount_due
from billing
group by customer_id
having total_amount_due>100
order by total_amount_due desc;

/* Determine which customer has provided feedback on more than 1 type of service
but with a total rating less than 10*/

select customer_id
from feedback 
group by customer_id
having count(distinct service_impacted)>1 and sum(rating)>10;
# Convert rating to int

-- alter table feedback
-- modify rating int;

/*Group feedback by service impacted and rating to count the number of feedback entries*/
select rating, service_impacted, count(feedback_id) as feedback_count
from feedback
group by 1,2
order by service_impacted,rating;

set sql_safe_updates = 0;
update feedback
set rating = null where rating=""; 
update feedback
set service_impacted = null where service_impacted=""; 




#Case (Conditional Statements)

/* categorize based on their subscription date :
New for those who subscribed after 2023-01-01, old for the rest*/

select * from subscriptions;
select customer_id,
case when start_date > "2019-01-01"then "NEW"
else "OLD" 
end as customer_catergory
from subscriptions;


/*provide a summary of each customers billing status, showing "PAID"
the payment_date is */

update billing set payment_date = null where payment_date;

select customer_id, bill_id,
case when payment_date is not null then "Paid"
else "UNPAID"
end as billing_status
from billing;


/* mark each feedback entry as"urgent" if the rating is 1 and the feedback text includes
words like "outage" or "down"*/
-- update feedback 
-- set feedback_text=
-- case when rating=1 and(
-- lower(feedback_text) like "%outage%" or
--  lower(feedback_text) like "%down%")then "URGENT"
-- else "normal"
-- end;

-- select feedback_text from feedback
-- from feedback
-- group by feedback_text;




