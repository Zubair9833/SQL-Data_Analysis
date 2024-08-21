1. who is the senior most employee based on job profile?

select first_name, last_name , levels
from employee
order by levels desc
limit 1

2. which country has the most invoices?

select COUNT(billing_country) as Total_invoices, billing_country
from invoice
group by billing_country
order by  billing_country desc
limit 1

3. what are top 3 values of total invoices

select total , billing_country 
from invoice
order by total desc
limit 3 

4. which country has the best customer we would like to throw a music festival in the 
city we made the most money write a query that return one city that has the sum of total
return both the city and sum of all invoices totals

select billing_city, sum(total)
from invoice
group by billing_city
order by sum(total) desc
limit 1

5. who is the best customer? the customer who had spend the most money will be declare 
as a best customer write a query to get the person who has spent the most money 


select first_name,last_name,sum(total)
from customer
join invoice
on customer.customer_id = invoice.customer_id
group by first_name,last_name
order by sum(total) desc
limit 1

R madhav is declared as the best customer

Sql query for intermediate level
	
Write a query to return the email,first_name, last_name,& Genre of all rock music listners.
return your list ordered alphabetecially by email staring with A

select DISTINCT email,first_name,last_name
from customer
join invoice on customer.customer_id = invoice.customer_id
join invoice_line on invoice.invoice_id = invoice_line.invoice_id
join track on invoice_line.track_id = track.track_id
join genre on track.genre_id = genre.genre_id
where genre.name like 'Rock'
order by email asc

2. Lets invite the artist who have who have written the most rock music in our dataset
write a query that return the artist name and total track count of the top rock bands

select artist.artist_id,artist.name,COUNT(artist.artist_id) as number_of_songs
from artist
join album on artist.artist_id = album.artist_id
join track on album.album_id = track.album_id
join genre on track.genre_id = genre.genre_id
WHERE genre.name like 'Rock'
GROUP BY artist.artist_id
ORDER BY number_of_songs desc
limit 10

3. return all the track names that have a song lenght longer than the average song lenght
return the name and milisecond for each track order by the song lenght with the longest song
listed first




select name, milliseconds
from track
where milliseconds > (
	select avg(milliseconds) as avg_lenght_songs from track
)
order by milliseconds desc

SQL ADVANCE QUERY

1. FIND HOW MANY SPENT BY EACH CUSTOMER ON ARTIST? 
   WRITE A QUERY TO RETURN CUSTOMER NAME, ARTIST NAME AND TOTAL SPENT

WITH best_selling_artist AS(
	SELECT artist.artist_id as artist_id,artist.name as artist_name,
	sum(invoice_line.unit_price * invoice_line.quantity) as total_sales
	from invoice_line
	join track on invoice_line.track_id = track.track_id
	join album on album.album_id = track.album_id
	join artist on album.artist_id = artist.artist_id
	GROUP BY 1
	ORDER BY 3 DESC
	LIMIT 1
)

SELECT c.customer_id,c.first_name,c.last_name,best_selling_artist.artist_name,
sum(il.unit_price * il.quantity) as Amount_spent
from invoice i
join customer c on c.customer_id = i.customer_id
join invoice_line il on il.invoice_id = i.invoice_id
join track t on il.track_id = t.track_id
join album a on a.album_id = t.album_id
join best_selling_artist on best_selling_artist.artist_id = a.artist_id
GROUP BY 1,2,3,4
ORDER BY 5 DESC














