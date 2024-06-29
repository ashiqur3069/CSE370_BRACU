-- create the database 
create database LAB_2;
-------------------------
Use LAB_2;
----------------------------
CREATE TABLE Employee (
    employee_id CHAR(10),
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    email VARCHAR(60),
    phone_number CHAR(14),
    hire_date DATE,
    job_id CHAR(10),
    salary INT,
    commission_pct DECIMAL(5,3),
    manager_id CHAR(10),
    department_id CHAR(10)
);
------------------------------
describe employee;
------------------------------
INSERT INTO Employee (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
VALUES
('EMP001', 'Shoaib', 'Ahmed', 'shoiab.ahmed@bracu.ac.bd', '123-456-7890', '2023-01-01', 'JOB001', 50000, 0.100, 'MNG001', 'DPT001'),
('EMP002', 'Dewan', 'Karim', 'dewan.karim@bracu.ac.bd', '123-456-7891', '2023-02-01', 'JOB002', 60000, 0.200, 'MNG001', 'DPT002'),
('EMP003', 'Farida', 'Chowdhury', 'farida.chowdhury@bracu.ac.bd', '123-456-7892', '2023-03-01', 'JOB003', 45000, 0.150, 'MNG002', 'DPT003'),
('EMP004', 'Farden', 'Khan', 'farden.khan@bracu.ac.bd', '123-456-7893', '2023-04-01', 'JOB004', 55000, 0.050, 'MNG002', 'DPT004'),
('EMP005', 'Fakhruddin', 'Gazzali', 'fakhruddin.gazzali@bracu.ac.bd', '123-456-7894', '2023-05-01', 'JOB005', 70000, 0.300, 'MNG003', 'DPT005'),
('EMP006', 'Farhan', 'Feroz', 'farhan.feroz@bracu.ac.bd', '123-456-7895', '2023-06-01', 'JOB006', 40000, 0.400, 'MNG003', 'DPT006'),
('EMP007', 'Fatiha', 'Chowdhury', 'fatiha.chowdhury@bracu.ac.bd', '123-456-7896', '2023-07-01', 'JOB007', 30000, 0.250, 'MNG004', 'DPT007'),
('EMP008', 'Faisal', 'Ahmed', 'faisal.ahmed@bracu.ac.bd', '123-456-7897', '2023-03-01', 'JOB008', 80000, 0.350, 'MNG004', 'DPT001'),
('EMP009', 'Farig', 'Sadeque', 'farig.sadeque@bracu.ac.bd', '123-456-7898', '2023-09-01', 'JOB009', 20000, 0.450, 'MNG005', 'DPT002'),
('EMP010', 'Fardin', 'Nafis', 'fardin.nafis@bracu.ac.bd', '123-456-7899', '2023-10-01', 'JOB010', 35000, 0.500, 'MNG005', 'DPT003'),
('EMP011', 'Golam', 'Alam', 'golam.alam@bracu.ac.bd', '123-456-7900', '2023-11-01', 'JOB011', 40000, 0.250, 'MNG006', 'DPT004'),
('EMP012', 'Himaddri', 'Roy', 'himaddri.roy@bracu.ac.bd', '123-456-7901', '2023-12-01', 'JOB012', 60000, 0.200, 'MNG006', 'DPT005'),
('EMP013', 'Ipshita', 'Upoma', 'ipshita.upoma@bracu.ac.bd', '123-456-7902', '2024-01-01', 'JOB013', 50000, 0.100, 'MNG007', 'DPT006'),
('EMP014', 'Ishrat', 'Jahan', 'ishrat.jahan@bracu.ac.bd', '123-456-7903', '2024-03-01', 'JOB014', 45000, 0.150, 'MNG007', 'DPT007'),
('EMP015', 'Imam', 'Zulkarnain', 'imam.zulkarnain@bracu.ac.bd', '123-456-7904', '2024-03-01', 'JOB015', 55000, 0.050, 'MNG008', 'DPT001');

---------------------------------
Select * from Employees;
---------------------------------
--1. Find the first_name, last_name, email, phone_number, hire_date and department_id of all the employees with the latest hire_date.

select first_name, last_name, email, phone_number, hire_date, 
department_id from Employee where hire_date = (select MAX(hire_date) 
from Employee);

--2. Find the first_name, last_name, employee_id, phone_number, salary and department_id of all the employees with the lowest salary in each department. 

select first_name, last_name, employee_id, phone_number, salary, department_id
from Employee
where salary = (
    select min(salary)
    from Employee AS e1
    where e1.department_id = Employee.department_id
);

--3. Find the first_name, last_name, employee_id, commission_pct and department_id of all the employees 
--in the department 'DPT007' who have a lower commission_pct than all of the department 'DPT005' employees.

select first_name, last_name, employee_id, commission_pct, department_id from Employee 
where department_id = 'DPT007' and commission_pct < (select min(commission_pct) from Employee where department_id = 'DPT005');

--4. Find the department_id and total number of employees of each department which does not have a single employee under it with a salary more than 30,000.

select department_id, count(*) as total_employee from Employee
group by department_id
having max(salary) <= 30000;

--5. For each department, find the department_id, job_id and commission_pct with commission_pct less than at least one other job_id in that department.

select department_id, job_id, commission_pct
from Employee e1
where commission_pct < (
    select MAX(e2.commission_pct)
    from Employee e2
    where e2.department_id = e1.department_id
);
--6.  Find the manager_id who does not have any employee under them with a salary less than 3500.

select DISTINCT manager_id from Employee AS e1 where NOT EXISTS (SELECT 1 from Employee AS e2 where e2.manager_id = e1.manager_id AND e2.salary < 3500);

--7. Find the first_name, last_name, employee_id, email, salary, department_id and commission_pct of the employee with the lowest commission_pct under each manager. 

select first_name, last_name, employee_id, email, salary, 
department_id, commission_pct from employee e1 
where commission_pct = (select min(commission_pct) 
from employee e2 where e1.manager_id = e2.manager_id);































