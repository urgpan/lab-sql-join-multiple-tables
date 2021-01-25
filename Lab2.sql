-- Write a query to display for each store its store ID, city, and country.

	select s.store_id, c.city, y.country from store as s
	join address as a
	on s.address_id = a.address_id
	join city as c
	on a.city_id = c.city_id
	join country as y
	on c.country_id = y.country_id;

-- Write a query to display how much business, in dollars, each store brought in.

	-- payment > customer > store 
    -- Table Payment (amount) > Customer (customer_id) > Store (store_id)
    
	select s.store_id ,sum(p.amount) from payment as p
	left join customer as c
	on p.customer_id = c.customer_id
	join store as s
	on c.store_id = s.store_id
	group by s.store_id;

-- What is the average running time of films by category?
	select  c.name, round(avg(fl.length),0)
	from category as c
	join film_category as f 
	on c.category_id = f.category_id
    join film as fl
    on fl.film_id = f.film_id
	group by c.name;

-- Which film categories are longest?
	select  c.name, avg(fl.length)
	from category as c
	join film_category as f 
	on c.category_id = f.category_id
    join film as fl
    on fl.film_id = f.film_id
	group by c.name
    order by avg(fl.length) desc
    limit 1;

-- Display the most frequently rented movies in descending order.
	#rental (inventory_id) > inventory (film_id) > films
	select count(r.rental_id), f.title from rental as r
    join inventory as i
    on r.inventory_id = i.inventory_id
    join film as f
    on f.film_id = i.film_id
    group by f.title
    order by count(r.rental_id) desc;


#List the top five genres in gross revenue in descending order.

	select c.name, sum(p.amount) AS total_amount
	from sakila.category as c
		join sakila.film_category as f
			on c.category_id = f.category_id
		join sakila.rental as r
			on f.film_id = r.rental_id
		join sakila.payment as p
			on r.rental_id = p.rental_id
	group by c.category_id
	ORDER BY total_amount desc
	LIMIT 5;
    
    #Table cat film_id > invent(inv_id) > rental (rental_id) > Payment(rental_id)
	select c.name, sum(p.amount) AS total_amount
	from sakila.category AS c
		join sakila.film_category AS f
			on c.category_id = f.category_id
		join sakila.inventory AS i
			on f.film_id = i.film_id
		join sakila.rental AS r
			on i.inventory_id = r.inventory_id
		join sakila.payment as p
			on r.rental_id = p.rental_id
	group by c.category_id
	ORDER BY total_amount desc
	LIMIT 5;
    
#Is "Academy Dinosaur" available for rent from Store 1? NO
	SELECT f.title, r.rental_date, r.return_date, store_id
	from sakila.rental as r
		join sakila.inventory as i
			on r.inventory_id = i.inventory_id
		join sakila.film as f
			on f.film_id = i.film_id
	WHERE f.title = "Academy Dinosaur" and return_date is NULL and store_id = 1;





