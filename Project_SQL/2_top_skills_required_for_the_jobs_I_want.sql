/*
 QUESTION 2: what are the top skills required for these top-paying data analyst roles? (Data Analyst)

- Use the top 10 highest-paying Data analyst jobs from first query
- Add the specific skills required for these roles
- Why? it provides a detailed look at which high-paying 
jobs demand certain skills, helping job seekers understand 
which skills to devellop that align with top salaries.


*/

-- Now am creating a table that will store all the columns and reccords 
-- generated by the CTE that we created in the previous query. 
-- this is to help us structure that data generated by the CTE in one 
-- single table and be able to use that data in other queries later.

create table top_data_analyst_remote_jobs_postings as 

(

WITH remote_data_anayst_top_jobs as 
( 
        SELECT 
            job_id,
            company_id,
            job_title,
            job_location,
            job_schedule_type,
            salary_year_avg,
            job_posted_date

        FROM 
            job_postings_fact
        WHERE job_title_short='Data Analyst' 
            and job_location='Anywhere' 
            and salary_year_avg is not null

        order by salary_year_avg desc
        limit 10
    )
    select cd.name, 
        rdatj.job_title, 
        rdatj.job_location, 
        rdatj.job_schedule_type,
        rdatj.salary_year_avg,
        rdatj.job_posted_date
    from remote_data_anayst_top_jobs rdatj join company_dim cd
    on rdatj.company_id = cd.company_id

);


select * 
from top_data_analyst_remote_jobs_postings;
/*
this here is the new table that I created so that I can work on it 
much easier and do more analysis on. 
WHAT IT DOES
It is selecting all the first top 1000 remote, data analyst jobs, 
 with the compamy name added for each of the jobs, ordering them from 
the highest payed on average to the 1000th in term of salary per year.

*/

drop table top_data_analyst_remote_jobs_postings;
