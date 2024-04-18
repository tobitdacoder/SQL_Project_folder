/*
What are the top skills based on salary for my role?

- Look at the average salary associated with each skill for Data analyst positions.
- Focuses on roles with specified salaries, regardeless of location. 
- Why? it reveals how different skills impact salary levels for Data 
       analysts and helps identify the most financially rewarding skills to aquire or improve.
*/

SELECT sd.skills, ROUND(AVG(jpf.salary_year_avg),2) as averare_salary_per_skill
FROM job_postings_fact jpf JOIN skills_job_dim sjd 
     ON jpf.job_id = sjd.job_id
     JOIN skills_dim sd ON sjd.skill_id=sd.skill_id
WHERE jpf.job_title_short = 'Data Analyst' and jpf.salary_year_avg is not NULL 
      AND jpf.job_work_from_home=true 
GROUP BY sd.skills 
ORDER BY averare_salary_per_skill desc
limit 25;