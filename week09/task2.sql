create or replace function retrieve_customers(start int, stop int)
returns table(customer_id int, first_name varchar(100), last_name varchar(100), email varchar(100))
as
$$
begin
    if (start < 0 or start > 599) or (stop < 0 or stop > 599) 
    then
        raise exception 'Invalid range';
    end if;
    if (start > stop)
    then
        raise exception 'Start is greater than stop';
    end if;
    return query
    select customer.customer_id, customer.first_name, customer.last_name, customer.email
    from customer
    where customer.customer_id between start and stop
    order by customer.address_id;
end;
$$ language plpgsql;

-- drop function retrieve_customers;

select * from retrieve_customers(10, 40)
