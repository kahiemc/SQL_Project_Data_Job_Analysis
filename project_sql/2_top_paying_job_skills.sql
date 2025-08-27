/*
Question: What are the skills required for these top-paying roles?
- Use the top 10 highest paying Data Analyst jobs from the first querry
- Add the specific skills required for these roles
-Why? It provides a detailed look at which high-paying jobs demand certain skills, 
helping job seekers unersatnd which skills to develop that align with top salaries
*/

WITH top_paying_jobs AS (
    SELECT
        job_id, 
        job_title,
        salary_year_avg,
        name AS company_name 
    FROM
        job_postings_fact
    LEFT JOIN company_dim
        ON job_postings_fact.company_id = company_dim.company_id
    WHERE 
        job_title_short = 'Data Analyst' 
        AND job_location = 'Anywhere'
        AND salary_year_avg IS NOT NULL 
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)

SELECT 
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON  skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC





/*
Most in-demand core skills:
SQL (8 mentions) → appears in every role, foundational.
Python (7 mentions) → nearly universal.
Tableau (6 mentions) → visualization & BI tool highly valued.
R (4 mentions) → statistical analysis in select roles.

High-value, less common skills:
Snowflake, Pandas, Excel (3 each) → strong in data handling & reporting.
Azure, Bitbucket, Go (2 each) → cloud, version control, programming niche.
Rare but differentiating skills (1 mention each) include Databricks, Hadoop, PowerBI, AWS, Scala, Looker, etc. These suggest specialized environments—being strong in even a few can set you apart.

Takeaways
Baseline expectation: SQL + Python are non-negotiables.
Visualization expertise: Tableau (and sometimes Power BI/Looker) critical for storytelling.
Cloud + Data Warehousing: Snowflake, Azure, Databricks show employers want analysts who can handle big data ecosystems.
Programming breadth: R, Go, Scala appear in specialized roles—learning them gives extra career leverage.
*/