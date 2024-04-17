select job_title_short as title,job_posted_date::date as date_of_post
from job_postings_fact 
limit 10;
-- here is in the case that we don't need the time

-- or 

select job_title_short as title, date(job_posted_date) date_of_post
from job_postings_fact 
limit 10; 

-- at time zone (To convert time stamps between different time zones)


select job_title_short as title, job_posted_date::date as date_of_post
from job_postings_fact 
limit 10;

/*
select column_name AT TIME ZONE 'UTC' AT TIME ZONE 'EST'
FROM TABLE_NAME;

[It is UTC by default that is used. here we are first using the AT TIME ZONE 'UTC' to specify that we want to 
work with time zone, then the second AT TIME ZONE 'EST' we then specify 
, here what reagion exactly, here it is EST]

*/


-- UTC TIME CONVERSION USING AT TIME ZONE

select 
    job_title_short as title, 
    job_posted_date at time zone 'utc' at time zone 'est' as date_of_post
from job_postings_fact 
limit 10;
--[ herem EST is 5 prior time to UTC
--  if it is UTC 17:30 IT WILL BE 12:30 EST, 5 hours before UTC]

-- appart from EST, there are dozens of time zones in the postgress documentation website, you can check
-- them when you get time [postgresql.org/docs/7.2/timezones.html]. 


-- EXTRACT 
/*
this is used to extract month, day or year form the time zone, the syntax is:
*/

select 
    job_title_short as title, 
    EXTRACT(month from job_posted_date) as month_date_of_post
from job_postings_fact 
limit 10;

-- same thing for days 

select 
    job_title_short as title, 
    EXTRACT(day from job_posted_date) as day_date_of_post
from job_postings_fact 
limit 10;

-- or mixed

select 
    job_title_short as title, 
    EXTRACT(month from job_posted_date) as month_date_of_post,
    EXTRACT(year from job_posted_date) as year_date_of_post
from job_postings_fact 
limit 100;


select 
    count(job_id) as job_posting_per_month, 
    EXTRACT(month from job_posted_date) as month_date_of_post
from 
    job_postings_fact
where 
    job_title_short ='Data Analyst'
group by 
    EXTRACT(month from job_posted_date) 
order by 
    job_posting_per_month desc
;

-- WE ARE NOW USING THE SKILLS FROM PREVIOUS LECTURE 
-- THIS TO CREATE TABLES FOR EACH OF THE MONTH 
-- (using the extract to select specific months 
--  to filter with in the WHERE clause)

-- for january 

create table january_posting_jobs as
    select *
    from job_postings_fact
    where extract(month from job_posted_date) = 1;

-- for february

create table february_posting_jobs as
    select *
    from job_postings_fact
    where extract(month from job_posted_date) = 2;

-- for march 

create table march_posting_jobs as
    select *
    from job_postings_fact
    where extract(month from job_posted_date) = 3;

-- THIS IS A BRAND NEW WAY TO CREATE TABLES
-- (here we are creating tables which will contain
--  data that we are getting from another bigger table
--  here we have stored data based on months 
--  into different tables)

-- Also, when you feel like you will do very repetitive
-- work, you can copy the first statement for january, 
-- and ask to chatGPT to do it for all the months of the year
-- THIS means you can USE AI to speed the work !!!

-- CASE Expression
/*
this is very similar to an IF statement. (and you know what it means)
commonly it is used in the SELECT statement, but ut can also be used
in WHERE, GROUP BY.

SYNTAX:

select 
    case 
        when column_name = 'value1' then 'description of value 1'
        when column_name = 'value2' then 'description of value 2'
        else 'description of other'
    end as column_description 
from 
    table_name;

*/

select job_title_short, job_location 
from job_postings_fact
limit 500;


-- the case usage on our data (we are categorizing the job posting locations)

select 
    case 
        when job_location = 'Anywhere' then 'Remote'
        when job_location = 'New York, NY' then 'local'
        else 'Onsite'
    end as location_category 
    ,count(job_id) as jobs_at_location
from 
    job_postings_fact
where job_title_short ='Data Analyst'
group by location_category
order by jobs_at_location desc 
limit 5000;


-- OR (using the entire case column statement)

select
    case 
        when job_location = 'Anywhere' then 'Remote'
        when job_location = 'New York, NY' then 'local'
        else 'Onsite'
    end as location_category
    ,count(job_id) as jobs_at_location
from 
    job_postings_fact
group by 
    case 
        when job_location = 'Anywhere' then 'Remote'
        when job_location = 'New York, NY' then 'local'
        else 'Onsite'
    end
;

--[ this cide is, let us say we want to know how 
-- many jobs I can apply to localy and also remotelly.]

-- CTEs and SUBQUERIES(query innside another query)
--(here we are also using some logic of Temporary TABLES)

-- Let us say we want to create a temorary table of january jobs:
--(using a subquery)

SELECT * 
from (
    select * 
    from job_postings_fact
    where extract(month from job_posted_date)=1
) as january_jobs
limit 15000;

--[here, the newly creted table - 
-- from the subquery we are seeing, is the temporary table
-- here we are creating a temporary table to select all
-- the jobs_postings for January only]

-- WE CAN DO THE SAME BY USING CTEs.

-- CTEs (Common Table Expression) 

-- they define a temporary 
-- result set that you can 
-- reference with a SELECT,
-- INSERT, UPDATE or DELETE statement defined with "WITH"

with january_jobs as 
(
    select *
    from job_postings_fact
    where EXTRACT(month from job_posted_date) = 1
)
select *
from job_postings_fact
limit 1000;

-- THIS DOWN HERE IS A SIMPLE CTE
-- (we are going to writr more complex CTEs later on)

SELECT 
    name as company_name, 
    company_id
FROM 
    company_dim
WHERE 
    company_id in 
(
    select company_id
    from job_postings_fact
    where job_no_degree_mention=true
)
limit 1000;

-- THIS IS A REMINDER ON HOW TO ALSO SPECIFY THE 
--  TIME ZONE INE OUR SELECT STATEMENT


SELECT job_title_short as title,
       job_location as location,
       job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' as date_of_post
FROM job_postings_fact
LIMIT 5;
-- [this is how we convert from the UTC time zone to any other time zone we want
--  there is a list of thise time zones names for different locations]


-- [what we do here is that we are 
--  telling the outer query to select only the
--  company details for those company who's id
--  is in that generated temporry table]

-- basically here we are first running the query
-- inside the where clause, then it will return 
-- a table containing the company_ids of all the 
-- companies that have the non_degree_mwntion on TRUE. 

with job_post_table as (
select company_id, count(job_id) as number_of_jobs_per_company 
from job_postings_fact
group by company_id
order by number_of_jobs_per_company desc 
limit 5000
)

select cd.name, jpt.number_of_jobs_per_company
from company_dim cd join job_post_table jpt 
on cd.company_id = jpt.company_id
order by number_of_jobs_per_company desc;

-- Another example.
-- this is our CTE that we built, 
-- the CTE here is called 'job_postings_per_skill'


with job_postings_per_skill as (
    select jpf.job_title_short,sjd.skill_id, sd.skills
    from job_postings_fact jpf 
    join skills_job_dim sjd 
        on jpf.job_id=sjd.job_id 
    join skills_dim sd 
        on sjd.skill_id=sd.skill_id
    where jpf.job_work_from_home = true
    -- limit 500000
)

select skills, count(skill_id) as number_of_jobs_by_skill
from  job_postings_per_skill
group by skills 
order by number_of_jobs_by_skill desc
limit 5;

/*

HERE (down) AM JUST CREATING A TABLE FOR THAT ABOVE 
TABLE THAT CLASSIFIES EACH SKILL DEPENDING 
ON THE NUMBER OF TIMES IT IS MENTIONED 
FOR EACH JOB POSTING

create table skill_classement as (
with job_postings_per_skill as (
    select jpf.job_title_short,sjd.skill_id, sd.skills
    from job_postings_fact jpf 
    join skills_job_dim sjd 
        on jpf.job_id=sjd.job_id 
    join skills_dim sd 
        on sjd.skill_id=sd.skill_id
    where jpf.job_title_short='Data Analyst'
    -- limit 500000
)

select skills, count(skill_id) as number_of_jobs_by_skill
from  job_postings_per_skill
group by skills 
order by number_of_jobs_by_skill desc
)
*/


-- UNIONS 

-- (last major topic of this advanced section)

/*
This operator is also very important when it 
comes to combines many tables. its dirrectly if you will, OPOSITE to joins.

So, joins are used in the case where, whenever we want to combine tables 
that maybe relate on a single value such as in the case of combining like 
the job_postings_fact table with the company_dim table we are going to combine 
then ON the matching company_id which is in both the tables, this will return only 
the record which have the same company_id in the two tables. 

SO, RECAL, previously we've created three tables where we've stored job posting 
data, each table for a different month but with the same attributes or columns 
and type of data.
*/

select *
from january_posting_jobs;

select * 
from february_posting_jobs;

select * 
from march_posting_jobs;

/*
we can combine these three tables using UNION, they have the 
same columns with the same datatype, and the same number of column rowwise, 
which mean, each row. 
SAME AMOUNT OF COLUMN and DATATYPES must match.
This also gets rid of all the duplicated rows.


SYNTAX: 

SELECT column_name
FROM table_name

UNION 

SELECT column_name
FROM table_name;
*/

SELECT job_title_short, 
       company_id,
       job_location 
FROM january_posting_jobs

UNION

SELECT job_title_short, 
       company_id,
       job_location 
FROM february_posting_jobs

UNION

SELECT job_title_short, 
       company_id,
       job_location 
FROM march_posting_jobs;

/*
UNION ALL 

this is used pretty much in the same way.
we are still using two or more SELECT statements
in order to combine diffents tables, 

BUT, here we are also returning also duplicagte columns!!!!.
This one is really the most used among the two since we 
pretty much want all the data we cn possibly get.
*/

SELECT job_title_short, 
       company_id,
       job_location 
FROM january_posting_jobs

UNION ALL

SELECT job_title_short, 
       company_id,
       job_location 
FROM february_posting_jobs

UNION ALL

SELECT job_title_short, 
       company_id,
       job_location 
FROM march_posting_jobs;


-- PRACTICE PROBLEM 8:
-- (Here we are using s CTE but we can also do 
-- the same by putting the subquery into the from clause and alias it)

WITH first_quarter_salary_avg AS (

select job_title_short, 
       job_location, 
       salary_year_avg, 
       job_posted_date::date, 
       job_via
from january_posting_jobs


UNION ALL 

select job_title_short, 
       job_location, 
       salary_year_avg, 
       job_posted_date::date, 
       job_via 
from february_posting_jobs


UNION ALL

select job_title_short, 
       job_location, 
       salary_year_avg, 
       job_posted_date::date, 
       job_via
from march_posting_jobs

)

select * 
from first_quarter_salary_avg 
where (salary_year_avg is not null and salary_year_avg>70000)
       and job_title_short='Data Analyst'; 


-- OR 
-- (here we make the code much more shorter by writing the column 
--  names only once and it is in the outside query)

WITH first_quarter_salary_avg AS (

select *
from january_posting_jobs

UNION ALL 

select * 
from february_posting_jobs

UNION ALL

select *
from march_posting_jobs

)

select job_title_short, 
       job_location, 
       salary_year_avg, 
       job_posted_date::date, 
       job_via
from first_quarter_salary_avg 
where (salary_year_avg is not null and salary_year_avg > 70000)
       and job_title_short='Data Analyst'
order by salary_year_avg desc; 


-- ABOUT THE PROJECT: CAPSTONE PROJECT

/*

GOAL: 

1. You are an aspiring data nerd looking to analyse the top-paying roles and skills
2. You will create SQL queries to explore this large dataset specific to you 
3. For those job searching or looking for a promotion: 
                                                    you can not only use this project to showcase experience BUT 
                                                    also to extract what roles/skills you should target. 

This is not only for data analysts, you can finetune this to your specific interest like:

- Data Engineer
- Data Scientist
- Data Analyst
- Senior Data Engineer
- Senior Data Scientist
- Senior Data Analyst
- Business Analyst
- Software Engineer
- Machine Learnjng Engineer
- Cloud Engineer

Samething with the location of the job:

- New York, NY
- San Francisco, CA
- Austin, TX
- Toronto, ON, Canada
- Bengaluru, Karnataka, India
- Tel Aviv-Yafo, Israel
- United Kingdom
- Bogota, Bogota, Colombia
- Berlin, Germany
- Johannesburg, South Africa
- Singapore

*/

