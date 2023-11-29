# SQL Class 2
#Order by
select * from customer Order by first_name desc;  #Ascending=asc, Descending=desc
select * from billing order by amount_due;

#Retrieve the bills, sorted by customer_id in ascending order
select bill_id,customer_id from billing order by customer_id;	

#limit
#I want to see the first 10 customers
select first_name, last_name, customer_id from customer limit 10;

#I want to list the top 5 highest bills from the billing table
select bill_id, customer_id, amount_due from billing order by amount_due desc limit 10;

#retrieve the latest 3 bills by due_date
select bill_id, due_date, amount_due from billing order by due_date desc limit 3;

#DDL
#Rule 1: Always take a backup
create table customer_backup select * from customer;

select count(*) from customer_backup;
#update the datatype of all date columns so we can do computations

select * from customer_backup;

#first update the values in the rows so that MySQL can read it as dates

#set your safe update to off to update your data
set sql_safe_updates = 0;

update customer 
set subscription_date = Str_to_date(subscription_date, '%m/%d/%Y');

alter table customer	
modify subscription_date datetime;

select * from customer;

#Date_of_birth - update the data type of this column to datetime

update customer
set date_of_birth = str_to_date(date_of_birth, "%m/%d/%Y");

alter table customer 
modify date_of_birth datetime;

select customer_id, Date_of_Birth from customer where date_of_birth > "2003-09-01";

update customer
set last_interaction_date = str_to_date(last_interaction_date, "%m/%d/%Y");

alter table customer 
modify last_interaction_date date;
select * from customer;

update billing
set due_date = str_to_date(due_date, '%m/%d/%Y');
alter table billing
modify due_date date;

select * from billing;

select * from billing where payment_date = "12/22/2023";
update billing set payment_date = Replace(payment_date,"12/22/2023", "12/22/2023");

update billing
set payment_date = str_to_date(payment_date, '%d/%m/%Y');
alter table billing
modify payment_date date;

#Insert a new customer named "Henry Red" who subscribed
#on "2023-05-01", but has no last_interaction_date set yet

insert into customer (first_name, last_name, subscription_date)
values ("Henry", "Red", "2023-05-01");

select * from customer where first_name="Henry";
delete from customer where first_name = "Heny";

#Setting customer ID as the primary key
alter table customer add primary key (customer_id);
#Setting autoincrement for customer id
alter table customer modify customer_id int auto_increment;

select * from customer where first_name="Henry";

select * from customer where first_name="Henry";
insert into customer (first_name, last_name, subscription_date)
values ("Henry", "Red", "2023-05-01");


alter table billing add primary key (bill_id);
alter table billing modify bill_id int auto_increment;

#add a billing entry with an amount_due of 100, a due_date of 2023-06-10 
#and no payment_date set

insert into billing (amount_due, due_date) values ("100", "2023-06-10");
select * from billing where amount_due=100;

update billing set due_date = '2024-06-10' where bill_id=1001;
select * from billing where bill_id=1001;

#insert a customer with all details left blank except name "Anonynous"
insert into customer (first_name) values ("Anonymous");
select * from customer where first_name="Anonymous";

#UPDATE

#update all customers with a subscription date before "2023-05-01" to 
#have a new last_interaction date of "2023-05-05"

update customer set last_interaction_date = "2023-05-05" 
where subscription_date<"2023-05-01";

select * from customer where last_interaction_date="2023-05-05";

#for customer named "Anonymous", update the email to "unknown@example.com"
update customer set email = "unknown@example.com" where first_name="Anonymous";
select * from customer where email = "unknown@example.com";

/*increase late fees by 5 for all entries in the billing table 
that have a payment date later than the due date*/

#GIVING ISSUE BECAUSE OF PAYMENT DATE DATA TYPE.... CONFIRM IN TA SESSION
-- update billing set late_fee = late_fee + 5 where payment_date>due_date;

/*Change the `phone_number` 
of the customer with customer_id 10 to "5555555555".*/

update customer set phone_number = "5555555555" where customer_id=10;
select * from customer where Customer_id=10;

 /*Delete all customer who have
 neither a subscription date nor a last interaction date*/
 
 delete from customer where subscription_date is Null 
 and last_interaction_date is null;
 
 #query for all phone numbers that start with 555
 select * from customer where phone_number like '555%';
 
 #update all adresses that have road to rd.
 update customer set address = Replace(address,"Road", "Rd.");
 select billing_cycle from billing;
 
 
 update billing set billing_cycle = upper(billing_cycle);
 
 select * from billing where discounts_applied <= 0;
 update customer set subscription_date = date_add(subscription_date, interval 1 month);
 
 select first_name, year(subscription_date) as 'subscription_year'from customer;
 
 select concat(first_name, ":", email) as "Name and Email" from customer;