n-- quiering the count of songs, name of artist and the total price for each artist based on artist
-- chart 1
select Artist.Name, count(Track.Name) as Songs, sum(Track.UnitPrice) as Song_Total_Price
from Artist
join Album
on Album.ArtistId = Artist.ArtistId
join Track
on Track.AlbumId = Album.AlbumId
group by Artist.Name
order by count(Track.Name) desc

-- Most popular genre from USA to Canada
-- chart 2
-- USA
select billingcountry, Genre.Name, count(Genre.Name) as Genre, strftime('%Y', Invoice.InvoiceDate) as Year
from Invoice
join InvoiceLine
on Invoice.InvoiceId = InvoiceLine.InvoiceId
join Track
on InvoiceLine.TrackId = Track.TrackId
join Album
on Track.AlbumId = Album.AlbumId
join Artist
on Album.ArtistId = Artist.ArtistId
join Genre
on Track.GenreId = Genre.GenreId
where billingcountry = 'USA' and Invoice.InvoiceDate like '%2013%'
group by billingcountry, Genre.GenreId
order by count(billingcountry) desc
limit 10

-- highest paid
select billingcountry , sum(total) as HighestPaid
from Invoice
group by 1
order by count(total) desc
limit 10

-- Canada
select billingcountry, Genre.Name, count(Genre.Name) as Genre, strftime('%Y', Invoice.InvoiceDate) as Year
from Invoice
join InvoiceLine
on Invoice.InvoiceId = InvoiceLine.InvoiceId
join Track
on InvoiceLine.TrackId = Track.TrackId
join Album
on Track.AlbumId = Album.AlbumId
join Artist
on Album.ArtistId = Artist.ArtistId
join Genre
on Track.GenreId = Genre.GenreId
where billingcountry = 'Canada' and Invoice.InvoiceDate like '%2013%'
group by billingcountry, Genre.GenreId
order by count(billingcountry) desc
limit 10

-- Top 10 artists
-- chart 3
select Artist.Name, count(Track.Name) as Songs, sum(Track.UnitPrice) as SongPrice
from Artist
join Album
on Artist.ArtistId = Album.ArtistId
join Track
on Track.AlbumId = Album.AlbumId
group by 1
order by count(Track.Name) desc

-- Top Cutstomer
-- chart 4
select Customer.FirstName, sum(InvoiceLine.UnitPrice * InvoiceLine.Quantity) as Customer_Price, Customer.Country
from Customer
join Invoice
on Customer.CustomerId = Invoice.CustomerId
join InvoiceLine
on InvoiceLine.InvoiceId = Invoice.InvoiceId
where Customer.Country like 'USA'
group by Customer.CustomerId
order by 2 desc

-- chart 5
-- years of growth in usa and canada


-- Month and Year
select strftime('%Y-%m', Invoice.InvoiceDate) as Year, Invoice.BillingCountry, sum(Invoice.Total) as Total
from Invoice
where Invoice.BillingCountry in ('Canada') and Invoice.InvoiceDate like '%2013%'
group by 1
order by 1 desc

-- Year
select strftime('%Y', Invoice.InvoiceDate) as Year, Invoice.BillingCountry, sum(Invoice.Total) as Total
from Invoice
where Invoice.BillingCountry in ('Canada')
group by 1
order by 1 desc
