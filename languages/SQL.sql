--############### command line ###############--
show databases
drop database NAME
create database NAME
use DATABASE_NAME

show tables
drop table NAME
describe table NAME

source xxx.sql

--############### create table ###############--
create table department(
	dept_name varchar(20),
	building  varchar(15),
	budget    numeric(12, 2),
	primary key(dept_name)
);

create table course(
	course_id varchar(7),
	title 		varchar(50),
	dept_name varchar(20),
	credits 	numeric(2, 0),
	primary key(course_id),
	foreign key(dept_name) references department
);

create table instructor(
	ID 				varchar(5),
	name 			varchar(20) not null,
	dept_name varchar(20),
	salary 		numeric(8, 2),
	primary key(ID),
	foreign key(dept_name) references department
);

create table section(
	course_id 	 varchar(8),
	sec_id 			 varchar(8),
	semester 		 varchar(6),
	year 				 numeric(4, 0),
	building		 varchar(15),
	room_number  varchar(7),
	time_slot_id varchar(4),
	primary key(course_id, sec_id, semester, year),
	foreign key(course_id) references course
);

create table teaches(
	ID 				varchar(5),
	course_id varchar(8),
	sec_id 		varchar(8),
	semester  varchar(6),
	year 		  numeric(4, 0),
	primary key(ID, course_id, sec_id, semester, year),
	foreign key(ID) references instructor 
);

--############### Basic select ###############--
select distinct dept_name			-- remove duplicates
from instructor;

select all dept_name		-- all means duplicates are not removed
from instructor;

select salary * 1.1			-- may contain arithmetic expression
from instructor;

select name 
from instructor
where dept_name = 'Comp.Sci' and salary > 70000;

-- retrive the names of all instructors, along with their department names and department building name
select name, instructor.dept_name, building
from instructor, department
where instructor.dept_name = department.dept_name;

select instructor.*
from instructor, teaches
where instructor.ID = teaches.ID

--############### join ###############--
-- for all instructors who has taught a course, find their names and the course ID and all courses they taought
select name, course_id
from instructor, teaches
where instructor.ID = teaches.ID;
-- same as --
select name, course_id
from instructor natural join teaches;

-- list the instructors and the course titles they taught
select name, title
from instructor natural join teaches, course 	-- instructor natural join teaches is computed first, then take the cartesian product of the result and course
where teaches.course_id = course.course_id;
-- this one, however, is different, because instructor natural join teaches => (ID, name, dept_name, salary, course_id, sec_id), while course is (course_id, title, dept_name, credits). So the result will require that (course_id and dept_name) to be the same, not only course_id to be the same. So the result will omit a instructor teaching class not in his own department.
select name, title
from instructor natural join teaches natural join course;
-- this one is the same, we can specify which attribute to use in join, using r1 join r2 using(A1, A2, ...)
select name, title
from (instructor natural join teaches) join course using(course_id);

--############### renaming ###############--
select name as instructor_name, course_id
from instructor, teaches
where instructor.ID = teaches.ID;

select T.name, S.course_id
from instructor as T, teaches as S
where T.ID = S.ID;

--############### string operations ###############--
-- % matches any substring
-- _ matcehs any character
select dept_name
from department
where building like '%Watson%';

--############### order ###############--
select name
from instructor
where dept_name = 'Physics'
order by name;		-- by default order by clause is in ascending order

select *
from instructor
order by salary desc, name asc;	 -- if some instructors have same salary, order by name

--############### additional operation for where ###############--
select name
from instructor
where salary between 90000 and 10000;

select name, course_id
from instructor, teaches
where (instructor.ID, dept_name) = (teaches.ID, 'Biology');

--############### set operations ###############--
-- find all course taught either in Fall 2009 or Spring 2010
(select course_id
 from section
 where semester = 'Fall' and year = 2009)
union [all] -- union operation automatically eliminates duplicates, if want to retain all duplicates, use union all
(select course_id
 from section
 where semester = 'Spring' and year = 2010);

-- find all course taught in both Fall 2009 and Spring 2010
(select course_id
 from section
 where semester = 'Fall' and year = 2009)
intersect [all] -- intersect operation automatically eliminates duplicates, if want to retain all duplicates, use intersect all
(select course_id
 from section
 where semester = 'Spring' and year = 2010);

-- find all course taught in Fall 2009 but not in Spring 2010
(select course_id
 from section
 where semester = 'Fall' and year = 2009)
except [all] -- except operation automatically eliminates duplicates, if want to retain all duplicates, use except all
(select course_id
 from section
 where semester = 'Spring' and year = 2010);

--############### null values ###############--
-- SQL treat as unknown the reuslt of any comparison involving a null value. Ex: 1 < null
-- if the where clause prediate evaluates to either false or unknown for a tuple, that tuple will not be added to the result.
true and unknown => unknown
false and unknown => false
unknown and unknown => unknown

true or unknown => true
false or unknown => unknown
unknown or unknown => unknown

not unknown => unknown

-- find all instructors with null values for salary
select name
from instructor
where salary is null -- some sql can also test is unknown / is not unknown

--############### Aggregate functions ###############--
-- avg, min, max, sum, count
select avg(salary) as avg_salary
from instructor
where dept_name = 'Comp.Sci';

select count(distinct ID)
from teaches
where semester = 'Spring' and year = 2010

-- find the number of tuples in the course relation
select count(*)
from course;

--############### Aggregation with grouping ###############--
-- need to ensure that the only attributes that appear in the select statement without being aggregated are those that are present in the group by clause.

-- find average salary in each department
select dept_name, avg(salary) as avg_salary
from instructor
group by dept_name;

-- when applying condition to a group, use 'having'
-- find departments that has average salary of the instructors more than 42000
select dept_name, avg(salary) as avg_salary
from instructor
group by dept_name
having avg(salary) > 42000;

-- for each course section offered in 2009, find the average total credits of all students enrolled in the section, if the section had at least 5 students
select course_id, semester, year, sec_id avg(tot_cred)	-- 5
from takes natural join student   											-- 1
where year = 2009                 											-- 2
group by course_id, semester, year, sec_id 							-- 3
having count(ID) >= 5; 																	-- 4

-- all aggregate functions except count(*) ignore null values in their input collection. for empty collection, count = 0, all other aggregate operations return null.

--############### Nested Subqueries ###############--
-- find the courses taught in both quarters
select distinct course_id
from section
where semester = 'Fall' and year = 2009 and
	course_id [not] in (select course_id
 								from section
 								where semester = 'Spring' and year = 2010);

-- in and not in can also be used in enumerated sets
select distinct name
from instructor
where name [not] in ('Mozart', 'Einstein');

-- find number of students who have taken course sections taught by the instructor with ID 10101
select count(distinct ID)
from takes
where (course_id, sec_id, semester, year) in (select course_id, sec_id, semester, year
																							from teaches
																							where teaches.ID = 10101);

--############### Set Comparison ###############--
-- greater than at least one
select name
from instructor
where salary > some (select salary
										 from instructor
										 where dept_name = 'Biology');
-- also allows <, <=, >, >=, =, <> some
-- '= some' equal to 'in', '<> some' not equal to 'not in'

-- greater than all
select name
from instructor
where salary > all (select salary
										from instructor
										where dept_name = 'Biology');

-- find the department that has teh highest salary
select dept_name
from instructor
group by dept_name
having avg(salary) >= all(select avg(salary)
													from instructor
													group by dept_name);

--############### Test for empty relations ###############--
-- find all courses taught in both quartes
select course_id
from section as S
where semester = 'Fall' and year = 2009 and 
			exists (select *
							from section as T
							where semester = 'Spring' and year = 2010 and
										T.course_id = S.course_id);
-- a correlation name from outer query can be used in a subquery in the where clause. Asubquery that uses a correlation name from an outer query is called a correlated subquery.

-- relation A contains relation B => not exist (B except A)
-- find and students who have taken all courses offered in the Biology department
select distinct S.ID, S.name
from student as S
where not exists ((select course_id             -- all classes offered
									 from course
									 where dept_name = 'Biology')
									 except
									 (select T.course_id					-- all classes taken
									 	from takes as T
									 	where S.ID = T.ID));
-- all classes taken 'contains' all classes offered => not exists (offered except taken)

--############### Test for Duplicate Tuples ###############--
-- 'unique' returns true is the argument subquery contains no duplicate tuples.
-- note that unique(empty) = true

-- find all courses offered at most [least] once in 2009 
select T.course_id
from course as T
where [not] unique (select R.course_id
							from sections as R
							where T.course_id = R.course_id and
										R.year = 2009);
-- same as 
select T.course_id
from course as T
where 1 <= (select count(R.course_id)
						from sections as R
						where T.course_id = R.course_id and
										R.year = 2009);

--############### Subqueries in the from clause ###############--
-- find the average instructor salaries of those departments where the average salary is greater than 42000
select dept_name, avg_salary
from (select dept_name, avg(salary) as avg_salary
			from instructor
			group by dept_name)
where avg_salary > 42000;
--same as
select dept_name, avg_salary
from (select dept_name, avg(salary)
			from instructor
			group by dept_name)
			as dept_avg(dept_name, avg_salary)
where avg_salary > 42000;

-- find the maximun of the total salary of all deparment
select max(tot_salary)
from (select dept_name, sum(salary)
			from instructor
			group by dept_name) as dept_total(dept_name, tot_salary);

--############### The with clause ###############--
-- the 'with' clause provides a way to define temoporary relation
-- find the department with the maximum budget
with max_budget(value) as 
		(select max(budget)
		 from department)
select budget
from department, max_budget
where deparment.budget = max_budget.value;

-- find all departments where the total salary is greater than the average of the total salary at all departments
with dept_total(dept_name, value) as 
		 (select dept_name, sum(salary)
		 	from instructor
		 	group by dept_name),
     dept_total_avg(avg) as
     (select avg(value)
     	from dept_total)
select dept_name
from dept_total, dept_total_avg
where dept_total.value >= dept_total_avg.value;

--############### Scalar Subqueries ###############--
-- list all departments along with the number of instructors in each department
select dept_name, (select count(*)
									 from instructor
									 where department.dept_name = instructor.dept_name)
									as num_instructors
from deparment;

--############### deletion ###############--
drop table r;		-- deletes not only tuples of r, but the schema for r
delete from r;	-- retains relation r, but deletes all tuples in r
alter table r add A D;  -- A: name of the attribute, D: type of attribute
alter table drop A;  -- A: name of the attribute

delete from instructor
where dept_name = 'Finance';

delete from instructor
where salary between 13000 and 15000;

delete from instructor
where dept_name in (select dept_name
										from department
										where building = 'Watson');

delete from instructor
where salary < (select avg(salary)
						    from instructor);

--############### insertion ###############--
insert into course
	values('CS437', 'Database', 'Comp. Sci.', 4)
-- same as 
insert into course(course_id, title, dept_name, credits)
	values('CS437', 'Database', 'Comp. Sci.', 4)
-- same as
insert into course(title, course_id, credits, dept_name)
	values('Database', 'CS437', 4, 'Comp. Sci.')

-- insert tuples on the result of a query
-- promote some qualified studnet to instructor
insert into instructor
	select ID, name, dept_name, 18000 -- 18000 is the fixed salary
	from student
	where dept_name = 'Music' and tot_cred > 144;

insert into student
	values('3003', 'Green', 'Finace', null);

--############### update ###############--
update instructor
set salary = salary * 1.05;

update instructor
set salary = salary * 1.05
where salary < 70000;

update instructor
set salary = salary * 1.05
where salary < (select avg(salary)
								from instructor);

update instructor
set salary = salary * 1.03
where salary > 100000;
update instructor   		-- cannot reverse these two orders! otherwise low salary instructors might update twice
set salary = salary * 1.05
where salary <= 100000;
-- same as 
update instructor
set salary = case
								when salary <= 100000 then salary * 1.05
								else salary * 1.03
						 end

-- scalar subqueries for update
-- set each student's tot_credit to the classes he finished with grade not 'F'
update student S
set tot_cred = (
	select sum(credits)
	from takes natural join course
	where S.ID = takes.ID and 
				takes.grade <> 'F' and
				takes.grade is not null
);

--############### example 1 ###############--
Customer(customer-name, street, city)
Branch(branch-name, city)
Account(customer-name, branch-name, account-number)

-- Find the names of all customers who have an account in the ‘Region12’ branch
select distinct customer-name
from Account
where branch-name = 'Region12'

-- Find the names of all customers who have an account in a branch NOT located in the same city that they live in.
select distinct A.customer-name
from Account A, Branch B, Customer C
where A.customer-name = C.customer-name and 
			A.branch-name = B.branch-name and 
			B.city <> C.city
-- same as
select distinct A.customer-name
from Account A
	join Branch B on A.branch-name = B.branch-name
	join Customer C on A.customer-name = C.customer-name
where B.city <> C.city
-- same as
select C.customer_name from Customer C
where EXISTS (
	select *
  from Account A, Branch B
  where C.customer_name = A.customer_name and 
  			B.branch_name = A.branch_name and 
  			C.city != B.city
)

-- Find the branches that do not have any accounts.
select distinct branch-name
from Branch
where branch-name NOT IN (
	select branch-name
	from Account
)
-- same as 
select branch-name
from Branch
EXCEPT
select branch-name
from Account
-- same as
select branch_name
from (
	select B.branch_name, count(account_number) as numAccounts
  from Branch B left join Account A on A.branch_name = B.branch_name
  group by B.branch_name
) as BranchAccounts
where BranchAccounts.numAccounts = 0

-- Find the customer names who do not have any account in the ‘Region12’ branch.
select customer-name
from Branch
EXCEPT
select customer-name
from Account
where branch-name = 'Region12'
-- same as
select distinct branch-name
from Branch
where branch-name NOT IN (
	select customer-name
	from Account
	where branch-name = 'Region12'
)
-- same as
select R12_AccountCounts.customer_name 
from (
	select A.customer_name, count(*) AS numAccounts
	from Account A left join (
		select * from Account 
		where branch_name = "Region12"
	) AS R12_Accounts 
	on A.customer_name = R12_Accounts.customer_name
  group by A.customer_name
) AS R12_AccountCounts
where R12_AccountCounts.numAccounts = 0

-- Find the customer names who have accounts in all the branches located in ‘Los Angeles’.
select customer-name
from Customer
EXCEPT
select customer-name
from Branch B, Customer C
where B.city = 'Los Angeles' and 
			(C.customer-name, B.branch-name) NOT IN (
				select customer-name, branch-name
				from Account
			)
-- same as
select distinct customer-name
from Customer
where customer-name NOT IN (
	select customer-name
	from Branch B, Customer C
	where B.city = 'Los Angeles' and 
				(C.customer-name, B.branch-name) NOT IN (
					select customer-name, branch-name
					from Account
				) 
)	
-- same as		
select customer-name
from Account AS A, Branch AS B
where A.branch-name = B.branch-name and 
			B.city = 'Los Angeles'
group by customer-name
having count(distinct B.branch-name) = (
	select count(distinct branch-name)
	from Branch
	where city='Los Angeles'
)
-- same as
select customer_name
from (
	select customer_name, count(*) AS numAccounts
	from (
		select A.customer_name, A.branch_name
 		from Account A, Branch B
 		where A.branch_name = B.branch_name and city = "Los Angeles"
 		/* group by to merge cases when one has multiple accounts in a branch */
 		group by A.customer_name, A.branch_name
 	) AS T
	group by customer_name
) AS LA
where LA.numAccounts =
	(select count(*) from Branch where city="Los Angeles")

-- Find the customer names who have only one account.
select customer-name
from Customer
EXCEPT
select A.customer-name
from Account A, Account B
where (A.branch-name <> B.branch-name OR 
			 A.account-number <> B.account-number) and 
			 A.customer-name = B.customer-name
-- same as
select distinct customer-name
from Customer
where customer-name NOT IN (
	select A.customer-name
	from Account A, Account B
	where (A.branch-name <> B.branch-name OR 
				 A.account-number <> B.account-number) and 
				 A.customer-name = B.customer-name
)
--same as
select customer-name
from Account
group by customer-name
having count(distinct account-number) = 1

-- Student(sid,​ ​GPA)​. finds the ids of the students with the lowest GPA
select sid
from Student
EXCEPT
select A.sid
from Student A, Student B
where A.GPA > B.GPA and 
      A.sid <> B.sid
-- same as
select sid
from Student
where GPA = (select MIN(GPA) from Student )

--############### example 2 ###############--
Employee(person-name, age, street, city)
Work(person-name, company-name, salary)
Company(company-name, city)
Manage(person-name, manager-name)

-- find the names of persons who work in one or more companies where they make a salary that is less than $22,000
select person-name from Work where Work.salary < 22000

-- find the names of such companies that all of their employees have salaries higher than $100,000
SELECT company-name 
FROM Company C
WHERE 100000 < ALL
		(SELECT salary FROM Work W
		  WHERE C.company-name = W.company-name)

-- Write an SQL query to find the names of persons who work in one or more companies and make less than $22,000 in the majority (i.e., 50% or more) of the companies they work for.
select Total.person-name
from (select person-name, count(*) as cnt from Work group by person-name) as Total,
		 (select person-name, count(*) as cnt from Work where Work.salary < 22000 group by person-name) as Less
where Total.person-name = Less.person-name and Less.cnt >= 0.5 * Total.cnt

-- Find the name(s) of the employee(s) whose total salary is higher than those of all employees living in Barstow.
select person-name from Work
group by person-name
having SUM(salary) > ALL
(select SUM(salary) from Work, Employee
where Work.person-name=Employee.person-name and city=’Barstow’
group by Work.person-name)
-- same as
select person-name from Employee E
where NOT EXISTS (
	select Work.person-name from Work, Employee
	where Work.person-name = Employee.person-name and city=’Barstow’
	group by Work.person-name 
	having SUM(salary) >= (select SUM(salary) from Work W
											   where W.person-name=E.person-name
												)
)

-- Find the name(s) of the manager(s) whose total salary is higher than that of at least one employee that they manage.
select manager-name
from Manage M, (select person-name, SUM(salary) total-salary
								from Work group by person-name) S1
where M.manager-name = S1.person-name and
S1.total-salary > SOME (select total-salary
												from (select person-name, SUM(salary) total-salary
															from Work group by person-name) S2
												where S2.person-name = M.person-name)
-- same as
select manager-name
from Manage M
where EXISTS (
	select *
	from (select person-name, SUM(salary) total-salary
				from Work group by person-name) S1,
			 (select person-name, SUM(salary) total-salary
				from Work group by person-name) S2
	where M.manager-name = S1.person-name and
				M.person-name = S2.person-name and
				S1.total-salary > S2.total-salary
)

--############### example 3 ###############--
MovieStar(name, address, gender)
MovieExec(name, address, company, netWorth)

-- find the names and addresses of all female movie stars who are also movie executives with a net worth over $2,000,000 
select name, address from MovieStar where gender = ’F’ 
INTERSECT 
select name, address from MovieExec where netWorth > 2000000
-- same as
select name, address from MovieStar 
where gender = ’F’ and 
			(name, address) in (select name, address from MovieExec where netWorth > 2000000)

-- find the movie stars who are not movie executives
select name from MovieStar EXCEPT select name from MovieExec
-- same as
select name from MovieStar where name not in (select name from MovieExec)

--############### example 4 ###############--
ComputerProduct(manufacturer, model, price)
Desktop(model, speed, ram, hdd)
Laptop(model, speed, ram, hdd, weight)

-- Find the average speed of all desktop computers.
select AVG(speed) from Desktop

-- Find the average price of all laptops with weight below 2kg.
select AVG(price) from ComputerProduct CP, Laptop L where CP.model = L.model and weight <= 2

-- Find the average price of PC’s and laptops made by “Dell.”
select AVG(price) from ComputerProduct where manufacturer = ‘DELL’

-- For each different CPU speed, find the average price of a laptop.
select AVG(price) from Laptop group by speed

-- Find the manufacturers that make at least three different computer models.
select manufacturer from ComputerProduct group by manufacturer having COUNT(model) >= 3

-- Using two INSERT statements, insert a desktop computer manufactured by HP, with model number 1200, price $1000, speed 1.2Ghz, 256MB RAM, and an 80GB hard drive.
INSERT INTO ComputerProduct VALUES (‘HP’, 1200, 1000); 
INSERT INTO Desktop VALUES (1200, ‘1.2GHz’, ‘256MB’, ‘80GB’);

-- Using two DELETE statements, delete all desktops manufactured by IBM with price below $1000. Be careful with the order of your two DELETE statements.
DELETE from Desktop where model IN (select model from ComputerProduct where manufacturer = ‘IBM’ and price < 1000);
DELETE from ComputerProduct where manufacturer = ‘IBM’ and price < 1000 and model NOT IN (select model from Laptop);

-- For each laptop made by Gateway, add one kilogram to the weight.
UPDATE Laptop SET weight = weight + 1 where model IN (select model from ComputerProduct where manufacturer = ‘Gateway’);

--############### example 5 ###############--
Enroll(sid, dept, cnum, sec)

-- find the students who are only enrolled in the CS classes.
select E1.sid
from Enroll AS E1
where E1.sid NOT IN (select Sid from Enroll where dept <> 'CS')

-- Write an SQL query to find the students who are enrolled in all the CS classes offered this quarter.
select E0.sid 
from Enroll AS E0
where E0.sid NOT IN (
	select E1.sid from Enroll AS E1
 	where (E1.Stid, E1.dept, E1.cnum) NOT IN (
 		select E1.Stid, 'CS', E2.cnum
 		from Enroll AS E2 where E2.dept='CS'
 	)
)
-- same as
select E1.sid
from Enroll AS E1
where E1.dept ='CS'
group by E1.sid
having count(*) = (select count(*) from Enroll where dept= 'CS')

--############### Spring 2018's example ###############--
-- table
INSERT INTO relation VALUES (val1, val2, ..., valn)

INSERT INTO relation (col1name, col2name, ..., colnname)
VALUES (val1, val2, ..., valn);

UPDATE extended_roster
SET midterm_grade = 81
WHERE uid = '001122334';

UPDATE extended_roster SET points = points + 2;

-- sql
SELECT DISTINCT instructor
FROM instructor _ course _nj;

SELECT 
	video _id, 
	title, likes / dislikes AS ratio, 
	views / 1000000 AS millions _views, 
	likes / (likes + dislikes)
FROM youtube _ video;

SELECT video _id
WHERE views BETWEEN 500000 AND 1000000;

-- order by and limit
select uid, last_name, first_name
from roster
order by last_name, first_name
limit 2	-- take only 2

-- aggregation
select 
	avg(points) as average,
	min(points) as minumum,
	max(points) as maximum,
	count(points) as num_of_exames
from midterm_grades;

-- stats by each TA, in decensing order
-- use having for aggreagation, not where
-- remember this order!
select 
	ta,
	avg(points) as average,
	min(points) as minumum,
	max(points) as maximum,
	count(points) as num_of_exames
from midterm_grades
where lecture_attended > 0
group by ta
having average < 80
order by average desc;

-- Find students who take two or more classes
SELECT sid, count(*) as c
FROM Enroll E
GROUP BY sid
HAVING c >= 2

-- join
SELECT instructor_name, course_name
FROM instructors
	NATURAL JOIN courses
	NATURAL JOIN course _ offerings;
--same as
SELECT instructor_name, course_name
FROM instructors
	inner JOIN courses on instructors.id = courses.id
	inner JOIN course _ offerings on courses.course = course_offering.course;
-- same as 
SELECT instructor_name, course_name
FROM instructors ins,
	 courses crs,
	 course_offering offerings
where ins.id = crs.id 
	and crs.course = offerings.course;

-- nested queries
-- compute avg trip length
select avg(end_time - start_time) / 60 as avg_trip_length
from (
	select 
		s.time as start_time,
		e.time as end_time
	from start_table s 
	left join end_table e
	on s.trip_id = e.trip_id
	and s.user_id = e.user_id
) start_end_time

-- find users that has trip length < 7 minutes
select 
	user_id,
	avg_trip_length
from (
	select 
	user_id, 
	avg(end_time - start_time) / 60 as avg_trip_length
	from (
		select 
			s.user_id as user_id,
			s.time as start_time,
			e.time as end_time
		from start_table s 
		left join end_table e
		on s.trip_id = e.trip_id
		and s.user_id = e.user_id
	) start_end_time
	group by user_id
) user_and_his_avg_trip_length
where avg_trip_length < 7;

-- scalar subquery
select uid, points
from midterm_grades
where points > (
	select avg(points) + std(points)
	from midterm_grades
)

-- condition
SELECT
    uid,
    UPPER(CONCAT(last, ", ", first, IF(middle IS NOT NULL, CONCAT(" ", middle), ""))) AS name,
    CASE class_level
        WHEN "USR" THEN "Senior"
        WHEN "UJR" THEN "Junior"
        WHEN "USO" THEN "Sophomore"
        WHEN "UFR" THEN "Freshman"
        WHEN "GD1" THEN "PhD Student"
        WHEN "GD2" THEN "PhD Student, Advanced to Candidacy"
        WHEN "GMT" THEN "Masters Student"
        WHEN "BOSS" THEN "Chancellor Bossman"
        ELSE "Unknown"
    END AS class_level,
    NULLIF(major, "Undeclared") AS major,
    IFNULL(midterm_score, 0) AS midterm_score
FROM extended_roster;

-- the CIDs of courses that have no registered students
SELECT c.cid FROM Courses c 
WHERE NOT EXISTS 
(SELECT cid FROM Registered r WHERE r.cid = c.cid); 

SELECT DISTINCT profname FROM Courses
--same as 
SELECT profname FROM Courses GROUP BY profname; 
-- same as
SELECT profname FROM Courses 
UNION 
SELECT profname FROM Courses; 
 
-- name and SID of every student enrolled in the class ‘CS186’ whose age is greater than the average age of all the students enrolled in that class
select S.name, S.sid
from Student S, Registered R
where S.sid = R.sid 
  and R.cid = 'CS186' 
  and S.age > (
  	select avg(S2.age)
  	from Stundet S2, Registered R2
  	where S1.sid = R2.sid and R2.cid = 'CS186'
  )

-- homework
CREATE TABLE scooter (
	scooter_id SMALLINT NOT NULL [AUTO_INCREMENT],
	status ENUM('online', 'offline', 'lost/stolen') DEFAULT 'offline',
	home TINYINT,
	PRIMARY KEY (scooter_id)
);

CREATE TABLE user (
	user_id MEDIUMINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	ccnumber BIGINT,
	expiration TIMESTAMP,
	email VARCHAR(255) NOT NULL
);

CREATE TABLE trip (
	trip_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	user_id MEDIUMINT,
	scooter_id SMALLINT NOT NULL,
	trip_start_time TIMESTAMP NOT NULL,
	trip_end_time TIMESTAMP NOT NULL,
	trip_start_lat DECIMAL(8, 6) NOT NULL,
	trip_start_lon DECIMAL(8, 6) NOT NULL,
	trip_end_lat DECIMAL(8, 6) NOT NULL,
	trip_end_lon DECIMAL(8, 6) NOT NULL,
	FOREIGN KEY (user_id) REFERENCES user(user_id),
	FOREIGN KEY (scooter_id) REFERENCES scooter(scooter_id)
);

-- compute the total throughput (passengers, or number of trips) by time of day forthe year of 2017. The result should contain only the hour of day, named hour, and the number of trips named trips.
SELECT HOUR(DateTime) AS hour, SUM(Throughput) AS trips
FROM rides2017
GROUP BY hour;

-- Write a query that computes the elapsed time of each trip. If something happened and a trip end was not recorded, the elapsed time shall be 24 hours.
SELECT l.trip_id, l.user_id, IFNULL(CEILING(TIMESTAMPDIFF(SECOND, l.time, r.time) / 60), 1440) AS trip_length
FROM trip_starts l
LEFT JOIN trip_ends r
ON l.trip_id = r.trip_id and l.user_id = r.user_id;

--  Write a query that computes the charge to the user for each trip. $1 flat rate per trip plus 15 cents per minute.
SELECT trip_id, user_id, trip_length * 0.15 + 1.00 AS trip_charge
FROM (
SELECT
	[previous table]
) durations;

-- lists the one pair of station codes that had the largest throughput on the weekdays in 2017.
SELECT Origin, Destination, SUM(Throughput) AS total
FROM rides2017
WHERE DAYOFWEEK(DateTime) BETWEEN 2 AND 6
GROUP BY Origin, Destination
ORDER BY total DESC
LIMIT 1;

-- returns the 5 destinations that saw the highest average throughput on Mondays between 7am and 10am, and rank them from highest to lowest. Return the destinations and their averages.
SELECT Destination, AVG(Throughput) AS avg_trips
FROM rides2017
WHERE DAYOFWEEK(DateTime) = 2 AND HOUR(DateTime) >= 7 AND HOUR(DateTime) < 10
GROUP BY Destination
ORDER BY avg_trips DESC
LIMIT 5;

--  maximum hourly throughput across all one-hour periods in the year is greater than 100 times the average hourly throughput across all one-hour periods in the year
SELECT
	Origin,
	MAX(Throughput) AS max_throughput,
	AVG(Throughput) AS avg_throughput
FROM rides2017
GROUP BY Origin 
HAVING max_throughput > 100 * avg_throughput;
-- same as
SELECT Origin
FROM rides2017
GROUP BY Origin
HAVING MAX(Throughput) > 100 * AVG(Throughput);

-- if use avg of all origin
SELECT Origin
FROM (
	SELECT Origin, SUM(Throughput) AS rides_by_origin_time
	FROM rides2017
	GROUP BY Origin, DateTime
) sums
GROUP BY Origin
HAVING MAX(rides_by_origin_time) > 100 * AVG(rides_by_origin_time);


-- return highways that were closed due to snow at any point of the year, or were closed for the winter. Order them by highway and area and give us the top 20 results, both columns in descending order
SELECT DISTINCT highway, area AS stretch
FROM caltrans
WHERE text like '%CLOSED%' AND ( text LIKE '%FOR THE WINTER%' OR text LIKE '%DUE TO SNOW%') 
ORDER BY highway DESC, area DESC
LIMIT 20;

-- Report the highway, area/stretch, and the percentage of days it was closed in descending order by percentage, and only gives us the 5 highest percentages and the highways and areas they belong to
SELECT highway, area,
COUNT(DISTINCT DAYOFYEAR(reported)) * 100 / 365 AS percentage_of_days_closed_365,
COUNT(DISTINCT DAYOFYEAR(reported)) * 100 / 353 AS percentage_of_days_closed_353
FROM caltrans
WHERE text LIKE '%CLOSED%DUE TO SNOW%' OR text LIKE '%CLOSED%FOR THE WINTER%'
GROUP BY highway, area
ORDER BY percentage_of_days_closed_365 DESC;






