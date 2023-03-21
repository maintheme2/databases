select * from address;
select * from city;
select * from country;

create or replace function get_addresses()
returns table(address varchar(100))
as
$$
begin
    return query
    select address.address
    from address 
    left join city on address.city_id = city.city_id
    left join country on city.country_id = country.country_id
    where address.address like '%11%' and address.city_id between 400 and 600;
end;
$$ language plpgsql;

select * from get_addresses();

drop function get_addresses;

select address.address, longitude, latitude
from address 
where longitude is not null and latitude is not null;