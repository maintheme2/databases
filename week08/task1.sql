select * from customer;

explain analyze select address from customer where name = 'Mark Thomas';
create index customer_name_idx on customer using hash (name);
explain analyze select address from customer where name = 'Mark Thomas';

drop index customer_name_idx;

-- Execution time, Planning time and cost decreased after setting the index. 
-- For the first query: cost=0.00..43.50, Planning time: 1.136ms, Execution time: 0.423ms.
-- For the secind query: cost=0.00..8.02, Planning time: 0.684ms, Execution time: 0.186ms.

explain analyze select name from customer where address like '0%';
create index customer_address_idx on customer using btree (address text_pattern_ops);
explain analyze select name from customer where address like '0%';

drop index customer_address_idx;

-- Execution time, Planning time and cost decreased after setting the index. 
-- For the first query: cost=0.00..43.50, Planning time: 1.567ms, Execution time: 0.788ms.
-- For the secind query: cost=9.49..41.98, Planning time: 0.244ms, Execution time: 0.085ms.
