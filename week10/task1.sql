
-- Part A

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


-- Part B


alter table accounts add column bank_name varchar(255);

update accounts set bank_name = 'SberBank' where id = 1;
update accounts set bank_name = 'Tinkoff' where id = 2;
update accounts set bank_name = 'SberBank' where id = 3;

insert into accounts values (4, 'FeeStorage', 0, 'RUB');

create or replace function send_money_fee(id_from int, id_to int, amount float)
returns boolean
as
$$
declare
    balance float;
    fee int;
    bank_name1 varchar(255);
    bank_name2 varchar(255);
begin

    select bank_name into bank_name1 from accounts where id = id_from;
    select bank_name into bank_name2 from accounts where id = id_to;

    if bank_name1 = bank_name2 then
        select 30 into fee;
    else
        select 0 into fee;
    end if;

    select credit into balance from accounts where id = id_from;
    if balance < amount then
        return false;
    end if;
    update accounts set credit = balance - amount where id = id_from;
    update accounts set credit = balance + amount where id = id_to;
    update accounts set credit = credit + fee where id = 4;
    return true;
end;
$$ language plpgsql;

begin;
    savepoint sp1;
    select send_money_fee(1, 3, 500);
    select * from accounts ORDER BY id;
    rollback to sp1;
    savepoint sp2;
    select send_money_fee(2, 1, 700);
    select * from accounts ORDER BY id;
    rollback to sp2;
    savepoint sp3;
    select send_money_fee(2, 3, 100);
    select * from accounts ORDER BY id;
    rollback to sp3;
commit;

-- Part C

create table ledger (
    id serial primary key,
    from_id int not null,
    to_id int not null,
    fee int,
    amount float not null,
    date_time timestamp not null
);

-- modified function from the first exercise:
create or replace function send_money2(id_from int, id_to int, amount float)
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
    insert into ledger (from_id, to_id, amount, date_time) values (id_from, id_to, amount, now());
    update accounts set credit = balance - amount where id = id_from;
    update accounts set credit = balance + amount where id = id_to;
    return true;
end;
$$ language plpgsql;

begin;
    savepoint sp1;
    select send_money2(1, 3, 500);
    select * from ledger ORDER BY id;
    rollback to sp1;
    savepoint sp2;
    select send_money2(2, 1, 700);
    select * from ledger ORDER BY id;
    rollback to sp2;
    savepoint sp3;
    select send_money2(2, 3, 100);
    select * from ledger ORDER BY id;
    rollback to sp3;
commit;

-- modified function from the second exercise:
create or replace function send_money_fee2(id_from int, id_to int, amount float)
returns boolean
as
$$
declare
    balance float;
    fee int;
    bank_name1 varchar(255);
    bank_name2 varchar(255);
begin

    select bank_name into bank_name1 from accounts where id = id_from;
    select bank_name into bank_name2 from accounts where id = id_to;

    if bank_name1 = bank_name2 then
        select 30 into fee;
    else
        select 0 into fee;
    end if;

    select credit into balance from accounts where id = id_from;
    if balance < amount then
        return false;
    end if;
    insert into ledger values (default, id_from, id_to, fee, amount, now());
    update accounts set credit = balance - amount where id = id_from;
    update accounts set credit = balance + amount where id = id_to;
    update accounts set credit = credit + fee where id = 4;
    return true;
end;
$$ language plpgsql;

begin;
    savepoint sp1;
    select send_money_fee2(1, 3, 500);
    select * from ledger ORDER BY id;
    rollback to sp1;
    savepoint sp2;
    select send_money_fee2(2, 1, 700);
    select * from ledger ORDER BY id;
    rollback to sp2;
    savepoint sp3;
    select send_money_fee2(2, 3, 100);
    select * from ledger ORDER BY id;
    rollback to sp3;
commit;