/*

Question: What are the top-paying data analyst jobs, and what skills are required?

- Identify the top 10 highest-paying Data Analyst jobs and the specific skills required for these roles.
- Filters for roles with specified salaries that are remote
- Why? It provides a detailed look at which high-paying jobs demand certain skills, helping job seekers understand which skills to develop that align with top salaries

*/

WITH top_paying_job AS ( -- CTE to recover top 10 paying job as data analyst on remote
    SELECT 
        job_id,
        job_title,
        salary_year_avg,
        company_dim.name AS company_name
    FROM 
        job_postings_fact
    LEFT JOIN
        company_dim -- contains company names
    ON 
        job_postings_fact.company_id = company_dim.company_id  
    WHERE
        job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
        AND job_location = 'Anywhere'
        
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)

-- Skills required
SELECT 
    top_paying_job.*, -- all columns from top paying job table
    skills_dim.skills -- required skills for the top paying job
FROM 
    top_paying_job
INNER JOIN -- Inner join because we only want jobs that required skills
    skills_job_dim -- contains job_id and skill_id
ON
    top_paying_job.job_id = skills_job_dim.job_id
INNER JOIN -- Inner join because we only want skills that are required for the top paying jobs
    skills_dim -- contains skill names and skill_id
ON
    skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC
;
