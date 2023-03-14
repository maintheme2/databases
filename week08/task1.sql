select * from customer;

explain analyze select * from customer;

create index customer_name_idx on customer using btree (name);
create index customer_city_idx on customer using hash (address);

explain analyze select * from customer;

drop index customer_name_idx;
drop index customer_city_idx;

-- Execution time decreased after creating indexes. The second query is faster.