-- delete these changes later.
/*
 QUESTION 1: what are the top-paying jobs 
for my role? (Data Analyst)

- Identify the top 10 highest-paying Data Analyst roles that are available remotely.
- Focuses on job postings with specified salaries (remove nulls).
- Why? Highlight the top-paying opportunities for Data Analysts, offering insights.
*/

SELECT 
    job_id,
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
limit 10;