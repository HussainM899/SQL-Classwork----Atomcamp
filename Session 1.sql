# sanity check to be performed after loading data

select count(*) from customer;
select count(*) from billing;

select first_name, last_name, subscription_date from customer;

#display all columns from the billing table
select * from billing;

#display unique values
select distinct(billing_cycle) from billing;
select count(distinct(billing_cycle)) from billing;

#show only bill_id and amount_due from billing
select bill_id, amount_due from billing;

#identify a customer who lives 668 Sherman Terrace
select customer_id, First_name, Last_name, address from customer where address="668 Sherman Terrace";

#find bills that are greater than 1000
select bill_id, amount_due from billing where amount_due>1000;

select customer_id,first_name,address 
 from customer
 where address='5 Northridge Road' or address='814 Kinsman Lane';
 
 select customer_id,first_name,address 
 from customer
 where address in ('5 Northridge Road','814 Kinsman Lane');
 
 select customer_id,first_name,Phone_number
 from customer
 where Phone_number != '123-456-7890';
 
  select customer_id,first_name,Phone_number
 from customer
 where Phone_number <> '123-456-7890'; # not equal to
 
 select bill_id,billing_cycle from billing where billing_cycle not in ('23-Jan','23-Feb');
 