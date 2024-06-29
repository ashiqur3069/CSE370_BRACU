--1. Find the name and loan number of all customers having a loan at the Downtown branch.

select c.customer_name, b.loan_number from customer c 
join borrower b on c.customer_id = b.customer_id
join loan l on b.loan_number = l.loan_number where l.branch_name = ‘downtown’;

--2. Find all the possible pairs of customers who are from the same city. show in the format Customer1, Customer2, City.

Select c1.customer_name as Customer1,
c2.customer_name as Customer2,
c1.customer_city as City
from customer c1
Join customer c2 on c1.customer_city = c2.customer_city
Where c1.customer_id < c2.customer_id;

--3. If the bank gives out 4% interest to all accounts, show the total interest across each branch. Print Branch_name, Total_Interest.

Select ac.branch_name as Branch_name,
sum(4/100 * ac.balance) as Total_interest from account ac
Group by ac.branch_name;

--4. Find account numbers with the highest balances for each city in the database

Select a.account_number, b.branch_city, a.balance from account a
Join branch b on a.branch_name = b.branch_name 
Where (b.branch_city, a.balance) in (select b.branch_city, max(a.balance) as highest from account a join branch b on a.branch_name = b.branch_name group by b.branch_city);

--5. Show the loan number, loan amount, and name of customers with the top 5 highest loan amounts. 
--The data should be sorted by increasing amounts, then decreasing loan numbers in case of the same loan amount. [Hint for top 5: Check the "limit" keyword in mysql].

select l.loan_number, l.amount, c.customer_name from loan l
join borrower b on l.loan_number = b.loan_number
join customer c on b.customer_id = c.customer_id
Order by l.amount, l.loan_number DESC
limit 5;

--6. Find the names of customers with an account and also a loan at the Perryridge branch. 

select c.customer_name from customer c where exists 
(select 1 from depositor d where d.customer_id = c.customer_id)
and exists (select 1 from borrower b join loan l on b.loan_number = l.loan_number
where l.branch_name = 'perryridge' and b.customer_id = c.customer_id);

--7. Find the total loan amount of all customers having at least 2 loans from the bank. Show in format customer name, total_loan.

select c.customer_name, sum(l.amount) as total_loan from customer c
join borrower b on c.customer_id = b.customer_id
join loan l on b.loan_number = l.loan_number
group by c.customer_id, c.customer_name
having count(b.loan_number) >= 2;

