
"""
2019.10.14 - 2019-11.26
zhangheng 
"""

"""
mysql -uroot -p
show databases
use bank
"""


"""
第二章 创建和使用数据库
"""

CREATE TABLE person
(	
	person_id SMALLINT UNSIGNED,
	fname VARCHAR(20),
	lname VARCHAR(20),
	gender ENUM('M', 'F'),
	birth_date DATE,
	street VARCHAR(20),
	city VARCHAR(20),
	state VARCHAR(20),
	country VARCHAR(20),
	postal_code VARCHAR(20),
	CONSTRAINT pk_person PRIMARY KEY (person_id)
);

DESC person;

CREATE TABLE favorite_food
(
	person_id SMALLINT UNSIGNED,
	food VARCHAR(20),
	CONSTRAINT pk_favorite_food PRIMARY KEY (person_id,food),
	CONSTRAINT fk_fav_food_person_id FOREIGN KEY (person_id) REFERENCES person (person_id)
);

DESC favorite_food;


ALTER TABLE person MODIFY person_id SMALLINT UNSIGNED AUTO_INCREMENT;

DESC person;

INSERT INTO person (person_id, fname, lname, gender, birth_date)
VALUES (null, "William", 'Turner', 'M', '1972-05-27');

SELECT person_id, fname, lname, birth_date FROM person; 

SELECT person_id, fname, lname, birth_date FROM person WHERE person_id = 1;

SELECT person_id, fname, lname, birth_date FROM person WHERE lname = 'Turner';

INSERT INTO favorite_food (person_id, food) VALUES (1, 'pizza');

INSERT INTO favorite_food (person_id, food) VALUES (1, 'cookies');

INSERT INTO favorite_food (person_id, food) VALUES (1, 'nachos');

SELECT food FROM favorite_food WHERE person_id = 1 ORDER BY food;

INSERT INTO person (person_id, fname, lname, gender, birth_date, street, city, state, country, postal_code)
VALUES (null, 'Susan', 'Smith', 'F', '1975-11-02', '23 Maple St.', 'Arlington', 'VA', 'USA', '20220');

SELECT person_id, fname, lname, birth_date FROM person;

UPDATE  person
SET street = '1225 Tremont St.',
	city = 'Boston',
	state = 'MA',
	country = 'USA',
	postal_code = '02138',
WHERE person_id = 1;

DELETE FROM person WHERE person_id = 2;

INSERT INTO person (person_id, fname, lname, gender, birth_date) 
VALUES (1, 'Charles', 'Fulton', 'M', '1968-01-15');

INSERT INTO favorite_food (person_id, food)
VALUES (999, 'lasagna');

UPDATE person 
SET gender = 'z'
WHERE person_id = 1;

UPDATE person
SET birth_date = 'DEC-21-1980'
WHERE person_id = 1;

UPDATE person
SET birth_date = str_to_date('DEC-21-1980', '%b-%d-%Y')
WHERE person_id = 1;

SHOW TABLES;

DROP TABLE;

DROP TABLE favorite_food;
DROP TABLE person;
DESC customer;

"""
第三章 查询入门
"""

SELECT emp_id, fname, lname FROM employee 
WHERE lname = 'Bkadfl';

SELECT fname, lname FROM employee;

SELECT * FROM department;

SELECT dept_id, name FROM department;

SELECT name FROM department;

SELECT emp_id, 'ACTIVE', emp_id * 3.14159, UPPER(lname) FROM employee;

SELECT VERSION(), USER(), DATABASE();

SELECT emp_id, 'ACTIVE' status, emp_id * 3.14159 empid_x_pi, UPPER(lname) last_name_upper FROM employee;

SELECT emp_id, 'ACTIVE' AS status, emp_id * 3.14159 AS empid_x_pi, UPPER(lname) AS last_name_upper FROM employee;

SELECT cust_id FROM account;

SELECT DISTINCT cust_id FROM account;

SELECT e.emp_id, e.fname, e.lname FROM (SELECT emp_id, fname, lname, start_date, title FROM employee) e;

CREATE VIEW employee_vw AS 
SELECT emp_id, fname, lname, YEAR(start_date) start_year FROM employee;

SELECT emp_id, start_year FROM employee_vw;

SELECT employee.emp_id, employee.fname, employee.lname, department.name dept_name 
FROM employee INNER JOIN department ON employee.dept_id = department.dept_id;

SELECT emp_id, fname, lname, start_date, title FROM employee
WHERE title = 'Head Teller';

SELECT emp_id, fname, lname, start_date, title
FROM employee WHERE title = 'Head Teller' AND start_date > '2006-01-01';

SELECT emp_id, fname, lname, start_date, title FROM employee
WHERE title = 'Head Teller' OR start_date > '2006-01-01';

SELECT emp_id, fname, lname, start_date, title FROM employee
WHERE (title = 'Head Teller' AND start_date > '2006-01-01') OR (title = 'Teller' AND start_date > '2006-01-01');

SELECT d.name, count(e.emp_id) num_employees
FROM department d INNER JOIN employee e
ON d.dept_id = e.dept_id GROUP BY d.name 
HAVING count(e.emp_id) > 2;

SELECT open_emp_id, product_cd FROM account;

SELECT open_emp_id, product_cd FROM account ORDER BY open_emp_id;

SELECT open_emp_id, product_cd FROM account ORDER BY open_emp_id, product_cd;

SELECT account_id, product_cd, open_date, avail_balance FROM account ORDER BY avail_balance DESC;

SELECT cust_id, cust_type_cd, city, state, fed_id FROM customer ORDER BY RIGHT(fed_id, 3);

SELECT emp_id, title, start_date, fname, lname FROM employee ORDER BY 2, 5;

"""
第四章 过滤
"""
SELECT pt.name product_type, p.name product FROM product p INNER JOIN product_type pt
ON p.product_type_cd = pt.product_type_cd WHERE pt.name = 'Customer Accounts';

SELECT pt.name product_type, p.name product FROM product p INNER JOIN product_type pt
ON p.product_type_cd = pt.product_type_cd WHERE pt.name <> "Customer Accounts";

SELECT emp_id, fname, lname, start_date FROM employee 
WHERE start_date < '2007-01-01';

SELECT emp_id, fname, lname, start_date FROM employee
WHERE start_date < '2007-01-01' AND start_date >= '2005-01-01';

SELECT emp_id, fname, lname, start_date FROM employee 
WHERE start_date BETWEEN '2005-10-01' AND '2007-01-01';

SELECT emp_id, fname, lname, start_date FROM employee
WHERE start_date BETWEEN '2007-01-01' AND '2005-01-01';

SELECT emp_id, fname, lname, start_date FROM employee
WHERE start_date >= '2007-01-01' AND start_date <= '2005-01-01';

SELECT emp_id, fname, lname, start_date FROM employee 
WHERE start_date >= '2007-01-01' AND start_date <= '2005-01-01';

SELECT account_id, product_cd, cust_id, avail_balance FROM account
WHERE avail_balance BETWEEN 3000 AND 5000;

SELECT cust_id, fed_id FROM customer WHERE cust_type_cd = 'I'
AND fed_id BETWEEN '50-00-0000' AND '999-99-9999';

SELECT account_id, product_cd, cust_id, avail_balance FROM account
WHERE product_cd = 'CHK' OR product_cd = 'SAV'
OR product_cd = 'CD' OR product_cd = 'MM';

SELECT account_id, product_cd, cust_id, avail_balance FROM account
WHERE product_cd IN ('CK', 'SAV', 'CD', 'MM');

SELECT account_id, product_cd, cust_id, avail_balance FROM account
WHERE product_cd IN (SELECT product_cd FROM product WHERE product_type_cd = 'ACCOUNT');

SELECT account_id, product_cd, cust_id, avail_balance FROM account 
WHERE product_cd NOT IN ('CHK', 'SAV', 'CD', 'MM');

#SELECT emp_id, fname, lname, FROM employee WHERE LEFT(lname, 1) = 'T';

SELECT lname FROM employee WHERE lname LIKE '_a%e%';

SELECT cust_id, fed_id FROM customer WHERE fed_id LIKE '___-__-___';

SELECT emp_id, fname, lname FROM employee WHERE lname LIKE 'F%' OR lname LIKE 'G%';

SELECT emp_id, fname, lname FROM employee WHERE lname REGEXP '^[FG]';

SELECT emp_id, fname, lname, superior_emp_id FROM employee WHERE superior_emp_id IS NULL;

SELECT emp_id, fname, lname, superior_emp_id FROM employee WHERE superior_emp_id = NULL;

SELECT emp_id, fname, lname, superior_emp_id FROM employee WHERE superior_emp_id IS NOT NULL;

SELECT emp_id, fname, lname, superior_emp_id FROM employee WHERE superior_emp_id != 6;

SELECT emp_id, fname, lname, superior_emp_id FROM employee 
WHERE superior_emp_id != 6 OR superior_emp_id IS NULL;

"""
第五章 多表查询
"""
DESC employee;

DESC department;

SELECT e.fname, e.lname, d.name FROM employee e JOIN department d;

SELECT e.fname, e.lname, d.name FROM employee e JOIN department d ON e.dept_id = d.dept_id;

SELECT e.fname, e.lname, d.name FROM employee e INNER JOIN department d ON e.dept_id = d.dept_id;

SELECT e.fname, e.lname, d.name FROM employee e INNER JOIN department d USING (dept_id);

SELECT e.fname, e.lname, d.name FROM employee e, department d WHERE e.dept_id = d.dept_id;

SELECT a.account_id, a.cust_id, a.open_date, a.product_cd FROM account a, branch b, employee e
WHERE a.open_emp_id = e.emp_id
AND e.start_date < '2007-01-01'
AND e.assigned_branch_id = b.branch_id
AND (e.title = 'Teller' OR e.title = 'Head Teller')
AND b.name = 'Woburn Branch';

SELECT a.account_id, a.cust_id, a.open_date, a.product_cd FROM account a INNER JOIN employee e
ON a.open_emp_id = e.emp_id
INNER JOIN branch b
ON e.assigned_branch_id = b.branch_id
WHERE e.start_date < '2007-01-01'
AND (e.title = 'Teller' OR e.title = 'Head Teller')
AND b.name = 'Woburn Branch';

SELECT a.account_id, c.fed_id FROM account a INNER JOIN customer c
ON a.cust_id = c.cust_id WHERE c.cust_type_cd = 'B';

SELECT a.account_id, c.fed_id, e.fname, e.lname FROM account a INNER JOIN customer c
ON a.cust_id = c.cust_id
INNER JOIN employee e
ON a.open_emp_id = e.emp_id
WHERE c.cust_type_cd = 'B';

SELECT a.account_id, c.fed_id, e.fname, e.lname FROM customer c INNER JOIN account a
ON e.emp_id = a.open_emp_id
INNER JOIN customer c
ON a.cust_id = c.cust_id
WHERE c.cust_type_cd = 'B';

SELECT emp_id, assigned_branch_id FROM employee
WHERE start_date < '2007-01-01'
AND (title = 'Teller' OR title = 'Head Teller');

SELECT branch_id FROM branch 
WHERE name = 'Woburn Branch';

SELECT a.account_id, e.emp_id, b_a.name open_branch, b_e.name emo_branch
FROM account a INNER JOIN branch b_a
ON a.open_branch_id = b_a.branch_id
INNER JOIN employee e
ON a.open_emp_id = e.emp_id
INNER JOIN branch b_e
ON e.assigned_branch_id = b_e.branch_id
WHERE a.product_cd = 'CHK';

SELECT e.fname, e.lname, e_mgr.fname mgr_fname, e_mgr.lname mgr_lname
FROM employee e INNER JOIN employee e_mgr
ON e.superior_emp_id = e_mgr.emp_id;

SELECT e1.fname, e1.lname, 'VS' vs, e2.fname, e2.lname
FROM employee e1 INNER JOIN employee e2
ON e1.emp_id != e2.emp_id
WHERE e1.title = 'Teller' AND e2.title = 'Teller';

SELECT e1.fname, e1.lname, 'VS' vs, e2.fname, e2.lname
FROM employee e1 INNER JOIN employee e2
ON e1.emp_id < e2.emp_id
WHERE e1.title = 'Teller' AND e2.title = 'Teller';

SELECT a.account_id, a.product_cd, c.fed_id FROM account a INNER JOIN customer c
ON a.cust_id = c.cust_id
WHERE c.cust_type_cd = 'B';

SELECT a.account_id, a.product_cd, c.fed_id FROM account a INNER JOIN customer c
ON a.cust_id = c.cust_id
AND c.cust_type_cd = 'B';

SELECT a.account_id, a.product_cd, c.fed_id FROM account a INNER JOIN customer c
WHERE a.account_id = c.cust_id
AND c.cust_type_cd = 'B';

"""
第六章 使用集合
"""
DESC product;

DESC customer;

SELECT 1 num, 'abc' str
UNION 
SELECT 9 num, 'xyz' str;

SELECT 'IND' type_cd, cust_id, lname name
FROM individual
UNION ALL
SELECT 'BUS' type_cd, cust_id, name
FROM business;

SELECT 'IND' type_cd, cust_id, lname name
FROM individual
UNION ALL
SELECT 'BUS' type_cd, cust_id, name
FROM business
UNION ALL
SELECT 'BUS' type_cd, cust_id, name
FROM business;

SELECT emp_id
FROM employee
WHERE assigned_branch_id = 2
AND (title = 'Teller' OR title = 'Head Teller')
UNION ALL
SELECT DISTINCT open_emp_id
FROM account
WHERE open_branch_id = 2;

###
SELECT emp_id, fname, lname
FROM employee
INTERSECT 
SELECT cust_id, fname, lname
FROM individual

SELECT emp_id
FROM employee
WHERE assigned_branch_id = 2
AND (title = 'Teller' OR title = 'Head Teller')
INTERSECT
SELECT DISTINCT open_emp_id
FROM account
WHERE open_branch_id = 2;

SELECT emp_id
FROM employee
WHERE assigned_branch_id = 2
AND (title = 'Teller' OR title = 'Head Teller')
EXCEPT 
SELECT DISTINCT open_emp_id
FROM account
WHERE open_branch_id = 2;
###

SELECT emp_id, assigned_branch_id
FROM employee
WHERE title = 'Teller'
UNION
SELECT open_emp_id, open_branch_id
FROM account
WHERE product_cd = 'SAV'
ORDER BY emp_id;

SELECT emp_id, assigned_branch_id
FROM employee
WHERE title = 'Teller'
UNION 
SELECT open_emp_id, open_branch_id
FROM account
WHERE product_cd = 'SAV'
ORDER BY emp_id;

SELECT cust_id FROM account
WHERE product_cd IN ('SAV', 'MM')
UNION ALL
SELECT a.cust_id
FROM account a INNER JOIN branch b
ON a.open_branch_id = b.branch_id
WHERE b.name = 'Woburn Branch'
UNION 
SELECT cust_id FROM account
WHERE avail_balance BETWEEN 500 AND 2500;

SELECT cust_id FROM account
WHERE product_cd IN ('SAV', 'MM')
UNION
SELECT a.cust_id
FROM account a INNER JOIN branch b
ON a.open_branch_id = b.branch_id
WHERE b.name = 'Woburn Branch'
UNION ALL
SELECT cust_id FROM account 
WHERE avail_balance BETWEEN 500 AND 2500;

"""
第七章 数据生成、转换和操作
"""
INSERT INTO string_tbl (char_fld, vchar_fld, text_fld)
VALUES ('This is char data', 'This is varchar data', 'This is text data');

UPDATE string_tbl SET varchar_fld = 'This is a piece of extremely long varchar data';

UPDATE string_tbl SET text_fld = 'This string didn''t work, but it does now';

SELECT text_fld FROM string_tbl;

SELECT quote(text_fld) FROM string_tbl;

DELETE FROM string_tbl;

INSERT INTO string_tbl (char_fld, vchar_fld, text_fld) VALUES
('This string is 28 characters', 'This string is 28 characters', 'This string is 28 characters');

SELECT LENGTH(char_fld) char_length,
LENGTH(vchar_fld) varchar_length, LENGTH(text_fld) text_fld FROM string_tbl;

SELECT POSITION('characters' IN vchar_fld) FROM string_tbl;

SELECT LOCATE('is', vchar_fld, 5) FROM string_tbl;

DELETE FROM string_tbl;

INSERT INTO string_tbl(vchar_fld) VALUES('abcd');

INSERT INTO string_tbl(vchar_fld) VALUES('xyz');

INSERT INTO string_tbl(vchar_fld) VALUES('QRSTUV');

INSERT INTO string_tbl(vchar_fld) VALUES('qrstuv');

INSERT INTO string_tbl(vchar_fld) VALUES('12345');

SELECT vchar_fld FROM string_tbl ORDER BY vchar_fld;

SELECT STRCMP('12345', '12345') 12345_12345, STRCMP('abcd', 'xyz') abcd_xyz,
STRCMP('abcd', 'QRSTUV') abcd_QRSTUV, STRCMP('qrstuv', 'QRSTUV') qrstuv_QRSTUV,
STRCMP('12345', 'xyz') 12345_xyz, STRCMP('xyz', 'qrstuv') xyz_qrstuv;

SELECT name, name LIKE '%ns' ends_in_ns FROM department;

SELECT cust_id, cust_type_cd, fed_id, fed_id REGEXP '.{3}-.{2}-.{4}' is_ss_no_format FROM customer;

DELETE FROM string_tbl;

INSERT INTO string_tbl (text_fld) VALUES ('This string was 29 characters');

UPDATE string_tbl SET text_fld = CONCAT(text_fld, ', but now it is longer');

SELECT text_fld FROM string_tbl;

SELECT CONCAT(fname, ' ', lname, ' has been a ', title, ' since ', start_date) emp_narrative FROM employee
WHERE title = 'Teller' OR title = 'Head Teller';

SELECT INSERT('goodbye world', 9, 0, 'cruel') string;

SELECT INSERT('goodbye world', 1, 7, 'hello') string;

SELECT SUBSTRING('goodbye cruel world', 9, 5);

SELECT (37*59)/(78-(8*6));

SELECT MOD(10, 4);

SELECT POW(2, 8);

SELECT POW(2, 10) kilobyte, POW(2, 20) megabyte, POW(2, 30) gigabyte, POW(2, 40) terabyte;

SELECT CEIL(72.445), FLOOR(72.445);

SELECT CEIL(72.0000000001), FLOOR(72.999999999);

SELECT ROUND(72.49999), ROUND(72.5), ROUND(72.50001);

SELECT ROUND(72.0901, 1), ROUND(72.0909), ROUND(72.0909, 3);

SELECT TRUNCATE(72.0909, 1), TRUNCATE(72.0909, 2), TRUNCATE(72.0909, 3);

SELECT ROUND(17, -1), TRUNCATE(17, -1);

SELECT account_id, SING(avail_balance), ABS(avail_balance) FROM account;

"""
第八章 分组和聚集
"""
SELECT open_emp_id FROM account;

SELECT open_emp_id FROM account GROUP BY open_emp_id;

SELECT open_emp_id, COUNT(*) how_many FROM account GROUP BY open_emp_id;

SELECT open_emp_id, COUNT(*) how_many FROM account 
GROUP BY open_emp_id HAVING COUNT(*) > 4;

SELECT MAX(avail_balance) max_balance, MIN(avail_balance) min_balance, 
AVG(avail_balance) avg_balance, SUM(avail_balance) tot_balance,
COUNT(*) num_accounts FROM account WHERE product_cd = 'CHK';

SELECT product_cd, MAX(avail_balance) max_balance, 
MIN(avail_balance) min_balance, AVG(avail_balance) avg_balance,
SUM(avail_balance) tot_balance, COUNT(*) num_accts FROM account GROUP BY product_cd;

SELECT account_id, open_emp_id FROM account ORDER BY open_emp_id;

SELECT COUNT(open_emp_id) FROM account;

SELECT COUNT(DISTINCT open_emp_id) FROM account;

SELECT MAX(pending_balance - avail_balance) max_uncleared FROM account;

SELECT product_cd, SUM(avail_balance) prod_balance FROM account GROUP BY product_cd;

SELECT product_cd, open_branch_id, SUM(avail_balance) tot_balance FROM account 
GROUP BY product_cd, open_branch_id;

SELECT EXTRACT(YEAR FROM start_date) year, COUNT(*) how_many FROM employee 
GROUP BY EXTRACT(YEAR FROM start_date);

SELECT product_cd, open_branch_id, SUM(avail_balance) tot_balance FROM account
GROUP BY product_cd, open_branch_id WITH ROLLUP;

SELECT product_cd, SUM(avail_balance) prod_balance FROM account WHERE status = 'ACTIVE' GROUP BY product_cd
HAVING SUM(avail_balance) >= 10000;

SELECT product_cd, SUM(avail_balance) prod_balance FROM account WHERE status = 'ACTIVE' GROUP BY product_cd
HAVING MIN(avail_balance) >= 1000 AND MAX(avail_balance) <= 10000; 


"""
第九章 子查询
"""
SELECT account_id, product_cd, cust_id, avail_balance FROM account
WHERE account_id = (SELECT MAX(account_id) FROM account);

SELECT account_id, product_cd, cust_id, avail_balance FROM account
WHERE open_emp_id <> (SELECT e.emp_id FROM employee e INNER JOIN branch b ON e.assigned_branch_id = b.branch_id
WHERE e.title = "Head Teller" AND b.city = "Woburn");

SELECT branch_id, name, city FROM branch WHERE name IN ("Headquarters", "Quincy Branch");

SELECT branch_id, name, city FROM branch WHERE name = "Headquarters" OR name = "Quincy Branch";

SELECT emp_id, fname, lname, title FROM employee WHERE emp_id IN (SELECT superior_emp_id FROM employee);

SELECT emp_id, fname, lname, title FROM employee 
WHERE emp_id NOT IN (SELECT superior_emp_id FROM employee WHERE superior_emp_id IS NOT NULL);

SELECT emp_id, fname, lname, title FROM employee 
WHERE emp_id <> ALL (SELECT superior_emp_id FROM employee WHERE superior_emp_id IS NOT NULL);

SELECT emp_id, fname, lname, title FROM employee WHERE emp_id NOT IN (1, 2, NULL);

SELECT account_id, cust_id, product_cd, avail_balance FROM account
WHERE avail_balance < ALL (SELECT a.avail_balance FROM account a INNER JOIN individual i ON
a.cust_id = i.cust_id WHERE i.fname = 'Frank' AND i.lname = 'Tucker');

SELECT account_id, cust_id, product_cd, avail_balance FROM account 
WHERE avail_balance > ANY (SELECT a.avail_balance FROM account a INNER JOIN individual i ON a.cust_id = i.cust_id
WHERE i.fname = 'Frank' AND i.lname = 'Tucker');

SELECT account_id, product_cd, cust_id FROM account
WHERE open_branch_id = (SELECT branch_id FROM branch WHERE name = 'Woburn Branch')
AND open_emp_id IN (SELECT emp_id FROM employee WHERE title = 'Teller' OR title = 'Head Teller');

SELECT c.cust_id, c.cust_type_cd, c.city FROM customer c
WHERE 2 = (SELECT COUNT(*) FROM account a WHERE a.cust_id = c.cust_id);

SELECT c.cust_id, c.cust_type_cd, c.city FROM customer c
WHERE (SELECT SUM(a.avail_balance) FROM account a WHERE a.cust_id = c.cust_id) BETWEEN 5000 AND 10000;

SELECT a.account_id, a.product_cd, a.cust_id FROM account a WHERE
NOT EXISTS (SELECT 1 FROM business b WHERE b.cust_id = a.cust_id);

SELECT d.dept_id, d.name, e_cnt.how_many num_employees FROM 
department d INNER JOIN (SELECT dept_id, COUNT(*) how_many FROM employee GROUP BY dept_id) e_cnt
ON d.dept_id = e_cnt.dept_id;

SELECT open_emp_id, COUNT(*) how_many FROM account GROUP BY open_emp_id
HAVING COUNT(*) = (SELECT MAX(emp_cnt.how_many) FROM 
(SELECT COUNT(*) how_many FROM account GROUP BY open_emp_id) emp_cnt);

SELECT emp.emp_id, CONCAT(emp.fname, " ", emp.lname) emp_name, 
(SELECT CONCAT(boss.fname, ' ', boss.lname) FROM employee boss WHERE boss.emp_id = emp.superior_emp_id) boss_name
FROM employee emp WHERE emp.superior_emp_id IS NOT NULL ORDER BY (SELECT boss.lname FROM employee boss 
WHERE boss.emp_id = emp.superior_emp_id), emp.lname;

"""
第十章 再谈连接
"""
SELECT account_id, cust_id FROM account;

SELECT cust_id FROM customer;

SELECT a.account_id unt_id, c.cust_id FROM account a INNER JOIN customer c ON
a.cust_id = c.cust_id;

SELECT a.account_id, b.cust_id, b.name FROM account a INNER JOIN business b 
ON a.cust_id = b.cust_id;

SELECT cust_id, name FROM business;

SELECT a.account_id, a.cust_id, b.name FROM
account a LEFT OUTER JOIN business b
ON a.cust_id = b.cust_id;

SELECT a.account_id, a.cust_id, i.fname, i.lname FROM
account a LEFT OUTER JOIN individual i ON a.cust_id = i.cust_id;

SELECT c.cust_id, b.name FROM customer c LEFT OUTER JOIN business b
ON c.cust_id = b.cust_id;

SELECT c.cust_id, b.name FROM customer c RIGHT OUTER JOIN business b
ON c.cust_id = b.cust_id;

SELECT a.account_id, a.product_cd, CONCAT(i.fname, " ", i.lname) person_name, b.name business_name
FROM account a LEFT OUTER JOIN individual i ON a.cust_id = i.cust_id LEFT OUTER JOIN business b
ON a.cust_id = b.cust_id;

SELECT e.fname, e.lname, e_mgr.fname mgr_fname, e_mgr.lname mgr_lname FROM employee
e INNER JOIN employee e_mgr ON e.superior_emp_id = e_mgr.emp_id;

SELECT e.fname, e.lname, e_mgr.fname mgr_fname, e_mgr.lname mgr_lname FROM
employee e LEFT OUTER JOIN employee e_mgr ON e.superior_emp_id = e_mgr.emp_id;

SELECT e.fname, e.lname, e_mgr.fname mgr_fname, e_mgr.lname mgr_lname FROM
employee e RIGHT OUTER JOIN employee e_mgr ON e.superior_emp_id = e_mgr.emp_id;

SELECT pt.name, p.product_cd, p.name FROM product p CROSS JOIN product_type pt;

SELECT a.account_id, a.cust_id, c.cust_type_cd, c.fed_id FROM account a NATURAL JOIN customer c;

SELECT a.account_id, a.cust_id, a.open_branch_id, b.name FROM account a NATURAL JOIN branch b;

"""
第十一章 条件逻辑
"""
SELECT c.cust_id, c.fed_id, c.cust_type_cd, CONCAT(i.fname, ' ', i.lname) indiv_name,
b.name business_name FROM customer c LEFT OUTER JOIN individual i ON c.cust_id = i.cust_id
LEFT OUTER JOIN business b ON c.cust_id = b.cust_id;

SELECT c.cust_id, c.fed_id, 
CASE 
	WHEN c.cust_type_cd = 'I'
		THEN CONCAT(i.fname, ' ', i.lname)
	WHEN c.cust_type_cd = 'B'
		THEN b.name
	ELSE 'Unknown'
END name
FROM customer c LEFT OUTER JOIN individual i 
ON c.cust_id = i.cust_id
LEFT OUTER JOIN business b
ON c.cust_id = b.cust_id;

SELECT c.cust_id, c.fed_id,
CASE
	WHEN c.cust_type_cd = 'I' THEN
		(SELECT CONCAT(i.fname, ' ', i.lname) FROM individual i  WHERE i.cust_id = c.cust_id)
	WHEN c.cust_type_cd = 'B' THEN
		(SELECT b.name FROM business b WHERE b.cust_id = c.cust_id)
	ELSE 'Unknown'
END name
FROM customer c;

SELECT YEAR(open_date) year, COUNT(*) how_many
FROM account WHERE open_date > '1999-12-31' AND open_date < '2006-01-01'
GROUP BY YEAR(open_date);

SELECT 
SUM(CASE
		WHEN EXTRACT(YEAR FROM open_date) = 2000 THEN 1 ELSE 0 END) year_2000,
SUM(CASE
		WHEN EXTRACT(YEAR FROM open_date) = 2001 THEN 1 ELSE 0 END) year_2001,
SUM(CASE
		WHEN EXTRACT(YEAR FROM open_date) = 2002 THEN 1 ELSE 0 END) year_2002,
SUM(CASE
		WHEN EXTRACT(YEAR FROM open_date) = 2003 THEN 1 ELSE 0 END) year_2003,
SUM(CASE
		WHEN EXTRACT(YEAR FROM open_date) = 2004 THEN 1 ELSE 0 END) year_2004,
SUM(CASE
		WHEN EXTRACT(YEAR FROM open_date) = 2005 THEN 1 ELSE 0 END) year_2005
FROM account
WHERE open_date > '1999-12-31' AND open_date < '2006-01-01';

SELECT c.cust_id, c.fed_id, c.cust_type_cd, 
CASE	
	WHEN EXISTS(SELECT 1 FROM account a WHERE a.cust_id = c.cust_id AND a.product_cd = 'CHK') THEN 'Y'
	ELSE 'N'
END has_checking,
CASE 
	WHEN EXISTS(SELECT 1 FROM account a WHERE a.cust_id = c.cust_id AND a.product_cd = 'SAV') THEN 'Y'
	ELSE 'N'
END has_savings
FROM customer c;

SELECT c.cust_id, c.fed_id, c.cust_type_cd, 
CASE (SELECT COUNT(*) FROM account a WHERE a.cust_id = c.cust_id)
	WHEN 0 THEN 'None'
	WHEN 1 THEN '1'
	WHEN 2 THEN '2'
	ELSE '3+'
END num_accounts
FROM customer c;

SELECT a.cust_id, a.product_cd, a.avail_balance / 
CASE 
	WHEN prod_tots.tot_balance = 0 THEN 1
	ELSE prod_tots.tot_balance
END percent_of_total
FROM account a INNER JOIN
	(SELECT a.product_cd, SUM(a.avail_balance) tot_balance FROM account a GROUP BY a.product_cd) prod_tots 
ON a.product_cd = prod_tots.product_cd;


"""
第十二章 事务
"""

"""
第十三章 索引和约束
"""
SELECT dept_id, name FROM department
WHERE name LIKE 'A%';

ALTER TABLE department ADD INDEX dept_name_idx (name);

SHOW INDEX FROM department \G

ALTER TABLE department DROP INDEX dept_name_idx;

ALTER TABLE department ADD UNIQUE dept_name_idx (name);

INSERT INTO department (dept_id, name) VALUES (999, 'Operations');

ALTER TABLE employee ADD INDEX emp_names_idx (lname, fname);

SELECT emp_id, fname, lname FROM employee WHERE emp_id IN (1, 3, 9, 15);

SELECT cust_id, SUM(avail_balance) tot_bal FROM account
WHERE cust_id IN (1, 5, 9, 11)
GROUP BY cust_id;

EXPLAIN SELECT cust_id, SUM(avail_balance) tot_bal FROM account
WHERE cust_id IN (1, 5, 9, 11)
GROUP BY cust_id \G

ALTER TABLE account ADD INDEX acc_bal_idx (cust_id, avail_balance);

EXPLAIN SELECT cust_id, SUM(avail_balance) tot_bal
FROM account WHERE cust_id IN (1, 5, 9, 11) GROUP BY cust_id \G

SELECT product_type_cd, name FROM product_type;

SELECT product_type_cd, product_cd, name FROM product ORDER BY product_type_cd;

###
UPDATE product SET product_type_cd = 'XYZ'WHERE product_type_cd = 'LOAN';

UPDATE product_type SET product_type_cd = 'XYZ' WHERE product_type_cd = 'LOAN';
###

ALTER TABLE product DROP FOREIGN KEY fk_product_type_cd;

ALTER TABLE product ADD CONSTRAINT fk_product_type_cd FOREIGN KEY (product_type_cd) REFERENCES
product_type (product_type_cd) ON UPDATE CASCADE;

UPDATE product_type SET product_type_cd = 'XYZ' WHERE product_type_cd = 'LOAN';

SELECT product_type_cd, name FROM product_type;

SELECT product_type_cd, product_cd, name FROM product ORDER BY product_type_cd;

"""
第十四章 视图
"""
CREATE VIEW customer_vw 
(
	cust_id,
	fed_id,
	cust_type_cd,
	address,
	city,
	state,
	zipcode
) AS 
SELECT cust_id, concat('ends in ', substr(fed_id, 8, 4)) fed_id,
cust_type_cd, address, city, state, postal_code FROM customer;

SELECT cust_id, fed_id, cust_type_cd FROM customer_vw;

describe customer_vw;

SELECT cust_type_cd, count(*) FROM customer_vw WHERE state = 'MA' GROUP BY cust_type_cd ORDER BY 1;

SELECT cst.cust_id, cst.fed_id, bus.name FROM customer_vw cst INNER JOIN business bus ON cst.cust_id = bus.cust_id;

CREATE VIEW business_customer_vw 
(
	cust_id,
	fed_id,
	cust_type_cd,
	address,
	city,
	state,
	zipcode
)
AS SELECT cust_id, concat('ends in ', substr(fed_id, 8, 4)) fed_id,
cust_type_cd, address, city, state, postal_code FROM customer 
WHERE cust_type_cd = 'B';

CREATE VIEW customer_total_vw
(
	cust_id, 
	cust_type_cd,
	cust_name,
	num_accounts,
	tot_deposits
)
AS SELECT cst.cust_id, cst.cust_type_cd,
CASE 
	WHEN cst.cust_type_cd = 'B' THEN
		(SELECT bus.name FROM business bus WHERE bus.cust_id = cst.cust_id)
	ELSE
		(SELECT concat(ind.fname, ' ', ind.lname) FROM individual ind WHERE ind.cust_id = cst.cust_id)
	END cust_name,
	SUM(CASE WHEN act.status = 'ACTIVE' THEN 1 ELSE 0 END) tot_active_accounts,
	SUM(CASE WHEN act.status = 'ACTIVE' THEN act.avail_balance ELSE 0 END) tot_balance
FROM customer cst INNER JOIN account act ON act.cust_id = cst.cust_id
GROUP BY cst.cust_id, cst.cust_type_cd;

CREATE TABLE customer_totals AS SELECT * FROM customer_total_vw;

CREATE OR REPLACE VIEW customer_totals_vw
(
	cust_id, 
	cust_type_cd, 
	cust_name,
	num_accounts,
	tot_deposits
)
AS SELECT cust_id, cust_type_cd, cust_name, num_accounts, tot_deposits
FROM customer_totals;

CREATE VIEW customer_vw 
(
	cust_id,
	fed_id,
	cust_type_cd,
	address,
	city,
	state,
	zipcode
) AS 
SELECT cust_id, concat('ends in ', substr(fed_id, 8, 4)) fed_id,
cust_type_cd, address, city, state, postal_code FROM customer;

UPDATE customer_vw SET city = 'Woooburn' WHERE city = 'Woburn';

SELECT DISTINCT city FROM customer;

###
UPDATE customer_vw SET city = 'Woburn', fed_id = '99999999' WHERE city = 'Woooburn';

INSERT INTO customer_vw (cust_id, cust_type_cd, city) VALUES (9999, 'I', 'Worcester');
###

CREATE VIEW business_customer_vw
(
	cust_id,
	fed_id,
	address,
	city,
	state,
	postal_code,
	business_name,
	state_id,
	incorp_date
)
AS SELECT cst.cust_id, 
cst.fed_id, cst.address,
cst.city, cst.state,
cst.postal_code,
bsn.name, bsn.state_id, bsn.incorp_date
FROM customer cst INNER JOIN business bsn 
ON cst.cust_id = bsn.cust_id
WHERE cust_type_cd = 'B';

UPDATE business_customer_vw SET postal_code = '99999' WHERE cust_id = 10;

UPDATE business_customer_vw SET incorp_date = '2008-11-17' WHERE cust_id = 10;

###
UPDATE business_customer_vw SET postal_code = '88888', incorp_date = '2008-10-31' WHERE cust_id = 10;
###

SELECT table_name, table_type FROM information_schema.tables WHERE 
table_schema = 'bank' ORDER BY 1;

SELECT table_name, table_type FROM information_schema.tables WHERE
table_schema = 'bank' AND table_type = 'BASE TABLE' ORDER BY 1;

SELECT table_name, is_updatable FROM information_schema.views WHERE table_schema = 'bank' ORDER BY 1;

SELECT column_name, data_type, character_maximum_length char_max_len, 
numeric_precision num_prcsn, numeric_scale num_scale FROM 
information_schema.columns WHERE table_schema = 'bank' AND table_name = 'account'
ORDER BY ordinal_position;

SELECT index_name, non_unique, seq_in_index, column_name FROM 
information_schema.statistics WHERE table_schema = 'bank' AND
table_name = 'account' ORDER BY 1, 3;

SELECT constraint_name, table_name, constraint_type FROM 
information_schema.table_constraints WHERE table_schema = 'bank' ORDER BY 3, 1;

SELECT 'CREATE TABLE customer (' create_table_statement UNION ALL
SELECT cols.txt 
FROM 
	(SELECT concat(' ', column_name, ' ', column_type,
			CASE 
				WHEN is_nullable = 'NO' THEN ' not null'
				ELSE ''
			END,
			CASC
				WHEN extra IS NOT NULL THEN concat(' ', extra)
				ELSE ''
			END,
			',') txt
	FROM information_schema.columns WHERE table_schema = 'bank' AND table_name = 'customer'
	ORDER BY ordinal_position
	) cols
	UNION ALL
	SELECT ')';

SET @qry = 'SELECT cust_id, cust_type_cd, fed_id FROM customer';
PREPARE dynsql1 FROM @qry;
EXECUTE dynsql1;
DEALLOCATE PREPARE dynsql1;




