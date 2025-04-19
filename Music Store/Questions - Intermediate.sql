-- Write a query to return the email,first name,last name & genre of all Rock Music listeners.
-- Return your list ordered alphabetically by email starting with A

	-- Connect & join tables : Genre --> Track --> InvoiceLine --> Invoice --> Customer 
	-- Or  Customer --> Invoice --> InvoiceLine --> Track --> Genre
select * from genre;
select * from track;
select * from invoice_line;
select * from invoice;
select * from customer;

select distinct email,first_name,last_name,genre
from genre join track
on genre.genre_id = track.genre_id
join invoice_line
on track.track_id = invoice_line.track_id
join invoice
on invoice_line.invoice_id = invoice.invoice_id
join customer
on invoice.customer_id = customer.customer_id
where email like 'a%' and genre.name = 'Rock';

	-- OR
	
select distinct email, first_name, last_name
from customer join invoice
on customer.customer_id = invoice.customer_id
join invoice_line 
on invoice.invoice_id = invoice_line.invoice_id
join track 
on invoice_line.track_id = track.track_id
join genre
on track.genre_id = genre.genre_id
where genre.name = 'Rock'
order by email;

	-- OR

select distinct email, first_name, last_name
from customer join invoice
on customer.customer_id = invoice.customer_id
join invoice_line 
on invoice.invoice_id = invoice_line.invoice_id
where track_id in(
	select track_id from track
	join genre
	on track.genre_id = genre.genre_id
	where genre.name like 'Rock'
)
order by email;



-- Let's invite the artists who have written the most rock music in our dataset.
-- Write a query that returns the Artist name and total track count of the top 10 rock bands

select * from artist;
select * from album;
select * from track;
select * from genre;


select artist.artist_id , artist.name, count(artist.artist_id) as number_of_songs
from track join album
on track.album_id = album.album_id
join artist
on album.artist_id = artist.artist_id
join genre 
on track.genre_id = genre.genre_id
where genre.name = 'Rock'
group by artist.artist_id
order by number_of_songs desc
limit 10;




-- Return all the track names that have a song length longer that the average song length.
-- Return the Name and Milliseconds for each track.
-- Order by song length with the longest songs listed first

select name,milliseconds from track
where milliseconds > (
	select avg(milliseconds) as avg_length
	from track
)
order by milliseconds desc;






