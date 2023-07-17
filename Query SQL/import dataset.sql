CREATE TABLE department_manager (
		employee_id BIGINT,
        department_id VARCHAR(6),
        from_date DATE,
        to_date DATE
	);

LOAD DATA INFILE 'D:/File SQL/people/department_manager.csv'
INTO TABLE department_manager
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

CREATE TABLE department_employee (
		employee_id BIGINT,
        department_id VARCHAR(6),
        from_date DATE,
        to_date DATE
	);

LOAD DATA INFILE 'D:/File SQL/people/department_employee.csv'
INTO TABLE department_employee
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

    
CREATE TABLE title (
		employee_id BIGINT,
        title VARCHAR(50),
        from_date DATE,
        to_date DATE
);

LOAD DATA INFILE 'D:/File SQL/people/title.csv'
INTO TABLE title
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


CREATE TABLE salary (
		employee_id BIGINT,
        amount BIGINT,
        from_date DATE,
        to_date DATE
);

LOAD DATA INFILE 'D:/File SQL/people/salary.csv'
INTO TABLE salary
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

CREATE TABLE employee (
		id BIGINT,
        birth_date DATE,
        first_name VARCHAR(14),
        last_lame VARCHAR(16),
        gender VARCHAR(2),
        hire_date DATE
);

LOAD DATA INFILE 'D:/File SQL/people/employee.csv'
INTO TABLE employee
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


SELECT COUNT(*) FROM employee.title;
SELECT COUNT(*) FROM employee.employee;
SELECT COUNT(*) FROM employee.department_employee;
SELECT COUNT(*) FROM employee.salary;
SELECT COUNT(*) FROM employee.employee_join;