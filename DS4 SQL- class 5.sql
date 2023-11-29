#SQL CLASS 5
/*Multiple column,
correlated*/

/*Exercise 1:Write a query to find customers and their corresponding 
last interction date which is more recent than
 the average last interaction date.*/
 
 /*1- customers
 2-interaction date 
 interaction date > AVG(last_interaction_date)*/
 
 SELECT customer_id,last_interaction_date 
 FROM customer 
 Where (customer_id,last_interaction_date) IN 
 (Select customer_id,last_interaction_date
 FROM customer where last_interaction_date > 
 (select avg(last_interaction_date) from 
 customer));
 
 /*Exercise 2:
Select all feedback entries that match the worst rating given for any service type.*/


SELECT feedback_id, service_impacted, rating
FROM feedback
WHERE (service_impacted, rating) IN (
  SELECT service_impacted, MIN(rating)
  FROM feedback
  GROUP BY service_impacted
);

#in all the other subquery types, first the inner subquery is run and then outer is run
#Correlated subquery
#in the case of correlates subquery, the inner query is dependant on outer query

/*Find customers who have at least one 
billing record that is equal to the average billing amount.*/

SELECT c.customer_id, c.first_name, c.last_name, b.amount_due
FROM customer c
INNER JOIN billing b ON c.customer_id = b.customer_id
WHERE b.amount_due > (
  SELECT AVG(b2.amount_due)
  FROM billing b2
  WHERE b2.customer_id = c.customer_id
);

/*billing,customer_id     customer   amount_due(billing)
1            	1          100 --> AVG(100)
2             2          200
3 
1
1            3
#WINDOW_FUNCTIONS



/*1- customers name
2- count(subscription_id)*/

#WINDOW_FUNCTIONS
#AGGREGATE FUNCTION - SUM(),count(),MIN().......
#WINDOW FUNCTIONs - LEAD(),LAG(),RANK(),DENSE_RANK(),PARTITION BY

/*Exercise 1:View next session’s data usage for each customer

*/

SELECT customer_id,data_used,
LEAD(data_used) OVER(PARTITION BY customer_id order by data_used DESC)
AS next_data_used
FROM service_usage;

/*Calculate the difference in data usage between the current and next for each 
employee*/

SELECT customer_id,data_used,
data_used-LEAD(data_used) OVER (PARTITION BY customer_id order by data_used DESC)  
AS difference_in_dataused
FROM service_usage;

#LAG 
#Exercise 1:Review Previous Session's Data Usage for each customer

SELECT customer_id,data_used,
LAG(data_used) OVER ( partition by customer_id order by data_used desc) AS prev_data_used
FROM service_usage;

#find the Interval Between Service Usage dates
SELECT customer_id,usage_date,
DATEDIFF(usage_date,LAG(usage_date) OVER (partition by customer_id order by usage_date))
AS interval_days
FROM service_usage;

#RANK() and DENSE_RANK()

# Rank customers according to the number of services they have subscribed to
/*count the services
customer_id*/

SELECT customer_id,count(subscription_id) AS total_subscriptions,
RANK() OVER (ORDER BY count(subscription_id) DESC) AS rank_cust_subs
FROM subscriptions
GROUP BY customer_id;

SELECT customer_id,count(subscription_id) AS total_subscriptions,
DENSE_RANK() OVER (ORDER BY count(subscription_id) DESC) AS rank_cust_subs
FROM subscriptions
GROUP BY customer_id;

#Rank customers based on the total sum of 
#their rating they have ever given.

SELECT customer_id,SUM(rating) AS total_rating,
RANK() OVER (ORDER BY SUM(RATING) DESC) AS rank_rating_customer
FROM feedback
GROUP BY customer_id;

SELECT customer_id,SUM(rating) AS total_rating,
DENSE_RANK() OVER (ORDER BY SUM(RATING) DESC) AS rank_rating_customer
FROM feedback
GROUP BY customer_id;





 
 
 

 