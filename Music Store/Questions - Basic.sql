-- Who is the most senior employee based on (highest levels)
select * from employee
order by levels desc
limit 1;


-- Which countries have the most invoices
select count(*) as country_freq, billing_country
from invoice
group by billing_country
order by country_freq desc;


-- What are top 3 values of total invoice
select total from invoice
order by total desc;



-- Which city has the best customers ? 
-- We would like to throw a promotional Music Festival in the city we made the most money.
-- Write a query that returns one city that has the highest sum of invoice totals.
-- Return both the city name & sum of all invoice totals.

select billing_city, sum(total) as invoice_total from invoice
group by billing_city
order by invoice_total desc;



-- Who is the best customer ? 
-- The customer who has spent the most money will be declared the best customer.
-- Write a query that returns the person who has spent the most money
select customer_id, sum(total) as total from invoice
group by customer_id
order by total desc;

	-- Joining Customer & Invoice tables
select customer.customer_id, customer.first_name, customer.last_name, sum(total) as total 
from invoice join customer
on invoice.customer_id = customer.customer_id
group by customer.customer_id
order by total desc
limit 1;