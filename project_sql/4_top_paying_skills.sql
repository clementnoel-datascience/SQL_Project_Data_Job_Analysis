/*

Answer: What are the top skills based on salary?

- Look at the average salary associated with each skill for Data Analyst positions.
- Focuses on roles with specified salaries, regardless of location.
- Why? It reveals how different skills impact salary levels for Data Analysts and helps identify the most financially rewarding skills to acquire or improve.

*/

SELECT 
    skills_dim.skills AS skills,
    ROUND(AVG(salary_year_avg),0) AS avg_salary -- average salary
FROM 
    job_postings_fact
INNER JOIN -- Inner join because we only want jobs that required skills
    skills_job_dim -- contains job_id and skill_id
ON
    job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN -- Inner join because we only want skills that are required for the top paying jobs
    skills_dim -- contains skill names and skill_id
ON
    skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = TRUE
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 5
;