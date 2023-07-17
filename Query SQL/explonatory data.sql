-- EMPLOYEE TABLE

SELECT * FROM employee.employee
LIMIT 10;

SELECT 
	id,
	COUNT(id) AS ID_Count
FROM 
	employee.employee
GROUP BY id
LIMIT 10;

------------------------------------------------------------------

-- TITLE TABLE

SELECT 
  employee_id,
  COUNT(employee_id) AS ID_Count
FROM employee.title
GROUP BY employee_id
ORDER BY ID_Count DESC
LIMIT 5;

SELECT * FROM employee.title
WHERE employee_id = 17816
ORDER BY  from_date DESC;

SELECT * FROM employee.title
WHERE employee_id = 10035
ORDER BY  from_date DESC;

--------------------------------------------------------------

-- SALARY TABLE
SELECT 
  employee_id,
  COUNT(employee_id) AS ID_Count
FROM employee.salary
GROUP BY employee_id
ORDER BY ID_Count DESC
LIMIT 10;

SELECT * FROM employee.salary
WHERE employee_id = 12280
ORDER BY from_date DESC;

SELECT * FROM employee.salary
WHERE employee_id = 10035
ORDER BY from_date DESC;

----------------------------------------------------------------------

-- DEPARTMENT_EMPLOYEE TABLE

SELECT
  employee_id,
  COUNT(DISTINCT department_id) AS unique_departments
FROM employee.department_employee
GROUP BY employee_id
ORDER BY unique_departments DESC
LIMIT 5;

SELECT * FROM employee.department_employee
WHERE employee_id = 50029
ORDER BY from_date DESC;

SELECT * FROM employee.department_employee
WHERE employee_id = 10035
ORDER BY from_date DESC;

---------------------------------------------------------------------

-- DEPARTMENT_MANAGER TABLE

SELECT * FROM employee.department_manager
ORDER BY employee_id
LIMIT 10;

SELECT *FROM employee.department_manager
WHERE department_id = 'd004'
ORDER BY from_date DESC;

------------------------------------------------------------------------

-- DEPARTMENT TABLE
SELECT * FROM employee.department
ORDER BY id;


-------------------------------------------------

-- EXPLORE DATASET

---------------------------------------------------

-- table department_manager join with manager
-- to know the department of each manager

CREATE TABLE manager_join as
SELECT * FROM department_manager
CROSS JOIN department
ON department_manager.department_id = department.id;

SELECT * FROM employee.manager_join;

-- delete column id
ALTER TABLE employee.manager_join
DROP COLUMN id;

-- delete column department_id
ALTER TABLE employee.manager_join
DROP COLUMN department_id;

-- table manager_join
SELECT * FROM employee.manager_join;

--------------------------------------------------------------------

-- table employee join with table title
-- to know the title of each employees
CREATE TABLE employee_join AS
SELECT * FROM employee
CROSS JOIN title
ON employee.id = title.employee_id;

SELECT * FROM employee_join;

-- join again with department employee table
-- to know the department of each employees
CREATE TABLE employee_joinn AS
SELECT * FROM employee_join
CROSS JOIN department_employee
ON employee_join.id = department_employee.employee_id;

SELECT * FROM employee_joinn;

-- drop column
ALTER TABLE employee_joinn 
DROP COLUMN employee_id,
DROP COLUMN from_datee,
DROP COLUMN to_datee,
DROP COLUMN id;

-- join again with department table
-- to know the department of each employees
CREATE TABLE employee_joinnn AS
SELECT * FROM employee_joinn
CROSS JOIN department
ON employee_joinn.department_id = department.id;

SELECT * FROM employee_joinnn;

-- join again with salary table
-- to know salary of each employees
CREATE TABLE employee_join4 AS
SELECT * FROM employee_joinnn 
CROSS JOIN salary
ON employee_joinnn.employee_idd = salary.employee_id;

SELECT * FROM employee_join4;

-- drop column
ALTER TABLE employee_join4
DROP COLUMN employee_idd,
DROP COLUMN from_datee,
DROP COLUMN to_datee,
DROP COLUMN id;

------------------------------------------------------

SELECT * FROM employee.employee_join
WHERE employee_id = 10035
ORDER BY from_date DESC;

---------------------------------------------------------

-- to calculate tax

SELECT employee_id, first_name, title, amount, amount*.15 Tax 
FROM employee.employee_join;

SELECT employee_id, first_name, title, amount, amount*.05 Tax 
FROM employee.employee_join;

SELECT employee_id, first_name, title, amount, amount - amount*.05 Tax 
FROM employee.employee_join;

------------------------------------------------------------

-- to calculate bonus

SELECT 
  title,
  COUNT(title) AS EmployeeTotal
FROM employee.employee_join
GROUP BY title
ORDER BY EmployeeTotal;

SELECT employee_id, first_name, title, amount, amount*.05 Bonus 
FROM employee.employee_join;

------------------------------------------------------------------

-- to calculate employee age

SELECT * FROM employee.employee_join;

SELECT employee_id, first_name, title, birth_date, year(curdate())-year(birth_date) AS EmployeeAge 
FROM employee_join
GROUP BY employee_id;

----------------------------------------------------------------------------

-- to calculate total working

SELECT employee_id, first_name, title, hire_date, year(MAX(to_date))-year(hire_date) AS TotalWorking
FROM employee_join
GROUP BY employee_id;

-- view error data
SELECT * FROM employee.employee_join
WHERE to_date = '9999-01-01'
ORDER BY employee_id;

-- update error data
UPDATE employee_join
SET to_date = from_date + interval 9 year
WHERE to_date = '9999-01-01';

SELECT * FROM employee.employee_join;

-- final 
SELECT employee_id, first_name, title, hire_date, year(MAX(to_date))-year(hire_date) AS TotalWorking
FROM employee_join
GROUP BY employee_id;

--------------------------------------------------------------

-- add column age

CREATE TABLE employee_exp AS
SELECT * FROM employee_join;

ALTER TABLE employee_exp
ADD COLUMN age INT NOT NULL;

UPDATE employee_exp
SET age = year(curdate())-year(birth_date);

-----------------------------------------------------------------------

-- add column total working

ALTER TABLE employee_exp
ADD COLUMN TotalWorking INT NOT NULL;

SELECT employee_id, first_name, last_name, birth_date, gender, hire_date, title, department_id, dept_name, amount, from_date, to_date, age, year(MAX(to_date))-year(hire_date) AS TotalWorking
FROM employee_exp
GROUP BY employee_id;

UPDATE employee_exp
SET 
	TotalWorking = year(MAX(to_date))-year(hire_date);

SELECT * FROM employee_exp;

-------------------------------------------------------------------------

-- to calculate total working manager

SELECT * FROM employee.manager_join;

UPDATE manager_join
SET to_date = from_date + interval 9 year
WHERE to_date = '9999-01-01';

SELECT employee_id, dept_name, from_date, to_date, (year(to_date))-year(from_date) AS TotalWorking
FROM manager_join
GROUP BY employee_id;
