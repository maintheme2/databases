-- task 1:
-- The relation is already in 1NF
ALTER TABLE orders RENAME TO qwerty;

create table Customers (
    customerId int,
    customerName varchar(255),
    city varchar(255),
    primary key (customerId)
);

create table Items (
    itemId int,
    itemName varchar(255),
    price real,

    primary key (itemId)
);

create table Orders (
    orderId int,
    customerId int,
    date date,
    foreign key (customerId) references Customers(customerId),
    primary key (orderId)
);

create table OrderDetails (
    orderId int,
    itemId int,
    quantity int,
    foreign key (orderId) references Orders(orderId),
    primary key (orderId, itemId)
);

insert into Customers select distinct customerId, customerName, city from qwerty;
insert into Items select distinct itemId, itemName, price from qwerty;
insert into Orders select distinct orderId, customerId, date from qwerty;
insert into OrderDetails select distinct orderId, itemId, quantity from qwerty;

drop table qwerty;

-- the relations are already in 3NF.

select orderId, sum(quantity) as totalItems, sum(quantity * price) as totalAmount
from OrderDetails inner join Items using (itemId) group by orderId;

select customerId, sum(quantity * price) as purchaseAmount
from OrderDetails
    inner join Orders using (orderId)
    inner join Items using (itemId)
    group by customerId
    order by purchaseAmount desc
    limit 1;

