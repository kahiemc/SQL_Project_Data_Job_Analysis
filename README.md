# Introduction
Dig into the data job market! While focusing on data analyst roles, this project explores top-paying jobs, in-demand skills, and the golden point where high demand meets high salary in data analytics. 

SQL querries? Check them out here: [project_sql folder](project_sql)
  
# Background
On a quest to navigate the data analyst job market effectively, this project was created from the desire to pinpoint the top-paid and in-demand skills, streamlining others work to find optimal jobs. 

The data comes from [Luke Barousse's SQL Course](https://lukebarousse.com/sql).

### The questions I seeked to answer through my SQL queries were:
1. What are thr top paying data analyst jobs?
2. What skills are requires for these top-paying jobs?
3. What skills are most in-demand for data analysts?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?

# Tools I Used
For my deep dive into the data analyst job market, I harnessed the power of several key tools:

- **SQL:** The foundation of the analysis, allowing me to querry the database and unearth critical insights.
- **PostgreSQL:** The chosen database management system, ideal for handling the job postings data.
- **Visual Studio Code:** My go-to for database management and executing SQL queries,  
- **Git & Github:** Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking
- **Tableau:** My essential tool for data visualization and presentation of insights

# The Analysis
Each query for this project aimed at investigating specific aspects of the data analyst job market. Here's how I approached each question:

### 1. Top Paying Data Analyst Jobs
To identify the highest paying roles, I filtered data analyst positions by average yearly salary and location, focusing on remote jobs. 

```sql
SELECT
    job_id, 
    job_title,
    job_location,
    job_schedule_type,  
    salary_year_avg,
    job_posted_date,
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
LIMIT 10;
```
Here's the breakdown of the top data analyst jobs in 2023:

- **Wide Salary Range:** Top 10 paying data analyst roles span from $184,000 to $650,000 a year, indicating that there is significant salary potential in the data analyst field. 
- **Diverse Employers:** Companies like Inclusively, AT&T and Meta are amongst those offering high salaries, showing that there is a broad interest in data analyst across many different industries.
- **Job Title Variety:** There is a high diversity in job titles as well, from Principal Data Analyst to Director of Analytics, reflecting varied roles and specializations within data analytics yet the simple role of **Data Analyst** dominates.
![Top Paying Roles](assets\1_Top_Paying_Data_Analyst_Jobs_1.png)

*Bar Graph visualizing the salary for the top 10 salaries for data analysts; This graph was created in [Tableau Public](https://public.tableau.com/views/SQLDataAnalystJobListing/1_TopPayingDataAnalystJobs?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)


### 2. Top Paying Data Analyst Job Skills



### 3. Top Demanded Data Analyst Job Skills



### 4. Top Data analyst Skills Based on Salary



### 5. Most Optimal Data Analyst Job Skills Based of Salary and Demand



# What I Learned
# Conclusions