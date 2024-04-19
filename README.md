

# An Insight About Data Analyst Job Oportunities In 2024😀 

# Introduction

📊 Welcome to an exploration of the data job market! Centered on data analyst roles, this project delves into the top-paying positions, the most sought-after skills ✅, and identifies the most optimal data analyst jobs in terms of salary and demand.

Here is the SQL repository, containing queries that I used to achieve this project 🔍: [Project_SQL](/Project_SQL/)

# Background

Join us on an exhilarating journey through the realm of data analyst jobs 📊🚀. 

Powered by PostgreSQL, this project is your ticket to simplifying the search for your ideal job by uncovering top-paying skills 💰 and coveted positions 🥇 in the field.

What makes this project truly fascinating is its foundation in PostgreSQL. By leveraging the power of this robust and popular database system, we've meticulously analyzed data to provide insights that can supercharge your career aspirations ✅.

But it doesn't stop there. Our data is sourced from Luke Barousse's website, a seasoned data analyst with years of industry experience in the Data field. Through his dedicated efforts, we've gained access to a wealth of information that can guide you toward your dream job. [Here is the link to the dataset.](https://lukebarousse.com/sql)

So, if you're ready to embark on a journey toward career success, dive into our project, and navigate with us into the dynamic landscape of data analysis jobs. 

### The questions I wanted to answer through my SQL query were:

1. What are the top-paying data analyst jobs?
2. what skills are required the most for the top-paying jobs?
3. What skills are most in demand for data analysts?
4. which skills are associated with higher salaries?
5. what are the most optimal skills to learn ?
 
# Tools I Used

For my deep dive into the data analyst job market, I harnesed the power of several key tools: 

- **SQL**: The backbone of my analysis, allowing me to query the database and unearth critical insights.
- **PostgreSQL**: The chosen database management system (D.B.M.S), ideal for handling the HUGE job posting database.
- **Visual Studio Code**: My go-to code editor for database management and executing SQL queries.
- **Git & GitHub**: Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.

# The analysis

Each query for this project aimed of investigating specific aspects 0f the data analyst job market. Here's how I approached each question: 

### 1. Top Paying Data Analyst Job

To identify the highest-paying roles, I filtered data analyst positions by average rearly salary and location, focusing on remote jobs. this query highlights the high paying opportunities in the field.

```sql
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
```

Based on the result of this query, here is the breakdown of the top data analyst jobs in 2023:

- **Wide Salary Range:** Top 10 paying data analyst roles span from **$184,000 to $650,000**; indicating significant salary potential in the field of data analytics. 

- **Diverse Employers:** Big companies like **SmartAsset, Meta, and AT&T** are among those offering high salaries, showing a broad interest accross different industries.

- **Job Title Variety:** There is a high diversity in job titles, from Data Analysts to Director of analytics, reflecting varied roles and specializations within the field of Data Analytics.

Here is the Top paying Data analysis related Roles.

![Top Paying Jobs](Assets\top_paying.png)

### 2. 

# What I Learned
# Conclusion 