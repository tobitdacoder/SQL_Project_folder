/*
question 5: What are the most optimal skills to learn for Data Analyst ?

*/

SELECT 
    sd.skills,COUNT(sjd.skill_id) AS skill_demand_count, 
    ROUND(AVG(jpf.salary_year_avg),2) as averare_salary_per_skill
FROM job_postings_fact jpf JOIN skills_job_dim sjd 
     ON jpf.job_id = sjd.job_id
     JOIN skills_dim sd ON sjd.skill_id=sd.skill_id
WHERE jpf.job_title_short = 'Data Analyst' and jpf.salary_year_avg is not NULL 
      AND jpf.job_work_from_home=true 
GROUP BY sd.skills 
ORDER BY skill_demand_count desc,averare_salary_per_skill desc
limit 25;

/*
NOTE: for CTEs, whenever you are combining two CTEs, you only need One WITH 
clause and then you will be just using comma to separate the different CTEs. 
*/

SELECT 
    sd.skills,COUNT(sjd.skill_id) AS skill_demand_count, 
    ROUND(AVG(jpf.salary_year_avg),2) as averare_salary_per_skill
FROM job_postings_fact jpf JOIN skills_job_dim sjd 
     ON jpf.job_id = sjd.job_id
     JOIN skills_dim sd ON sjd.skill_id=sd.skill_id
WHERE jpf.job_title_short = 'Data Analyst' and jpf.salary_year_avg is not NULL 
      AND jpf.job_work_from_home=true 
GROUP BY sd.skills
HAVING  COUNT(sjd.skill_id)>=10
ORDER BY averare_salary_per_skill desc, skill_demand_count desc
limit 25;
