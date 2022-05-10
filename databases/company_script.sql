-- the company database
-- the entities are employee table, branch table, client table, works with table, branch supplier table
CREATE DATABASE company;
-- we create the first table employee id but we do not indicate that super_id and branch id as foreign keys
-- because the table they reference do not exist yet. we can define those later
CREATE TABLE employee (
  emp_id INT PRIMARY KEY,
  first_name VARCHAR(40),
  last_name VARCHAR(40),
  birth_day DATE,
  sex VARCHAR(1),
  salary INT,
  super_id INT,
  branch_id INT
);

-- then we create the branch table next with foreign key manager id which is an employee id, and it references the employee table
 -- on delete set null is used to manage the foreign key

CREATE TABLE branch (
  branch_id INT PRIMARY KEY,
  branch_name VARCHAR(40),
  mgr_id INT,
  mgr_start_date DATE,
  FOREIGN KEY(mgr_id) REFERENCES employee(emp_id) ON DELETE SET NULL
  );



-- next we need to set the super_id and the branch id as foreign keys in the employee table and reference is to the employee table
-- and branch table as they have been already created, we use the alter table command to do this.

ALTER TABLE employee
ADD FOREIGN KEY(branch_id) REFERENCES branch(branch_id)
ON DELETE SET NULL;


ALTER TABLE employee
ADD FOREIGN KEY(super_id) REFERENCES employee(emp_id)
ON DELETE SET NULL;



-- next we create the client table with foreign key as branch_id and we can reference it as branch table already exists

CREATE TABLE client (
    client_id INT PRIMARY KEY,
    client_name VARCHAR(40),
    branch_id INT,
    FOREIGN KEY(branch_id)  REFERENCES branch(branch_id) ON DELETE SET NULL
);


-- next we create works_with table with a composite key made of emp_id and client_id both of which are foreign keys and we can easily reference
--as their tables exist ON DELETE CASCADE IS NEEDED IN THIS CASE MORE EXPLANATION WILL BE PROVIDED LATER;

CREATE TABLE works_with(
  emp_id INT ,
  client_id INT,
  total_sales INT,
  PRIMARY KEY(emp_id, client_id),
  FOREIGN KEY(emp_id) REFERENCES employee(emp_id) ON DELETE CASCADE,
  FOREIGN KEY(client_id) REFERENCES client(client_id) ON DELETE CASCADE
);


-- NEXT WE CREATE THE BRANCH SUPPLIER TABLE WITH FOREIGN KEY BRANCH_ID WHICH FORMS A COMPOSITE PRIMARY KEY WITH SUPPLIER_NAME;

CREATE TABLE branch_supplier(
  branch_id INT,
  supplier_name VARCHAR(40), 
  supply_type VARCHAR(40),
  PRIMARY KEY(branch_id, supplier_name),
  FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE CASCADE
);


-- next we insert data into the tables;
-- insert data using the branch criteria i.e using each branch insert employee information who work on that branch
-- corporate branch


-- first insert the employee 100 information but set the branch id to nul because branch id does not exist yet
INSERT INTO employee VALUES(100, 'David', 'Wallace', '1967-11-17', 'M', 250000, NULL, NULL);

-- then create the branch corporate 
INSERT INTO branch VALUES(1, 'Corporate', 100, '2006-02-09');

-- then update branch_id of employee 100 to 1
UPDATE employee
SET branch_id = 1
WHERE emp_id = 100;


-- then insert the other employees who belong to the same branch
INSERT INTO employee VALUES(101, 'Jan', 'Levinson', '1961-05-11', 'F', 110000, 100, 1);


-- then we go to the next branch scranton 
-- Scranton
INSERT INTO employee VALUES(102, 'Michael', 'Scott', '1964-03-15', 'M', 75000, 100, NULL);

INSERT INTO branch VALUES(2, 'Scranton', 102, '1992-04-06');

UPDATE employee
SET branch_id = 2
WHERE emp_id = 102;

INSERT INTO employee VALUES(103, 'Angela', 'Martin', '1971-06-25', 'F', 63000, 102, 2);
INSERT INTO employee VALUES(104, 'Kelly', 'Kapoor', '1980-02-05', 'F', 55000, 102, 2);
INSERT INTO employee VALUES(105, 'Stanley', 'Hudson', '1958-02-19', 'M', 69000, 102, 2);



-- next we insert  into the next branch of the tables;
-- Stamford
INSERT INTO employee VALUES(106, 'Josh', 'Porter', '1969-09-05', 'M', 78000, 100, NULL);

INSERT INTO branch VALUES(3, 'Stamford', 106, '1998-02-13');

UPDATE employee
SET branch_id = 3
WHERE emp_id = 106;

INSERT INTO employee VALUES(107, 'Andy', 'Bernard', '1973-07-22', 'M', 65000, 106, 3);
INSERT INTO employee VALUES(108, 'Jim', 'Halpert', '1978-10-01', 'M', 71000, 106, 3);


-- next we can insert the branch supplier 
INSERT INTO branch_supplier VALUES(2, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Patriot Paper', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'J.T. Forms & Labels', 'Custom Forms');
INSERT INTO branch_supplier VALUES(3, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(3, 'Stamford Lables', 'Custom Forms');


-- next we insert into the client table
-- CLIENT
INSERT INTO client VALUES(400, 'Dunmore Highschool', 2);
INSERT INTO client VALUES(401, 'Lackawana Country', 2);
INSERT INTO client VALUES(402, 'FedEx', 3);
INSERT INTO client VALUES(403, 'John Daly Law, LLC', 3);
INSERT INTO client VALUES(404, 'Scranton Whitepages', 2);
INSERT INTO client VALUES(405, 'Times Newspaper', 3);
INSERT INTO client VALUES(406, 'FedEx', 2);


--- lastly we insert data into the workswith table
INSERT INTO works_with VALUES(105, 400, 55000);
INSERT INTO works_with VALUES(102, 401, 267000);
INSERT INTO works_with VALUES(108, 402, 22500);
INSERT INTO works_with VALUES(107, 403, 5000);
INSERT INTO works_with VALUES(108, 403, 12000);
INSERT INTO works_with VALUES(105, 404, 33000);
INSERT INTO works_with VALUES(107, 405, 26000);
INSERT INTO works_with VALUES(102, 406, 15000);
INSERT INTO works_with VALUES(105, 406, 130000);


--- result when we populate the data
-- find all employees
mysql> select * from employee;
+--------+------------+-----------+------------+------+--------+----------+-----------+
| emp_id | first_name | last_name | birth_day  | sex  | salary | super_id | branch_id |
+--------+------------+-----------+------------+------+--------+----------+-----------+
|    100 | David      | Wallace   | 1967-11-17 | M    | 250000 |     NULL |         1 |
|    101 | Jan        | Levinson  | 1961-05-11 | F    | 110000 |      100 |         1 |
|    102 | Michael    | Scott     | 1964-03-15 | M    |  75000 |      100 |         2 |
|    103 | Angela     | Martin    | 1971-06-25 | F    |  63000 |      102 |         2 |
|    104 | Kelly      | Kapoor    | 1980-02-05 | F    |  55000 |      102 |         2 |
|    105 | Stanley    | Hudson    | 1958-02-19 | M    |  69000 |      102 |         2 |
|    106 | Josh       | Porter    | 1969-09-05 | M    |  78000 |      100 |         3 |
|    107 | Andy       | Bernard   | 1973-07-22 | M    |  65000 |      106 |         3 |
|    108 | Jim        | Halpert   | 1978-10-01 | M    |  71000 |      106 |         3 |
+--------+------------+-----------+------------+------+--------+----------+-----------+
9 rows in set (0.00 sec)

mysql> select * from branch;
+-----------+-------------+--------+----------------+
| branch_id | branch_name | mgr_id | mgr_start_date |
+-----------+-------------+--------+----------------+
|         1 | Corporate   |    100 | 2006-02-09     |
|         2 | Scranton    |    102 | 1992-04-06     |
|         3 | Stamford    |    106 | 1998-02-13     |
+-----------+-------------+--------+----------------+
3 rows in set (0.01 sec)

-- find all clients
mysql> select * from client;
+-----------+---------------------+-----------+
| client_id | client_name         | branch_id |
+-----------+---------------------+-----------+
|       400 | Dunmore Highschool  |         2 |
|       401 | Lackawana Country   |         2 |
|       402 | FedEx               |         3 |
|       403 | John Daly Law, LLC  |         3 |
|       404 | Scranton Whitepages |         2 |
|       405 | Times Newspaper     |         3 |
|       406 | FedEx               |         2 |
+-----------+---------------------+-----------+
7 rows in set (0.00 sec)

mysql> select * from branch_supplier;
+-----------+---------------------+------------------+
| branch_id | supplier_name       | supply_type      |
+-----------+---------------------+------------------+
|         2 | Hammer Mill         | Paper            |
|         2 | J.T. Forms & Labels | Custom Forms     |
|         2 | Uni-ball            | Writing Utensils |
|         3 | Hammer Mill         | Paper            |
|         3 | Patriot Paper       | Paper            |
|         3 | Stamford Lables     | Custom Forms     |
|         3 | Uni-ball            | Writing Utensils |
+-----------+---------------------+------------------+
7 rows in set (0.01 sec)

mysql> select * from works_with;
+--------+-----------+-------------+
| emp_id | client_id | total_sales |
+--------+-----------+-------------+
|    102 |       401 |      267000 |
|    102 |       406 |       15000 |
|    105 |       400 |       55000 |
|    105 |       404 |       33000 |
|    105 |       406 |      130000 |
|    107 |       403 |        5000 |
|    107 |       405 |       26000 |
|    108 |       402 |       22500 |
|    108 |       403 |       12000 |
+--------+-----------+-------------+
9 rows in set (0.00 sec)


--- next is a series of querries
--1) find all employees who work for this company with just their names
SELECT CONCAT(first_name, " ", last_name) AS employee_name
from employee;
+----------------+
| employee_name  |
+----------------+
| David Wallace  |
| Jan Levinson   |
| Michael Scott  |
| Angela Martin  |
| Kelly Kapoor   |
| Stanley Hudson |
| Josh Porter    |
| Andy Bernard   |
| Jim Halpert    |
+----------------+
9 rows in set (0.01 sec)


--2) find all employees ordered by salary
select * 
from employee
order by salary;
+--------+------------+-----------+------------+------+--------+----------+-----------+
| emp_id | first_name | last_name | birth_day  | sex  | salary | super_id | branch_id |
+--------+------------+-----------+------------+------+--------+----------+-----------+
|    104 | Kelly      | Kapoor    | 1980-02-05 | F    |  55000 |      102 |         2 |
|    103 | Angela     | Martin    | 1971-06-25 | F    |  63000 |      102 |         2 |
|    107 | Andy       | Bernard   | 1973-07-22 | M    |  65000 |      106 |         3 |
|    105 | Stanley    | Hudson    | 1958-02-19 | M    |  69000 |      102 |         2 |
|    108 | Jim        | Halpert   | 1978-10-01 | M    |  71000 |      106 |         3 |
|    102 | Michael    | Scott     | 1964-03-15 | M    |  75000 |      100 |         2 |
|    106 | Josh       | Porter    | 1969-09-05 | M    |  78000 |      100 |         3 |
|    101 | Jan        | Levinson  | 1961-05-11 | F    | 110000 |      100 |         1 |
|    100 | David      | Wallace   | 1967-11-17 | M    | 250000 |     NULL |         1 |
+--------+------------+-----------+------------+------+--------+----------+-----------+
9 rows in set (0.00 sec)


--3) find all employees ordered by salary with the richest employee at the top of the table
select * 
from employee
order by salary DESC;

+--------+------------+-----------+------------+------+--------+----------+-----------+
| emp_id | first_name | last_name | birth_day  | sex  | salary | super_id | branch_id |
+--------+------------+-----------+------------+------+--------+----------+-----------+
|    100 | David      | Wallace   | 1967-11-17 | M    | 250000 |     NULL |         1 |
|    101 | Jan        | Levinson  | 1961-05-11 | F    | 110000 |      100 |         1 |
|    106 | Josh       | Porter    | 1969-09-05 | M    |  78000 |      100 |         3 |
|    102 | Michael    | Scott     | 1964-03-15 | M    |  75000 |      100 |         2 |
|    108 | Jim        | Halpert   | 1978-10-01 | M    |  71000 |      106 |         3 |
|    105 | Stanley    | Hudson    | 1958-02-19 | M    |  69000 |      102 |         2 |
|    107 | Andy       | Bernard   | 1973-07-22 | M    |  65000 |      106 |         3 |
|    103 | Angela     | Martin    | 1971-06-25 | F    |  63000 |      102 |         2 |
|    104 | Kelly      | Kapoor    | 1980-02-05 | F    |  55000 |      102 |         2 |
+--------+------------+-----------+------------+------+--------+----------+-----------+
9 rows in set (0.00 sec)

--4) find all employees ordered by sex then name
select * 
from employee
order by sex, first_name, last_name;
+--------+------------+-----------+------------+------+--------+----------+-----------+
| emp_id | first_name | last_name | birth_day  | sex  | salary | super_id | branch_id |
+--------+------------+-----------+------------+------+--------+----------+-----------+
|    103 | Angela     | Martin    | 1971-06-25 | F    |  63000 |      102 |         2 |
|    101 | Jan        | Levinson  | 1961-05-11 | F    | 110000 |      100 |         1 |
|    104 | Kelly      | Kapoor    | 1980-02-05 | F    |  55000 |      102 |         2 |
|    107 | Andy       | Bernard   | 1973-07-22 | M    |  65000 |      106 |         3 |
|    100 | David      | Wallace   | 1967-11-17 | M    | 250000 |     NULL |         1 |
|    108 | Jim        | Halpert   | 1978-10-01 | M    |  71000 |      106 |         3 |
|    106 | Josh       | Porter    | 1969-09-05 | M    |  78000 |      100 |         3 |
|    102 | Michael    | Scott     | 1964-03-15 | M    |  75000 |      100 |         2 |
|    105 | Stanley    | Hudson    | 1958-02-19 | M    |  69000 |      102 |         2 |
+--------+------------+-----------+------------+------+--------+----------+-----------+
9 rows in set (0.00 sec)

--4) find the first 5 employees in the table
select *
from employee
limit 5;
+--------+------------+-----------+------------+------+--------+----------+-----------+
| emp_id | first_name | last_name | birth_day  | sex  | salary | super_id | branch_id |
+--------+------------+-----------+------------+------+--------+----------+-----------+
|    100 | David      | Wallace   | 1967-11-17 | M    | 250000 |     NULL |         1 |
|    101 | Jan        | Levinson  | 1961-05-11 | F    | 110000 |      100 |         1 |
|    102 | Michael    | Scott     | 1964-03-15 | M    |  75000 |      100 |         2 |
|    103 | Angela     | Martin    | 1971-06-25 | F    |  63000 |      102 |         2 |
|    104 | Kelly      | Kapoor    | 1980-02-05 | F    |  55000 |      102 |         2 |
+--------+------------+-----------+------------+------+--------+----------+-----------+
5 rows in set (0.00 sec)


--5) find the first and last name of all employees
select first_name, last_name
from employee;

--6) find the forename and surname of all employees( the quotes are optional)( as key  word is used when you to give columns another name)
select first_name as "forename", last_name as "surname"
from employee;

+----------+----------+
| forename | surname  |
+----------+----------+
| David    | Wallace  |
| Jan      | Levinson |
| Michael  | Scott    |
| Angela   | Martin   |
| Kelly    | Kapoor   |
| Stanley  | Hudson   |
| Josh     | Porter   |
| Andy     | Bernard  |
| Jim      | Halpert  |
+----------+----------+
9 rows in set (0.01 sec)

--7) find out all the different genders( we will use the distict keyword)
select distinct sex
from employee;
+------+
| sex  |
+------+
| M    |
| F    |
+------+
2 rows in set (0.01 sec)

--8) select the different branch ids in the company
select distinct branch_id
from employee;
+-----------+
| branch_id |
+-----------+
|         1 |
|         2 |
|         3 |
+-----------+
3 rows in set (0.01 sec)

--- functions (more querries)
-- aggregate functions used to get data from the database 


--1) find the number of employees in the company
select count(*)
from employee;
+----------+
| count(*) |
+----------+
|        9 |
+----------+
1 row in set (0.01 sec)

-- or specify which column to count
select count(emp_id)
from employee;
+---------------+
| count(emp_id) |
+---------------+
|             9 |
+---------------+
1 row in set (0.00 sec)

-- or count the distict attributes in a column using distict keyword inside the count clause
select count(distinct branch_id)
from employee;
+---------------------------+
| count(distinct branch_id) |
+---------------------------+
|                         3 |
+---------------------------+
1 row in set (0.00 sec) 



---note (aggregate function count counts the number of rows that have actual values in them, for example if the field of an entry
-- is null, it does not get counted).

--find the number of female employees born after 1970(female and born after 1970)
select count(emp_id)
from employee
where sex = "F" and birth_day > '1970-01-01';
+---------------+
| count(emp_id) |
+---------------+
|             2 |
+---------------+
1 row in set (0.00 sec)

--2)find the average of all employee salaries
select avg(salary)
from employee;
+-------------+
| avg(salary) |
+-------------+
|  92888.8889 |
+-------------+
1 row in set (0.00 sec)

-- average salary of all the employees who are males

-- 3) find the sum of all employee's salaries(or how much the company spends on payroll)
select sum(salary)
from employee;
+-------------+
| sum(salary) |
+-------------+
|      836000 |
+-------------+
1 row in set (0.00 sec)

---- next is aggregation ( this is where aggregate functions are used to display information in a more desirable way) (group by keyword)
--4) find out how many males and how many females there are

select count(sex), sex
from employee
group by sex;
+------------+------+
| count(sex) | sex  |
+------------+------+
|          6 | M    |
|          3 | F    |
+------------+------+
2 rows in set (0.00 sec)

-- find the total sales of each employee
select SUM(total_sales), emp_id
from works_with
group by emp_id;
+------------------+--------+
| SUM(total_sales) | emp_id |
+------------------+--------+
|           282000 |    102 |
|           218000 |    105 |
|            31000 |    107 |
|            34500 |    108 |
+------------------+--------+
4 rows in set (0.00 sec)


-- find how much each client spent on the branch
select sum(total_sales), client_id
from works_with
group by client_id;

+------------------+-----------+
| sum(total_sales) | client_id |
+------------------+-----------+
|            55000 |       400 |
|           267000 |       401 |
|            22500 |       402 |
|            17000 |       403 |
|            33000 |       404 |
|            26000 |       405 |
|           145000 |       406 |
+------------------+-----------+
7 rows in set (0.00 sec)


-- we can use aggregation to group the result of the functions 


--- next is wildcards and the like keyword is sql 
-- wildcards are a way of getting data that matches a specific pattern( %= any number of characters, _= one character
-- these are wildcards and they are placed in parenthesis after the like keyword which comes after the selected column)

--1)find any clients who are an LLC(company with an LLC ending is an LLC company) -- "%LLC" MEANS ANY NUMBER OF CHARACTERS WITH LLC IN THE END
select * 
from client 
where client_name like "%LLC";
+-----------+--------------------+-----------+
| client_id | client_name        | branch_id |
+-----------+--------------------+-----------+
|       403 | John Daly Law, LLC |         3 |
+-----------+--------------------+-----------+
1 row in set (0.00 sec)


-- Find any branch suppliers who are in the label business (%% two will be used to indicate any characters before label and any after)
select * 
from branch_supplier
where supplier_name like "%label%";
+-----------+---------------------+--------------+
| branch_id | supplier_name       | supply_type  |
+-----------+---------------------+--------------+
|         2 | J.T. Forms & Labels | Custom Forms |
+-----------+---------------------+--------------+
1 row in set (0.00 sec)

--find any employee born in october
select * 
from employee
where birth_day like "%10%";

+--------+------------+-----------+------------+------+--------+----------+-----------+
| emp_id | first_name | last_name | birth_day  | sex  | salary | super_id | branch_id |
+--------+------------+-----------+------------+------+--------+----------+-----------+
|    108 | Jim        | Halpert   | 1978-10-01 | M    |  71000 |      106 |         3 |
+--------+------------+-----------+------------+------+--------+----------+-----------+
1 row in set (0.00 sec)


--or use the one character wildcard( this can be done for months and years)
select *
from employee
where birth_day like "____-10%";

+--------+------------+-----------+------------+------+--------+----------+-----------+
| emp_id | first_name | last_name | birth_day  | sex  | salary | super_id | branch_id |
+--------+------------+-----------+------------+------+--------+----------+-----------+
|    108 | Jim        | Halpert   | 1978-10-01 | M    |  71000 |      106 |         3 |
+--------+------------+-----------+------------+------+--------+----------+-----------+
1 row in set (0.00 sec)


--find any clients who are schools
select *
from client 
where client_name like '%school%';

+-----------+--------------------+-----------+
| client_id | client_name        | branch_id |
+-----------+--------------------+-----------+
|       400 | Dunmore Highschool |         2 |
+-----------+--------------------+-----------+
1 row in set (0.00 sec)


--- unions in sql (used to combine the result of a number different select statement(join columns) into one table )
--1) find a list of employees and branch names(use employee's first_name)

--first select the employees
select first_name
from employee;


--then the branch_name
select branch_name
from branch;

-- then use union to put them together
select first_name
from employee
union
select branch_name
from branch;
+------------+
| first_name |
+------------+
| David      |
| Jan        |
| Michael    |
| Angela     |
| Kelly      |
| Stanley    |
| Josh       |
| Andy       |
| Jim        |
| Corporate  |
| Scranton   |
| Stamford   |
+------------+
12 rows in set (0.00 sec)

--- rules for using union
--1> same number of columns should be slected
--2> the columns selected should have the same data type
 select emp_id, first_name
 from employee
 union
 select branch_id, branch_name
 from branch ;
+--------+------------+
| emp_id | first_name |
+--------+------------+
|    100 | David      |
|    101 | Jan        |
|    102 | Michael    |
|    103 | Angela     |
|    104 | Kelly      |
|    105 | Stanley    |
|    106 | Josh       |
|    107 | Andy       |
|    108 | Jim        |
|      1 | Corporate  |
|      2 | Scranton   |
|      3 | Stamford   |
+--------+------------+
12 rows in set (0.00 sec)

-- for the union of more select statements
select first_name
from employee
union
select branch_name
from branch
union 
select client_name 
from client;
+---------------------+
| first_name          |
+---------------------+
| David               |
| Jan                 |
| Michael             |
| Angela              |
| Kelly               |
| Stanley             |
| Josh                |
| Andy                |
| Jim                 |
| Corporate           |
| Scranton            |
| Stamford            |
| Dunmore Highschool  |
| Lackawana Country   |
| FedEx               |
| John Daly Law, LLC  |
| Scranton Whitepages |
| Times Newspaper     |
+---------------------+

-- we can change the column name of the result of the union using as keyword
select first_name as employees_branch_client_names
from employee
union
select branch_name
from branch
union 
select client_name 
from client;

+-------------------------------+
| employees_branch_client_names |
+-------------------------------+
| David                         |
| Jan                           |
| Michael                       |
| Angela                        |
| Kelly                         |
| Stanley                       |
| Josh                          |
| Andy                          |
| Jim                           |
| Corporate                     |
| Scranton                      |
| Stamford                      |
| Dunmore Highschool            |
| Lackawana Country             |
| FedEx                         |
| John Daly Law, LLC            |
| Scranton Whitepages           |
| Times Newspaper               |
+-------------------------------+
18 rows in set (0.00 sec)

-- find a list of all clients & branch_supplier's names
select client_name as clients_and_branch_supplier_names
from client
union 
select supplier_name
from branch_supplier;
+-----------------------------------+
| clients_and_branch_supplier_names |
+-----------------------------------+
| Dunmore Highschool                |
| Lackawana Country                 |
| FedEx                             |
| John Daly Law, LLC                |
| Scranton Whitepages               |
| Times Newspaper                   |
| Hammer Mill                       |
| J.T. Forms & Labels               |
| Uni-ball                          |
| Patriot Paper                     |
| Stamford Lables                   |
+-----------------------------------+

-- or the same results but with the branch id they are associated with since both have branch_id in them
select client_name as clients_and_branch_supplier_names, client.branch_id
from client
union 
select supplier_name, client.branch_id
from branch_supplier;
+-----------------------------------+-----------+
| clients_and_branch_supplier_names | branch_id |
+-----------------------------------+-----------+
| Dunmore Highschool                |         2 |
| Lackawana Country                 |         2 |
| FedEx                             |         3 |
| John Daly Law, LLC                |         3 |
| Scranton Whitepages               |         2 |
| Times Newspaper                   |         3 |
| FedEx                             |         2 |
| Hammer Mill                       |         2 |
| J.T. Forms & Labels               |         2 |
| Uni-ball                          |         2 |
| Hammer Mill                       |         3 |
| Patriot Paper                     |         3 |
| Stamford Lables                   |         3 |
| Uni-ball                          |         3 |
+-----------------------------------+-----------+
14 rows in set (0.00 sec)

-- find a list of sum of all money spent or earned by the company
select sum(salary) as money_spent_and_earned
from employee
union 
select sum(total_sales)
from works_with;

+------------------------+
| money_spent_and_earned |
+------------------------+
|                 836000 |
|                 565500 |
+------------------------+
2 rows in set (0.00 sec)

-- for just a list of all money spent or earned 
select salary as money_spent_and_earned
from employee
union 
select total_sales
from works_with;

+------------------------+
| money_spent_and_earned |
+------------------------+
|                 250000 |
|                 110000 |
|                  75000 |
|                  63000 |
|                  55000 |
|                  69000 |
|                  78000 |
|                  65000 |
|                  71000 |
|                 267000 |
|                  15000 |
|                  33000 |
|                 130000 |
|                   5000 |
|                  26000 |
|                  22500 |
|                  12000 |
+------------------------+
17 rows in set (0.00 sec)


-- joins in sql(join rows from two different tables based on a common column between them(or columns between them))
INSERT INTO branch VALUES(4, "Buffalo", NULL, NULL); -- adding a branch without a manager id and manager start date
+-----------+-------------+--------+----------------+
| branch_id | branch_name | mgr_id | mgr_start_date |
+-----------+-------------+--------+----------------+
|         1 | Corporate   |    100 | 2006-02-09     |
|         2 | Scranton    |    102 | 1992-04-06     |
|         3 | Stamford    |    106 | 1998-02-13     |
|         4 | Buffalo     |   NULL | NULL           |
+-----------+-------------+--------+----------------+
4 rows in set (0.01 sec)

--- now join querry 
--1) find all branches and the name of their managers( we join the tables on specific column then select the specific columns)
select employee.emp_id, employee.first_name, branch.branch_name
from employee
join branch     --(or inner join)
on employee.emp_id = branch.mgr_id;

+--------+------------+-------------+
| emp_id | first_name | branch_name |
+--------+------------+-------------+
|    100 | David      | Corporate   |
|    102 | Michael    | Scranton    |
|    106 | Josh       | Stamford    |
+--------+------------+-------------+
3 rows in set (0.00 sec)

--- four types of joins
-- 1> the general join (example shown above) also called inner join - joins rows based on a shared column
-- 2> left join  (it is the rows from the inner join and all other rows from the left table which is the first table selected)
select employee.emp_id, employee.first_name, branch.branch_name
from employee
left join branch   --or(left outer join)
on employee.emp_id = branch.mgr_id;

+--------+------------+-------------+
| emp_id | first_name | branch_name |
+--------+------------+-------------+
|    100 | David      | Corporate   |
|    101 | Jan        | NULL        |
|    102 | Michael    | Scranton    |
|    103 | Angela     | NULL        |
|    104 | Kelly      | NULL        |
|    105 | Stanley    | NULL        |
|    106 | Josh       | Stamford    |
|    107 | Andy       | NULL        |
|    108 | Jim        | NULL        |
+--------+------------+-------------+
9 rows in set (0.00 sec) 
-- so left join is all the matched rows(inner join) and the unmatched in the left table


--3> right join -- opposite of the left join (it is the rows from the inner join and all the other rows from the right table which is the second table mentioned)
select employee.emp_id, employee.first_name, branch.branch_name
from employee
right join branch   -- or(right ouert join)
on employee.emp_id = branch.mgr_id;
+--------+------------+-------------+
| emp_id | first_name | branch_name |
+--------+------------+-------------+
|    100 | David      | Corporate   |
|    102 | Michael    | Scranton    |
|    106 | Josh       | Stamford    |
|   NULL | NULL       | Buffalo     |
+--------+------------+-------------+
4 rows in set (0.00 sec)

-- so right join  is all the matched rows(inner join) and the unmatched in the right table

-- for the columns that do not exist, a null values fills in

--4> full outer join - so outer join is the union of left and right join(basically the matched(inner join ) and the rest of the rows in each of tables)
-- cant be done in mysql but it is a union of right outer and left outer join


-- nested querries
-- they are used to results of one select statement in another select statement

--1)find the names of all employees who have sold over 30,000 to a single client

--first find all of the employee ids who sold over 30000 to a single client
select works_with.emp_id
from works_with
where works_with total_sales > 30000;

+--------+
| emp_id |
+--------+
|    102 |
|    105 |
|    105 |
|    105 |
+--------+
4 rows in set (0.00 sec)

-- then use the result(ids) to identify the names of the employees
select concat(employee.first_name, ", ", employee.last_name) as employee_name
from employee
where employee.emp_id in (
      select works_with.emp_id
      from works_with
      where works_with.total_sales > 30000
) ;

+-----------------+
| employee_name   |
+-----------------+
| Michael, Scott  |
| Stanley, Hudson |
+-----------------+
2 rows in set (0.01 sec)


--2) find all clients who are handled by the branch that michael scott manages assume you know Michael's ID
--first find which the branch id Michael manages(michael's id= 102)
select branch.branch_id
from branch 
where branch.mgr_id = 102;

+-----------+
| branch_id |
+-----------+
|         2 |
+-----------+
1 row in set (0.00 sec)

-- then find client name using the results above since branch_id is a foreign key in client table by saying branch id = result of the inner select
select client.client_name 
from client
where client.branch_id = (
      select branch.branch_id
      from branch 
      where branch.mgr_id = 102
      limit 1
);
+---------------------+
| client_name         |
+---------------------+
| Dunmore Highschool  |
| Lackawana Country   |
| Scranton Whitepages |
| FedEx               |
+---------------------+
4 rows in set (0.01 sec)

-- whenever an equality is used the statement can only execute for one value from the inner select statement so using limit we ensure just one of the values is used.
-- for multiple outputs from the nested statement use the clause in


--- on delete ( this involves deleting entries where foreign keys are invloved)
-- the two types are on delete set null and on delete cascade


-- for on delete set null  -- it means set to null when the foreign key gets deleted
--) lets delete michael scott
delete from employee
where emp_id = 102;

+--------+------------+-----------+------------+------+--------+----------+-----------+
| emp_id | first_name | last_name | birth_day  | sex  | salary | super_id | branch_id |
+--------+------------+-----------+------------+------+--------+----------+-----------+
|    100 | David      | Wallace   | 1967-11-17 | M    | 250000 |     NULL |         1 |
|    101 | Jan        | Levinson  | 1961-05-11 | F    | 110000 |      100 |         1 |
|    103 | Angela     | Martin    | 1971-06-25 | F    |  63000 |     NULL |         2 |
|    104 | Kelly      | Kapoor    | 1980-02-05 | F    |  55000 |     NULL |         2 |
|    105 | Stanley    | Hudson    | 1958-02-19 | M    |  69000 |     NULL |         2 |
|    106 | Josh       | Porter    | 1969-09-05 | M    |  78000 |      100 |         3 |
|    107 | Andy       | Bernard   | 1973-07-22 | M    |  65000 |      106 |         3 |
|    108 | Jim        | Halpert   | 1978-10-01 | M    |  71000 |      106 |         3 |
+--------+------------+-----------+------------+------+--------+----------+-----------+
8 rows in set (0.00 sec)


+-----------+-------------+--------+----------------+
| branch_id | branch_name | mgr_id | mgr_start_date |
+-----------+-------------+--------+----------------+
|         1 | Corporate   |    100 | 2006-02-09     |
|         2 | Scranton    |   NULL | 1992-04-06     |
|         3 | Stamford    |    106 | 1998-02-13     |
|         4 | Buffalo     |   NULL | NULL           |
+-----------+-------------+--------+----------------+


-- in real life we cant just imagine that this employee got fired so we can just hire another employee who will be the new manager and supervisor, thus
--replacing the null values to the actual id.

-- on delete cascade(if foreign key gets deleted then we delete the entire row with that id in the table)
delete from branch
where branch_id = 2;
+-----------+-------------+--------+----------------+
| branch_id | branch_name | mgr_id | mgr_start_date |
+-----------+-------------+--------+----------------+
|         1 | Corporate   |    100 | 2006-02-09     |
|         3 | Stamford    |    106 | 1998-02-13     |
|         4 | Buffalo     |   NULL | NULL           |
+-----------+-------------+--------+----------------+
3 rows in set (0.01 sec)

+-----------+-----------------+------------------+
| branch_id | supplier_name   | supply_type      |
+-----------+-----------------+------------------+
|         3 | Hammer Mill     | Paper            |
|         3 | Patriot Paper   | Paper            |
|         3 | Stamford Lables | Custom Forms     |
|         3 | Uni-ball        | Writing Utensils |
+-----------+-----------------+------------------+

-- on cascade deletes all the rows from the table that is using the branch id as a foreign key and the table that is using it as a primary key
-- in real life it is like getting rid of a branch, means the suppliers no longer exist


-- in other words if the foreign key getting deleted is a primary key in another table the whole row gets removed because we cant have values with no primary keys
-- hence the use of on delete cascade when creating the table



----using triggers in mysql )triggers are executed from the terminal because they cannot be delimetter change cannot be supposed by mysql editors
-- a trigger is a block of code which will define an action that should happen when a certain operation occurs on the database
-- like a when a row gets deleted insert this onto this
-- they can be created before or after 
-- delimetters are used to show the ending (;) to change delimetter we use the command(delimetter && or ; or any other character)


-- CREATE
--     TRIGGER `event_name` BEFORE/AFTER INSERT/UPDATE/DELETE
--     ON `database`.`table`
--     FOR EACH ROW BEGIN
-- 		-- trigger body
-- 		-- this code is applied to every
-- 		-- inserted/updated/deleted row
--     END;

CREATE TABLE trigger_test (
     message VARCHAR(100)
);



---example one 
DELIMITER $$
CREATE
    TRIGGER my_trigger BEFORE INSERT
    ON employee
    FOR EACH ROW BEGIN
        INSERT INTO trigger_test VALUES('added new employee');
    END$$
DELIMITER ;
INSERT INTO employee
VALUES(109, 'Oscar', 'Martinez', '1968-02-19', 'M', 69000, 106, 3);
DELIMITER $$



---another trigger 
CREATE
    TRIGGER my_trigger BEFORE INSERT
    ON employee
    FOR EACH ROW BEGIN
        INSERT INTO trigger_test VALUES(NEW.first_name);
    END$$
DELIMITER ;

INSERT INTO employee
VALUES(110, 'Kevin', 'Malone', '1978-02-19', 'M', 69000, 106, 3);


-- another trigger
DELIMITER $$
CREATE
    TRIGGER my_trigger BEFORE INSERT
    ON employee
    FOR EACH ROW BEGIN
         IF NEW.sex = 'M' THEN
               INSERT INTO trigger_test VALUES('added male employee');
         ELSEIF NEW.sex = 'F' THEN
               INSERT INTO trigger_test VALUES('added female');
         ELSE
               INSERT INTO trigger_test VALUES('added other employee');
         END IF;
    END$$
DELIMITER ;


INSERT INTO employee
VALUES(111, 'Pam', 'Beesly', '1988-02-19', 'F', 69000, 106, 3);

--to delete trigger
DROP TRIGGER my_trigger;


--entity relationship diagrams
-- enitity - any object we want to model and store informatio about -- usually a red rectangle 
-- attributes - specific pieces of information about an entity -- usually a green oval
--primary key - an attribute that uniquely identify an entry in a database -- usually underlined 
-- composite attribute - an attribute that can be broken into a sub attributes 
-- multivalues attribute - an attribute that can have more than one value -- reperesented by two circles
--derived attribue - an atribute that can be derived from other attributes -- represented by dotted oval 
-- relationships - define relationships between entities - represented by a gray diamond
-- relationship cardinality - the number of instances of an entity from a relation that can be associated with that relation( one to one,
---one to many, many to many)   like a student can take many courses
-- weak entity types - an entity that depends on another entity (reperesented by double lined rectangle)
-- the relationship between a strong entity and a weak entity is represented by a double lined grey diamnond
-- a weak entity cannot exist on its own 
-- the primary key of the weak entity is called partial key or a ddiscriminator
-- a weak entity cannot be uniquely identified by its attributes online


--- (example building and designing an ER_diagram based on the information given below
-->Company Data Storage Requirements
--The company is organized into branches. Each branch has a unique number, a name, and a particular employee who manages it.

-->The company makes it’s money by selling to clients. Each client has a name and a unique number to identify it.

-->The foundation of the company is it’s employees. Each employee has a name, birthday, sex, salary and a unique number.

-->An employee can work for one branch at a time, and each branch will be managed by one of the employees that work there.
-- We’ll also want to keep track of when the current manager started as manager.

-->An employee can act as a supervisor for other employees at the branch,
-- an employee may also act as the supervisor for employees at other branches. An employee can have at most one supervisor.

-->A branch may handle a number of clients, with each client having a name and a unique number to identify it. 
--A single client may only be handled by one branch at a time.

-->Employees can work with clients controlled by their branch to sell them stuff.
--If nescessary multiple employees can work with the same client. We’ll want to keep track
-- of how many dollars worth of stuff each employee sells to each client they work with.

-->Many branches will need to work with suppliers to buy inventory.
--For each supplier we’ll keep track of their name and the type of product they’re selling the branch.
-- A single supplier may supply products to multiple branches.)


entities
-branch(attributes: unique number, name, manager_employee, manager_start_date)
-client(attributes: client_name, unique number)                         
-employees(attributes: name, birthday, sex, salary, a unique number)    
-works with( attributes: total sales , client , employee)
-suppliers(attributes: branch_name they supply to, suppllier name, product_name) --- weak entity 

relationships
- - one employee -> one branch
- manager should work in the branch they manage
- an employee supervices - one employee or more 
- an employee can supervice in their branch or others
- branch can handle clients 
- one client -> one branch
employeer -> can sell to more than one client 
- or multiple employees can work with one client
- supplier can sell to many branches  


--- 2nd step of the design process is to convert the er_diagram to database schema
1) mapping of regular entity types into relations 
2) mapping each of the weak entities  -- the primary key is going to be the partial key of the weak entity plus the primary key of its owner(composite primary key)
3)binary relationship - two entities participating 
-- 1>one to one relationships (include one side of the relationship as a foreign key in the other, favor total participation example use
-- add foreign key to the side with total participation ex: emp_id as a foreign key in branch table(mgr_id))


-- 2> one to many relationships(1:M include the 1 side's primary key as a foreign key on the M side relation(table))
--example: add branch_id(I side) as a foreign key to the employee table(M side)
---OR branch_id as a foreign key in the client table


-- 3>many to many relationships(M:M)   ---in this case create a new relation whose primary key is a combination of both
--primary keys. also include any relationship attributes
-- example the table works with uses the client id from client table and emp_id from employee table and forms a primary key this
--key is called a compound key(made up of two foreign keys).


