CREATE TABLE Student (
id int NOT NULL PRIMARY KEY,
name varchar(50) NOT NULL,
native_language char(50)
);

CREATE TABLE Specialization (
name varchar(50) PRIMARY KEY
);

CREATE TABLE Course (
name varchar(50) PRIMARY KEY,
credits int
);


CREATE TABLE Enroll (
name varchar(50),
id int,
primary key (name, id),
foreign key (name) references Course(name),
foreign key (id) references Student(id)
);

CREATE TABLE Takes(
name varchar(30),
id int,
primary key (name, id),
foreign key (name) references Specialization(name),
foreign key (id) references Student(id)
);

insert into Student (id, name, native_language)
values 
(0, 'Oleg', 'russian'),
(1, 'Ivan', 'russian'),
(2, 'Dave', 'english'),
(3, 'Dima', 'russian'),
(4, 'Albert', 'russian'),
(5, 'Karina', 'russian'),
(6, 'Igor', 'russian'),
(7, 'Polina', 'russian'),
(8, 'Said', 'russian'),
(9, 'Ayaz', 'russian'),
(10, 'Lev', 'russian'),
(11, 'John', 'english'),
(12, 'Bobby', 'english');

insert into Specialization (name)
values 
('Robotics'),
('Data Science'),
('Cyber sec'),
('Software dev'),
('Artifial intelligence');

insert into Takes (id, name)
values
(0, 'Data Science'),
(1, 'Software dev'),
(2, 'Robotics'),
(3, 'Data Science'),
(4, 'Data Science'),
(5, 'Data Science'),
(6, 'Cyber sec'),
(7, 'Data Science'),
(8, 'Data Science'),
(9, 'Data Science'),
(10, 'Data Science'),
(11, 'Robotics'),
(12, 'Robotics');

insert into Course (name, credits)
values
('stat', 4),
('ml', 3),
('database', 2),
('nature computing', 2),
('networks', 1);

insert into Enroll (id, name)
values
(0, 'stat'),
(0, 'ml'),
(0, 'database'),
(0, 'nature computing'),
(0, 'networks'),
(1, 'stat'),
(1, 'ml'),
(1, 'database'),
(1, 'nature computing'),
(1, 'networks'),
(2, 'stat'),
(2, 'ml'),
(2, 'database'),
(2, 'nature computing'),
(2, 'networks');

select name from Student
limit 10;

select name from Student
where native_language != 'russian';

select Student.name from Student
inner join Takes on Takes.id==Student.id
where Takes.name == 'Robotics';

select Student.name, Course.name
from Student inner join Enroll
on Student.id = Enroll.id
inner join Course
on Enroll.name == Course.name where Course.credits < 3

select Course.name
from Course inner join Enroll
on Course.name = Enroll.name
inner join Student
on Enroll.id = Student.id where Student.native_language = 'english'

