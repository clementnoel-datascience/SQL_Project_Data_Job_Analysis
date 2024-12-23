
/*

Question: What are the most in-demand skills for data analysts?

- Identify the top 5 in-demand skills for a data analyst.
- Focus on all job postings.
- Why? Retrieves the top 5 skills with the highest demand in the job market, providing insights into the most valuable skills for job seekers.

*/


SELECT 
    skills_dim.skills AS skills,
    COUNT(skills_job_dim.job_id) AS demand_count
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
    AND job_work_from_home = TRUE
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 5
;