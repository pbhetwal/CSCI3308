SELECT * FROM store ORDER BY sname; 

SELECT * FROM store ORDER BY sname LIMIT 3;

SELECT * FROM store ORDER BY sname DESC LIMIT 3; 

SELECT * FROM store WHERE price > 1; 

SELECT *, qty * price AS extended_price FROM store; 

SELECT SUM(qty * price) AS total_cost FROM store; 

SELECT course.cname AS cs_classes FROM course INNER JOIN department ON course.department_id = department.id WHERE department.name = 'CSC';

SELECT SUM(count) AS enrollment_total FROM enrollment;

SELECT COUNT(id) AS department_count FROM department; 

UPDATE course SET department_id = 3 WHERE course.cname = '112'; 

ALTER TABLE enrollment ADD COLUMN drop_count TEXT; 
ALTER TABLE  enrollment ALTER COLUMN drop_count TYPE VARCHAR; 
ALTER TABLE  enrollment ALTER COLUMN drop_count TYPE INTEGER USING drop_count::integer;

UPDATE enrollment SET drop_count = count * 0.2;
SELECT * enrollment; 

SELECT CONCAT(department.name, course.cname) FROM department INNER JOIN course ON course.department_id = department.id WHERE department.name = 'CSC'; 
SELECT c.cname, d.name, e.count FROM course AS c INNER JOIN department AS d ON c.department_id=d.id INNER JOIN enrollment AS e ON c.id=e.id ORDER BY d.name;

ALTER TABLE enrollment DROP COLUMN drop_count;
TRUNCATE enrollment;
DROP TABLE enrollment;
CREATE TABLE new_enrollment(id SERIAL PRIMARY KEY, department_name VARCHAR NOT NULL, count int NOT NULL, drop_count int);
INSERT INTO new_enrollment(department_name, count, drop_count) VALUES ('CSC', 100, 20), ('CHM', 120, 5), ('MTH', 90, 3), ('EGR', 122, 12), ('MTH', 68, 6), ('CSC', 100, 3), ('CHM', 30, 1);