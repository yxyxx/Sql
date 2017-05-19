-- 1.	Show all data of the clerks who have been hired after the year 1997.
-- select * from employees where HIRE_DATE > '1997';

-- 2.Show the last name,  job, salary, and commission of those employees who earn commission. Sort the data by the salary in descending order
-- select last_name,job_id,salary,COMMISSION_PCT from employees where COMMISSION_PCT is not null ORDER BY SALARY DESC;

-- 3.Show the employees that have no commission with a 10% raise in their salary (round off thesalaries).
-- update employees set SALARY = SALARY*1.1 where COMMISSION_PCT is null;

-- 4.	Show the last names of all employees together with the number of years and the number ofcompleted months that they have been employed.
-- select LAST_NAME,TIMESTAMPDIFF(year,HIRE_DATE,NOW()) as 'year',TIMESTAMPDIFF(month,HIRE_DATE,NOW())-(TIMESTAMPDIFF(year,HIRE_DATE,NOW())*12) as 'month' from employees;

-- 5.	Show those employees that have a name starting with J, K, L, or M.
--  select last_name from employees where LAST_NAME like 'J%' OR LAST_NAME like 'K%' or LAST_NAME like 'L%' or LAST_NAME like 'M%';

-- 6.	Show all employees, and indicate with “Yes” or “No” whether they receive a commission.
--  select LAST_NAME ,SALARY ,IF(COMMISSION_PCT,'yes','no') as 'COM' from employees;

-- 7. Show the department names, locations, names, job titles, and salaries of employees who workin location 1800.
-- select d.DEPARTMENT_NAME,d.LOCATION_ID,e.last_name,e.JOB_ID,e.SALARY from departments d,employees e where d.DEPARTMENT_ID = e.DEPARTMENT_ID and d.LOCATION_ID=1800

-- 8. How many employees have a name that ends with an n? Create two possible solutions.
-- select count(last_name) from employees where LAST_NAME like '%_N';

-- 9.Show the names and locations for all departments, and the number of employees working in each department. Make sure that departments without employees are included as well.
-- select  d.DEPARTMENT_ID,d.DEPARTMENT_NAME,d.LOCATION_ID,COUNT(e.EMPLOYEE_ID) from departments d,employees e where d.DEPARTMENT_ID =e.DEPARTMENT_ID group by d.DEPARTMENT_NAME

-- 10.	Which jobs are found in departments 10 and 20?
-- select j.JOB_ID from jobs j,departments d,employees e where  e.DEPARTMENT_ID=d.DEPARTMENT_ID and j.JOB_ID =e.JOB_ID and (d.DEPARTMENT_ID=10 or d.DEPARTMENT_ID =20)

-- 11.	Which jobs are found in the Administration and Executive departments, and how manyemployees do these jobs? Show the job with the highest frequency first.
-- SELECT j.JOB_ID,COUNT(e.EMPLOYEE_ID) AS FREQUENCY
-- FROM jobs j,employees e,departments d
-- WHERE e.JOB_ID=j.JOB_ID AND e.DEPARTMENT_ID=d.DEPARTMENT_ID AND d.DEPARTMENT_NAME IN("Administration","Executive")
-- GROUP BY j.JOB_ID ORDER BY FREQUENCY DESC,JOB_ID ASC;

-- 12.Show all employees who were hired in the first half of the month (before the 16th of the month).
-- select LAST_NAME,HIRE_DATE from employees where MONTH(HIRE_DATE)<7 and day(HIRE_DATE) <16;

-- 13. Show the names, salaries, and the number of dollars (in thousands) that all employees earn.
-- select LAST_NAME,SALARY,FLOOR(SALARY/1000) AS thousands from employees

-- 14.Show all employees who have managers with a salary higher than $15,000. Show thefollowing data: employee name, manager name, manager salary, and salary grade of the manager.
-- SELECT x.last_name,y.last_name as MANAGER,y.salary,g.grade_level
-- FROM employees x,employees y,job_grades g
-- WHERE y.employee_id = x.manager_id and y.salary > 15000 and y.salary BETWEEN g.lowest_sal AND g.highest_sal;

-- 15.	Show the department number, name, number of employees, and average salary of all departments, together with the names, salaries, and jobs of the employees working in each department.
-- select d.DEPARTMENT_ID,d.DEPARTMENT_NAME,COUNT(e.EMPLOYEE_ID),AVG(e.SALARY),e.LAST_NAME,e.SALARY,e.JOB_ID from departments d,employees e where d.DEPARTMENT_ID =e.DEPARTMENT_ID group by d.DEPARTMENT_NAME

-- 16.	Show the department number and the lowest salary of the department with the highest average 	salary.
-- select e.DEPARTMENT_ID,min(SALARY) from employees e where e.DEPARTMENT_ID =(select e.DEPARTMENT_ID from departments d,employees e where d.DEPARTMENT_ID =e.DEPARTMENT_ID group by d.DEPARTMENT_ID ORDER BY AVG(SALARY) desc LIMIT 1)

-- 17.Show the department numbers, names, and locations of the departments where no sales representatives work.
-- select * from departments where DEPARTMENT_NAME !='sales'

-- 18.	Show the department number, department name, and the number of employees working in each department that:
-- a. select d.DEPARTMENT_ID,d.DEPARTMENT_NAME,COUNT(e.EMPLOYEE_ID) from departments d,employees e  where d.DEPARTMENT_ID =e.DEPARTMENT_ID group by d.DEPARTMENT_ID ORDER BY COUNT(e.EMPLOYEE_ID) asc LIMIT 3
-- b.select d.DEPARTMENT_ID,d.DEPARTMENT_NAME,COUNT(e.EMPLOYEE_ID) from departments d,employees e  where d.DEPARTMENT_ID =e.DEPARTMENT_ID group by d.DEPARTMENT_ID ORDER BY COUNT(e.EMPLOYEE_ID) DESC LIMIT 1
-- c.select d.DEPARTMENT_ID,d.DEPARTMENT_NAME,COUNT(e.EMPLOYEE_ID) from departments d,employees e  where d.DEPARTMENT_ID =e.DEPARTMENT_ID group by d.DEPARTMENT_ID ORDER BY COUNT(e.EMPLOYEE_ID) asc LIMIT 1
    
-- 19.Show the employee number, last name, salary, department number, and the average salary in their department for all employees.
-- select e.EMPLOYEE_ID,e.LAST_NAME,e.DEPARTMENT_ID,AVG(SALARY) from employees e,departments d where d.DEPARTMENT_ID =e.DEPARTMENT_ID group by d.DEPARTMENT_ID 

-- 20.Show all employees who were hired on the day of the week on which the highest number of employees were hired.
-- select LAST_NAME,WEEKDAY(HIRE_DATE)
-- +1 as 'DAY' from employees where WEEKDAY(HIRE_DATE) = (select WEEKDAY(HIRE_DATE) from employees GROUP BY WEEKDAY(HIRE_DATE) ORDER BY COUNT(EMPLOYEE_ID) DESC LIMIT 1)

-- 21.Create an anniversary overview based on the hire date of the employees. Sort the anniversaries in ascending order.
-- select LAST_NAME, CONCAT(MONTHNAME(HIRE_DATE),' ',DAY(HIRE_DATE)) as BIRTHDAY from employees ORDER BY DATE_FORMAT(HIRE_DATE,'%m-%d') ASC

-- 22.Find the job that was filled in the first half of 1990 and the same job that was filled during the 		same period in 1991.
-- SELECT DISTINCT(e.JOB_ID) FROM employees e WHERE YEAR(e.HIRE_DATE) ="1990" OR YEAR(e.HIRE_DATE) ="1991"

-- 23.Write a compound query to produce a list of employees showing raise percentages, employee 		IDs, and old salary and new salary increase. Employees in departments 10, 50, and 110 are 		given a 5% raise, employees in department 60 are given a 10% raise, employees in 		departments 20 and 80 are given a  15% raise, and employees in department 90 are not given 		a raise.

-- 24.Alter the session to set the NLS_DATE_FORMAT to  DD-MON-YYYY HH24:MI:SS.
-- select DATE_FORMAT(HIRE_DATE,'%DD-%MON-%YYYY HH24:MI:SS') from employees;

-- 25.aSELECT TZ_OFFSET  ('Australia/Sydney') from employees; 

-- 26.Write a query to display the last names, month of the date of join, and hire date of those                 employees who have joined in the month of January, irrespective of the year of join.
-- 	select LAST_NAME,EXTRACT(MONTH FROM HIRE_DATE),HIRE_DATE from employees where MONTHNAME(HIRE_DATE)='January'

-- 27
-- SELECT   l.city,d.department_name, e.job_id, SUM(e.salary)
-- FROM     locations l,employees e,departments d
-- WHERE    d.location_id = l.location_id
-- AND      e.department_id = d.department_id
-- AND      e.department_id > 80
-- GROUP  BY CUBE(l.CITY,d.department_name, e.job_id);

-- 28.
-- SELECT department_id, job_id, manager_id,max(salary),min(salary)
-- FROM   employees
-- GROUP BY GROUPING SETS
-- ((department_id,job_id), (job_id,manager_id))

-- 29.Write a query to display the top three earners in the EMPLOYEES table. Display their last 	names and salaries.
-- select LAST_NAME,SALARY from employees ORDER BY SALARY DESC LIMIT 3

-- 30. Write a query to display the employee ID and last names of the employees who work in the 	state of California. 
-- select  e.EMPLOYEE_ID,e.LAST_NAME from departments d,employees e,locations l where e.DEPARTMENT_ID=d.DEPARTMENT_ID and d.LOCATION_ID=l.LOCATION_ID and l.STATE_PROVINCE='California'

-- 31.
-- DELETE FROM job_history JH
-- WHERE employee_id =
-- 	(SELECT employee_id 
-- 	 FROM employees E
-- 	 WHERE JH.employee_id = E.employee_id
--          AND START_DATE = (SELECT MIN(start_date)  
-- 	          FROM job_history JH
-- 	 	  WHERE JH.employee_id = E.employee_id)
-- 	 AND 3 >  (SELECT COUNT(*)  
-- 	          FROM job_history JH
-- 	 	  WHERE JH.employee_id = E.employee_id
-- 		  GROUP BY EMPLOYEE_ID
-- 		  HAVING COUNT(*) >= 2));

-- 32.ROLLBACK;

-- 33.Write a query to display the job IDs of those jobs whose maximum salary is above half the 	maximum salary in the whole company. Use the WITH clause to write this query. Name the 	query MAX_SAL_CALC.
-- WITH 
-- MAX_SAL_CALC AS (
--   SELECT job_title, MAX(salary) AS job_total
--   FROM employees, jobs
--   WHERE employees.job_id = jobs.job_id
--   GROUP BY job_title)
-- SELECT job_title, job_total
-- FROM MAX_SAL_CALC
-- WHERE job_total > (
--                     SELECT MAX(job_total) * 1/2
--                     FROM MAX_SAL_CALC)
-- ORDER BY job_total DESC;

-- 34 a.SELECT employee_id, last_name, hire_date, salary FROM   employees WHERE  manager_id = (SELECT employee_i FROM   employees WHERE last_name = 'De Haan');
-- 34 b.SELECT employee_id, last_name, hire_date, salary FROM   employees WHERE  employee_id != 102 CONNECT BY manager_id = PRIOR employee_id START WITH employee_id = 102;

-- 35.
-- SELECT employee_id, manager_id, level, last_name
-- FROM   employees
-- WHERE LEVEL = 3
-- CONNECT BY manager_id = PRIOR employee_id
-- START WITH employee_id= 102;

-- 36
-- SELECT  employee_id, manager_id, LEVEL,
-- LPAD(last_name, LENGTH(last_name)+(LEVEL*2)-2,'_')  LAST_NAME        
-- FROM    employees
-- CONNECT BY employee_id = PRIOR manager_id;
-- COLUMN name CLEAR

-- 37
-- INSERT ALL
-- WHEN SAL < 5000 THEN
-- INTO  special_sal VALUES (EMPID, SAL)
-- ELSE
-- INTO sal_history VALUES(EMPID,HIREDATE,SAL)
-- INTO mgr_history VALUES(EMPID,MGR,SAL) SELECT employee_id EMPID, hire_date HIREDATE,salary SAL, manager_id MGR FROM employees WHERE employee_id >=200;

-- 38.SELECT * FROM special_sal;
-- SELECT * FROM sal_history;
-- SELECT * FROM mgr_history;

-- 39.CREATE TABLE LOCATIONS_NAMED_INDEX (location_id NUMBER(4) PRIMARY KEY USING INDEX (CREATE INDEX locations_pk_idx ON LOCATIONS_NAMED_INDEX(location_id)), location_name VARCHAR2(20));

-- 40. SELECT INDEX_NAME, TABLE_NAME FROM USER_INDEXES  WHERE TABLE_NAME = 'LOCATIONS_NAMED_INDEX';    

-- 41.SET HEADING OFF ECHO OFF FEEDBACK OFF SET PAGESIZE 0 SELECT   'DROP ' || object_type || ' ' || object_name || ';' FROM     user_objects ORDER BY object_type