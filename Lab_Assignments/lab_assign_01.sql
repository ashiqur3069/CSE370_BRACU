--1. Create the above table with the appropriate data type for each column.
create database LAB_Assignment_1;

use LAB_Assignment_1;

create table Developers(member_id int, name varchar(30), email varchar(30), influence_count int, joining_date date, multiplier int);

Describe Developers;

insert into Developers values
(1, 'Taylor Otwell', 'otwell@laravel.com', 739360, '2020-06-10', 10),
(2, 'Ryan Dahl', 'ryan@nodejs.org', 633632, '2020-04-22', 10),
(3, 'Brendan Eich', 'eich@javascript.com', 939570, '2020-05-07', 8),
(4, 'Evan You', 'you@vuejs.org', 982630, '2020-06-11', 7),
(5, 'Rasmus Lerdorf', 'lerdorf@php.net', 937927, '2020-06-03', 8),
(6, 'Guido van Rossum', 'guido@python.org', 968827, '2020-07-18', 19),
(7, 'Adrian Holovaty', 'adrian@djangoproject.com', 570724, '2020-05-07', 5),
(8, 'Simon Willison', 'simon@djangoproject.com', 864615, '2020-04-30', 4),
(9, 'James Gosling', 'james@java.com', 719491, '2020-05-18', 5),
(10, 'Rod Johnson', 'rod@spring.io', 601744, '2020-05-18', 7),
(11, 'Satoshi Nakamoto', 'nakamoto@blockchain.com', 630488, '2020-05-10', 10);

--2. Change the column name "influence_count". The new name should be "followers," and the data type should be integer. 
ALTER TABLE Developers CHANGE COLUMN influence_count followers INT;

--3. Update the number of followers of each developer by +10.
UPDATE Developers SET followers = followers + 10;
--To view the changes.
Select * from Developers;

--4. There is a formula to find the efficiency of the developers. Efficiency = ((followers*100/1000000) * (multipliers*100/20))/100. Show the efficiency of each developer in a column named "Efficiency" along with their name.
select name, ((followers*100/1000000) * (multiplier*100/20))/100 as Efficiency FROM Developers;

--5. Show the name of the developers in UpperCase and the descending order of their Joining_date.   
select upper(name) as name, joining_date from Developers ORDER BY joining_date DESC;

--6. Retrieve the member_ id, name, email and followers of the developers who have either ".com" or ".net" in their email address. 
select member_id, name, email, followers from Developers where email LIKE '%.com%' OR email LIKE '%.net%';
