-- Find how much amount spent by each customer on artists? 
-- Write a query to return the customer name,artist name and total spent

	-- find best selling artist
with best_selling_artist as (
	select artist.artist_id, artist.name, sum(invoice_line.unit_price * invoice_line.quantity)
	from invoice_line join track
	on invoice_line.track_id = track.track_id
	join album
	on track.album_id = album.album_id
	join artist 
	on album.artist_id = artist.artist_id
	group by 1
	order by 3 desc
)	
select customer.customer_id, customer.first_name,customer.last_name, best_selling_artist.name , sum(invoice_line.unit_price * invoice_line.quantity)
from customer join invoice
on customer.customer_id = invoice.customer_id
join invoice_line 
on invoice.invoice_id = invoice_line.invoice_id
join track
on invoice_line.track_id = track.track_id
join album 
on track.album_id = album.album_id
join best_selling_artist 
on album.artist_id = best_selling_artist.artist_id
group by customer.customer_id,2,customer.last_name,4
order by 5 desc;


-- We want to find out the most popuplar music Genre for each country.
-- We determine the most popular genre as the genre with the highest amount of purchases.
-- Write a query that returns each country along with the top Genre.
-- For countries where the max number of purchases.

with popular_genre as 
(
	select count(invoice_line.quantity) as purchases,customer.country, genre.name, genre.genre_id,
	ROW_NUMBER() OVER(partition by customer.country order by count(invoice_line.quantity)desc) as RowNo
	from invoice_line
	join invoice on invoice.invoice_id = invoice_line.invoice_id
	join customer on customer.customer_id = invoice.customer_id
	join track on track.track_id = invoice_line.track_id
	join genre on genre.genre_id = track.genre_id
	group by 2,3,4
	order by 2 asc, 1 desc
)

select * from popular_genre where RowNo <= 1



-- Write a query that determines the customer that has spent the most on music for each country.
-- Write a query that returns the country along with the top customer and how much they spent.
-- For countries where the top amount spent is shared, provide all customers who spent this amount.

with customer_with_country as (
		select customer.customer_id, customer.first_name, customer.last_name, invoice.billing_country,
		sum(total) as total_spent,
		ROW_NUMBER() over(partition by invoice.billing_country order by sum(total)desc) as RowNo
			from invoice
			join customer on customer.customer_id = invoice.customer_id
			group by 1,2,3,4
			order by 4 asc, 5 desc)

select * from customer_with_country where RowNo <= 1