-- First query
select film.film_id, film.title from film
left join inventory on film.film_id = inventory.film_id
left join rental on inventory.inventory_id = rental.inventory_id
left join film_category on film.film_id = film_category.film_id
left join category on film_category.category_id = category.category_id
where (film.rating = 'R' or film.rating = 'PG-13')
and (category.name='Horror' or category.name='Sci-fi')
group by film.film_id
having count (rental.rental_id) = 0
order by film.film_id;

explain analyze select film.film_id, film.title from film
left join inventory on film.film_id = inventory.film_id
left join rental on inventory.inventory_id = rental.inventory_id
left join film_category on film.film_id = film_category.film_id
left join category on film_category.category_id = category.category_id
where (film.rating = 'R' or film.rating = 'PG-13')
and (category.name='Horror' or category.name='Sci-fi')
group by film.film_id
having count (rental.rental_id) = 0
order by film.film_id;

-- The most expensive steps of the query:
-- joining the inventory
-- joining the film category

-- Possible solution:
-- create index on inventory(film_id)
-- create index on film_category(category_id)


-- Second query
select store.store_id, sum(payment.amount) from store
left join payment on store.manager_staff_id = payment.staff_id
where payment.payment_date >= DATE_TRUNC('month', (select max(payment_date) from payment))
group by store.store_id
order by sum(payment.amount) desc;

explain analyze select store.store_id, sum(payment.amount) from store
left join payment on store.manager_staff_id = payment.staff_id
where payment.payment_date >= DATE_TRUNC('month', (select max(payment_date) from payment))
group by store.store_id
order by sum(payment.amount) desc;

-- The most expensive step of the query:
-- payment.payment_date >= DATE_TRUNC('month', (select max(payment_date) from payment))

-- Possible solution:
-- create index on payment(payment_date)