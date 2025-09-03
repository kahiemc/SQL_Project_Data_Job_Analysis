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
To understand what skills are required for the top paying data analyst jobs, I joined the job postings data with the skills data, providing insights into what employers valuse for high paying roles. 
``` SQL
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

```
Here's a breakdown of the most in-demand core skills:
- **SQL** (8 mentions) → appears in every role, foundational.
- **Python** (7 mentions) → nearly universal.
- **Tableau** (6 mentions) → visualization & BI tool highly valued.
- **R** (4 mentions) → statistical analysis in select roles.

High-value BUT less common skills:
- **Snowflake, Pandas, Excel** (3 each) → strong in data handling & reporting.
- **Azure, Bitbucket, Go** (2 each) → cloud, version control, programming niche.

Rare but differentiating skills: (1 mention each) include 
 - **Databricks, Hadoop, PowerBI, AWS, Scala, Looker, etc.** 
 - These suggest specialized environments—being strong in even a few can set you apart.

**Takeaways** 
- Baseline expectation: SQL + Python are non-negotiables.
- Visualization expertise: Tableau (and sometimes Power BI/Looker) critical for storytelling.

- Cloud + Data Warehousing: Snowflake, Azure, Databricks show employers want analysts who can handle big data ecosystems.

- Programming Supepowers: R, Go, Scala appear in specialized roles—learning them gives extra career leverage.


### 3. Top Demanded Data Analyst Job Skills
To understand what skills are the most demanded amongst data analyst jobs, I joined the job postings data with the skills and skills job data, providing insights of the demand count for each skill listed for data analyst roles.

```SQL
SELECT  
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON  skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst' AND job_work_from_home = TRUE
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 5;
```
Here's a breakdown of the highest demanded data analyst skills of 2023.


- **SQL**: We see that SQL is by far the most in-demand skill for Data Analyst roles in 2023
- **Excel**: We see that Excel also serves as a foundational skills for most Data Analyst roles in 2023
- **Python**: We see the programing language of Python on is also a heavy hitter as far as requested skills for Data Analysts


| Skill   | Demand Count |
|---------|--------------|
| SQL     | 7291         |
| Excel   | 4611         |
| Python  | 4330         |
| Tableau | 3745         |
| Power BI| 2609         |

*Table of the demand for the top 5 skills in data analyst job postings*

![Highest Demanded Skills](assets\3_top_demanded_skills.png)

*Pie Chart visualizing the amount of times each of the top 5 skills were listed in data analyst roles; This graph was created in [Tableau Public](https://public.tableau.com/views/SQLDataAnalystJobListing/1_TopPayingDataAnalystJobs?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)*



### 4. Top Data Analyst Skills Based on Salary

To understand, which skills are associated with higher salaries skills data was joined with job postings data. Then I sorted each skill by its average yearly salary for Data Analyst roles. 

```SQL
SELECT  
    skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON  skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_title_short = 'Data Analyst' 
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = TRUE
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 25;
```

Heres a breakdown of the results for top paying skills for remote data analysts:

**Big Data & ML = Highest Premium** 
- Skills like PySpark, Databricks, Watson, and scikit-learn show that analysts who can handle massive datasets and build predictive models earn the most.

**Engineering + DevOps Integration** 
- Tools like Bitbucket, GitLab, Jenkins, and Kubernetes highlight demand for analysts who can work like engineers, integrating data into production pipelines.

**Cloud & Multi-Skill Analysts Stand Out**
- Knowledge of GCP, Linux, Go, and Swift shows that blending analytics with cloud, infrastructure, and software development skills leads to top salaries.

| Skill          | Avg Salary |
|----------------|------------|
| PySpark        | 208172     |
| Bitbucket      | 189155     |
| Couchbase      | 160515     |
| Watson         | 160515     |
| DataRobot      | 155486     |
| GitLab         | 154500     |
| Swift          | 153750     |
| Jupyter        | 152777     |
| Pandas         | 151821     |
| Elasticsearch  | 145000     |


*Table of the top 10 highest salary skills in data analyst job postings*

### 5. Most Optimal Data Analyst Job Skills Based of Salary and Demand
In order to determine the most optimal skills for Data Analysts we must look at the skills that offer job security and finanical benefits, Targets skills that offer job security (high demand) and finanical benefits (high salaries), offering strategic insights for career development. This was done by joining the skills demand with the average salary and then orting by highest demand and highest salary. 


```SQL
WITH skills_demand AS (
    SELECT  
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON  skills_job_dim.skill_id = skills_dim.skill_id
    WHERE job_title_short = 'Data Analyst' 
        AND job_work_from_home = TRUE
        AND salary_year_avg IS NOT NULL
    GROUP BY
        skills_dim.skill_id
), 


average_salary AS (
SELECT  
    skills_job_dim.skill_id,
    ROUND(AVG(salary_year_avg), 2) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON  skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_title_short = 'Data Analyst' 
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = TRUE
GROUP BY
    skills_job_dim.skill_id
)


SELECT  
    skills_demand.skill_id, 
    skills_demand.skills,
    demand_count,
    avg_salary
FROM 
    skills_demand
INNER JOIN  average_salary ON skills_demand.skill_id = average_salary.skill_id 
WHERE demand_count > 10
ORDER BY 
    avg_salary DESC,
    demand_count DESC    
LIMIT 25

```

The 3 most optimal skills to learn for Data Analysts follow as:
- **GO Analytics :** The most in-demand and highest paying skill in the data analyst job field. Go (or Golang) is a computer languages made by Google to be super fast and simple, and often times used in creating analytical systems. 
- **Confluence:** Confluence is the second most optimal skill to learn as a Data Analyst in 2023.  Confluence is a team collaboration and documentation tool used to help teams keep their knowledge in one place, instead of being scattered across emails, chats, or documents
- **Hadoop:** Hadoop comes in as the third most optimal skill to learn as a Data Analyst in 2023. Hadoop is an open-source framework that helps people store and process huge amounts of data across many computers at once. Hadoop is popular for big data, analytics, and machine learning pipelines in companies like Facebook, Yahoo, and Amazon.


| Skill      | Demand Count | Avg Salary  |
|------------|--------------|-------------|
| Go         | 27           | 115319.89   |
| Confluence | 11           | 114209.91   |
| Hadoop     | 22           | 113192.57   |
| Snowflake  | 37           | 112947.97   |
| Azure      | 34           | 111225.10   |
| BigQuery   | 13           | 109653.85   |
| AWS        | 32           | 108317.30   |
| Java       | 17           | 106906.44   |
| SSIS       | 12           | 106683.33   |
| Jira       | 20           | 104917.90   |

*Table of the most optimal skills for Data Analysts in 2023 according to  Average Salary and Demand Count*

# What I Learned
Throughout this project, I have supercharged my SQL toolkit:
- **Complex Query Crafting:** Mastered the art of SQl querrying, merging tables and using WITH clauses for temporary table uses.
- **Data Aggrigation:** Got comfortable with GROUP BU and turned aggregate functions like count() and AVG() into my data summerizing essentials.
- **Analytical Wizardry:** I leveled up my real world problem solving skills, turning real world problems into actionable results with insightful SQL querries. 


# Conclusions

### Insights
1. **Top Paying Data Analyst Jobs:** The top paying jobs for remote working Data Analysts offer a wide range of salaries, the highest at $650,000 per year
2. **Top Paying Data Analyst Job Skills:**
High paying Data Analyst positions reequire an advanced proficiency in SQL , suggesting that it is a critical skill for earning a top of the industry salary
3. **Most In-demand Data Analyst Job Skills**
SQL is the most in-demand skill in the Data Analyst job market, making it almost manditory for job seekers in the Data Analyst realm. 
4. **Data Analyst Skills With Higher Salaries:**
Many specialized skills such as Pyspark, Bitbucket and Swift, prove that experience with big data, data engineering and cloud data, can dramaically boost a job seeker's salary
5. **Most Optimal Data Analyst Job Skills to Learn:**
Cloud tools and cloud based databases show up as some of the most in-deamnd and salary rewarding job skills amongst Data Analysts. SQL also continuously shows up as a must have in Data Analysts  roles as the highest demanded skill in the job market. 

### Closing Thoughts
This project dramatically enhanced my SQL skills and gave valuable insights about the state of the Data Analyst job market. These insights have potential to act as a guide for prioritizing skills development and job search. This shows the importance of coninuously learning and adapting in the very competitve job market of data analytics. 
