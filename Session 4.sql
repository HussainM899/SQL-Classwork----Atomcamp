#SQL CLASS 4

/*TOPICS TO COVER:
Working with Multiple Tables
● Understanding database relationships (one-to-many, many-to-many).
● Using JOINs to combine data from multiple tables.
● INNER JOIN, LEFT JOIN, RIGHT JOIN, FULL JOIN.

Subqueries
● Understanding subqueries and their applications.
● Single-row
*/


#Working with Multiple Tables

#Exercise 1: INNER JOIN ( returns values present in both tables)
#Write a query to find all customers along with their billing information.

SELECT c.customer_id, c.first_name, c.last_name, b.amount_due, b.due_date
FROM customer c
INNER JOIN billing b ON c.customer_id = b.customer_id;

#Exercise 2:
#List all customers with their corresponding total due amounts from the billing table.
#c.first_name, c.last_name will give error unless in group by or customer_id primary key 

SELECT c.first_name, c.last_name, SUM(b.amount_due) AS total_due
FROM customer c
INNER JOIN billing b ON c.customer_id = b.customer_id
GROUP BY c.customer_id;


#Exercise 3:
#Display service packages along with the number of subscriptions each has.
#Sp.package_name will give error unless in group by or package_id primary key

SELECT sp.package_name, COUNT(s.subscription_id) AS number_of_subscriptions
FROM service_packages sp
INNER JOIN subscriptions s ON sp.package_id = s.package_id
GROUP BY sp.package_id, sp.package_name;



/*LEFT JOIN

Exercise 1:Write a query to list all customers and any feedback they have given, including customers who have not given feedback.*/


SELECT c.customer_id, c.first_name, c.last_name, f.feedback_text
FROM customer c
LEFT JOIN feedback f ON c.customer_id = f.customer_id;

#Exercise 2:
#Retrieve all customer and the package names of any subscriptions they might have.


SELECT c.customer_id, c.first_name, c.last_name, sp.package_name
FROM customer c
LEFT JOIN subscriptions s ON c.customer_id = s.customer_id
LEFT JOIN service_packages sp ON s.package_id = sp.package_id;



/*Exercise 3:
Find out which customer have never given feedback by left joining customer to feedback.*/

SELECT c.customer_id, c.first_name, c.last_name
FROM customer c
LEFT JOIN feedback f ON c.customer_id = f.customer_id
WHERE f.feedback_id IS NULL;

 #RIGHT JOIN
/*Exercise 1: Write a query to list all feedback entries and the corresponding 
customer information, including feedback without a linked customer.*/

SELECT c.customer_id, c.first_name, c.last_name, f.feedback_text
FROM customer c
RIGHT JOIN feedback f ON c.customer_id = f.customer_id;

#Exercise 2:
#Show all feedback entries and the full names of the customer who gave them.


SELECT f.feedback_id, CONCAT(c.first_name, ' ', c.last_name) AS customer_name, f.feedback_text
FROM feedback f
RIGHT JOIN customer c ON f.customer_id = c.customer_id;

#Exercise 3:
#List all customers, including those without a linked service usage.

SELECT c.first_name, c.last_name, su.usage_id, su.service_type, su.data_used, su.minutes_used
FROM service_usage su
RIGHT JOIN customer c ON su.customer_id = c.customer_id;

/*Multiple JOINs
Write a query to list all customers, their subscription packages, and usage data.*/


SELECT c.customer_id, c.first_name, c.last_name, sp.package_name, su.data_used, su.minutes_used
FROM customer c
JOIN subscriptions s ON c.customer_id = s.customer_id
JOIN service_packages sp ON s.package_id = sp.package_id
JOIN service_usage su ON c.customer_id = su.customer_id;


/*Subqueries
Exercise 1: Single-row Subquery
Write a query to find the service package with the highest monthly rate.*/


SELECT package_name, monthly_rate
FROM service_packages
WHERE monthly_rate = (SELECT MAX(monthly_rate) FROM service_packages);

/*Exercise 2:
Find the customer with the smallest total amount of data used in service_usage.*/

SELECT customer_id, data_used
FROM service_usage
WHERE data_used = (SELECT MIN(data_used) FROM service_usage);


/*Exercise 3:
Identify the service package with the lowest monthly rate.*/


SELECT package_name
FROM service_packages
WHERE monthly_rate = (SELECT MIN(monthly_rate) FROM service_packages);

#Multiple-row Subquery


#Exercise 1 :
#Find customers whose subscription lengths are longer than the average subscription length of all customers.

SELECT DISTINCT c.customer_id, c.first_name, c.last_name
FROM customer c
JOIN subscriptions s ON c.customer_id = s.customer_id
WHERE DATEDIFF(s.end_date, s.start_date) > ALL (
    SELECT AVG(DATEDIFF(sub.end_date, sub.start_date)) 
    FROM subscriptions sub GROUP BY sub.customer_id
);

select distinct c.customer_id, c.First_name, c.Last_name
from customer c
join subscriptions s on c.customer_id = s.Customer_id
where datediff(s.end_date,s.start_date) > all (
	select avg(datediff(sub.end_date, sub.start_date))
    from subscriptions sub 
    group by sub.customer_id
    );


#Multiple-column Subquery
#Exercise 1:Write a query to find customers whose last interaction date is more recent than the average last interaction date.

SELECT customer_id, last_interaction_date
FROM customer
WHERE (customer_id, last_interaction_date) IN (
  SELECT customer_id, last_interaction_date
  FROM customer
  WHERE last_interaction_date > (SELECT AVG(last_interaction_date) FROM customer)
);


#Exercise 2:
/*Select all feedback entries that match the worst rating given for any service type.
will need to add the following else the empties turn up as the MIN rating
UPDATE feedback
SET rating = NULL
WHERE rating = '';*/

SELECT feedback_id, service_impacted, rating
FROM feedback
WHERE (service_impacted, rating) IN (
  SELECT service_impacted, MIN(rating)
  FROM feedback
  GROUP BY service_impacted
);






#Correlated Subquery
#Exercise 1:List all packages and information for packages with monthly rates are less than the maximum minutes used for each service type.



SELECT  *
FROM service_packages s1 
WHERE monthly_rate < (SELECT max(minutes_used) FROM service_usage s2 GROUP BY s2.service_type HAVING s1.service_type=s2.service_type);





#Exercise2:Find customers who have at least one billing record with an amount due that is greater than their average billing amount.


SELECT c.customer_id, c.first_name, c.last_name, b.amount_due
FROM customer c
JOIN billing b ON c.customer_id = b.customer_id
WHERE b.amount_due = (
  SELECT AVG(b2.amount_due) as avg_amount_due
  FROM billing b2
  WHERE b2.customer_id = c.customer_id
);


