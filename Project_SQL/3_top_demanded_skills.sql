/*
question 3: WHAT ARE THE MOST IN-DEMAND skills for my role? 
            (Data Analyst)
- Join job postings to inner join table similar to query two
- identify the top 5 in-demand skills for a data analyst.
- Focus on all job postings (especually the remote jobs so work from home allowed).
- Why? Retrieves the top 5 skills with the highest demand on the job market,
       providing insights into the most valuable skills for job seekers. 
*/ 

SELECT sd.skills, count(sjd.skill_id) as skill_demand_count
FROM job_postings_fact jpf JOIN skills_job_dim sjd 
     ON jpf.job_id = sjd.job_id
     JOIN skills_dim sd ON sjd.skill_id=sd.skill_id
WHERE jpf.job_title_short = 'Data Analyst' and jpf.job_work_from_home=true
GROUP BY sd.skills 
ORDER BY skill_demand_count desc
limit 5;

/*
this query is the one that allows us to know what are the top 5 in demand 
skills for Data analysts especially, who also can worj from home. this is 
to show what skill to focus on when we want to apply to a Data Analyst job
with the remote work option.
*/


