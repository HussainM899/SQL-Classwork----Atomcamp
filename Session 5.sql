/* Multiple Column, correlated*/

/*Write a query to find customers and their corresponding last_interaction_date
 whose last interaction date 
is more recent than the avg last interaction date*/

select customer_id, last_interaction_date 
from customer 
where last_interaction_date > (select avg(last_interaction_date) 
from customer);


/* Select all feedback entries that match the worst rating given for any service type*/
select feedback_id, service_impacted, rating 
from feedback
where (service_impacted, rating) in (
	select service_impacted, min(rating)
	from feedback
    group by service_impacted
    );
    
    
#Correlated Subquery
/* write a query to show each customer's name and the number of subscription
they have*/
select first_name, last_name, (select count(s.subscription_id), s.customer_id from subscriptions as s
inner join customer as c on c.customer_id = s.customer_id group by s.customer_id) as count_of_subs
from customer;