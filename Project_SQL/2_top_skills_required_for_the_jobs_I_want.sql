/*
 QUESTION 2: what are the topskills required for these top-paying roles? 
for my role? (Data Analyst)

*/

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
    limit 1000
)

select cd.name, 
       rdatj.job_title, 
       rdatj.job_location, 
       rdatj.job_schedule_type,
       rdatj.salary_year_avg,
       rdatj.job_posted_date
from remote_data_anayst_top_jobs rdatj join company_dim cd
on rdatj.company_id = cd.company_id;
