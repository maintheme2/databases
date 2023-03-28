

--                                                  Part A

drop table if exists accounts;

create table accounts (
    id int primary key,
    name varchar(255) not null,
    credit float not null,
    currency varchar(255) not null
);

insert into accounts values (1, 'Alice', 1000.00, 'RUB');
insert into accounts values (2, 'Bob', 1000.00, 'RUB');
insert into accounts values (3, 'Charlie', 1000.00, 'RUB');

create or replace function send_money(id_from int, id_to int, amount float)
returns boolean
as
$$
declare
    balance float;
begin
    select credit into balance from accounts where id = id_from;
    if balance < amount then
        return false;
    end if;
    update accounts set credit = balance - amount where id = id_from;
    update accounts set credit = balance + amount where id = id_to;
    return true;
end;
$$ language plpgsql;

begin;
    savepoint sp1;
    select send_money(1, 3, 500);
    select credit from accounts;
    rollback to sp1;
    savepoint sp2;
    select send_money(2, 1, 700);
    select credit from accounts;
    rollback to sp2;
    savepoint sp3;
    select send_money(2, 3, 100);
    select credit from accounts;
    rollback to sp3;
commit;

select credit from accounts;


--                                                  Part B

alter table accounts add column bank_name varchar(255);

update accounts set bank_name = 'SberBank' where id = 1;
update accounts set bank_name = 'Tinkoff' where id = 2;
update accounts set bank_name = 'SberBank' where id = 3;

insert into accounts values (4, 'FeeStorage', 0, 'RUB');

