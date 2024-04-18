/*
question 5: What are the most optimal skills to learn for Data Analyst ?

*/

SELECT sd.skills,COUNT(sjd.skill_id) AS skill_demand, ROUND(AVG(jpf.salary_year_avg),2) as averare_salary_per_skill
FROM job_postings_fact jpf JOIN skills_job_dim sjd 
     ON jpf.job_id = sjd.job_id
     JOIN skills_dim sd ON sjd.skill_id=sd.skill_id
WHERE jpf.job_title_short = 'Data Analyst' and jpf.salary_year_avg is not NULL 
      AND jpf.job_work_from_home=true 
GROUP BY sd.skills 
ORDER BY skill_demand desc,averare_salary_per_skill desc
limit 25;