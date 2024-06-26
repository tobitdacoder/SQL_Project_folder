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
            rdatj.job_id, 
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

-- Now let us JOIN the tables that will allow us to get the skill names 
-- that are leeded for each of these top data anamysis jobs that we've 
-- recently fetched from the database.

-- NOTE: tdarj = top_data_analyst_remote_jobs_postings (the table we 
--               have just created from that complex query from the previous query file 1)

SELECT tdarj.name as company_name, tdarj.job_title, sjd.job_id,tdarj.salary_year_avg, sd.skills
FROM top_data_analyst_remote_jobs_postings tdarj JOIN skills_job_dim sjd
     ON tdarj.job_id = sjd.job_id
     JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
     ORDER BY tdarj.salary_year_avg desc;

/*

NOTE:

This will generate the table containing the data we are looking for
whicb is the information about the different skills that are needed 
for those top paying jobs.

The result of this query will be a table and HERE IS WHAT YOU CAN DO WITH THAT TABLE:
- you cn export it to use it in EXCEL, in POWER BI or in PYTHON for further work.
- this can be done just by clicking on the (UP-RIGHT button located in the query 
  result tab on the left of this code window)
*/

