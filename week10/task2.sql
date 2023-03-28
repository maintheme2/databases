create table accounts2(
    username varchar(255),
    fullname varchar(255),
    balance int,
    group_id int
);
drop table accounts2;
insert into accounts2 values
    ('jones', 'Alice Jones', 82, 1),
    ('bitdiddl', 'Ben Bitdiddle', 65, 1),
    ('mike', 'Michael Dole', 73, 2),
    ('alyssa', 'Alyssa P.Hacker', 79, 3),
    ('bbrow', 'Bob Brown', 100, 3);


select * from accounts2;