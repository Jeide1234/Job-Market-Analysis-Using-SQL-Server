# /*

Project: Job Market Analysis Using SQL Server
Author: Jadesola Ogunkayode
Tools: Microsoft SQL Server (SSMS)

Description:
This project analyses nearly 788,000 job postings to
identify hiring trends, salary patterns, in-demand skills,
remote work trends, and company insights using SQL.

SQL Concepts:

* SELECT
* WHERE
* GROUP BY
* HAVING
* JOINs
* CASE
* Subqueries
* CTEs
* Window Functions
* EXISTS / NOT EXISTS
  ==========================================================
  */

--How many job postings are in the dataset?

SELECT COUNT (job_id) AS JobPostingsCount
FROM dbo.job_postings_fact;

--How many companies are in the dataset?

SELECT COUNT (company_id) AS CompaniesCount
FROM dbo.company_dim;

--How many unique skills are in the dataset?

SELECT COUNT (skills) AS SkilllsCount
FROM dbo.skills_dim;

--What are the top 10 most common job titles?

SELECT TOP 10 job_title_short, 
           COUNT (*) AS JobCount
FROM dbo.job_postings_fact
GROUP BY job_title_short
ORDER BY JobCount DESC;

--What are the top 10 job locations

SELECT TOP 10 job_location, 
           COUNT (*) AS JobLocationsCount
FROM dbo.job_postings_fact
GROUP BY job_location
ORDER BY JobLocationsCount DESC;

--How many jobs are remote?

SELECT COUNT (job_work_from_home) AS RemoteJobCount
FROM dbo.job_postings_fact
WHERE job_work_from_home=1;

--How many jobs mention health insurance?

SELECT COUNT (job_health_insurance) AS HealthInsuranceJobCount
FROM dbo.job_postings_fact
WHERE job_health_insurance=1;

--How many jobs do not require a degree?

SELECT COUNT (job_no_degree_mention) AS NoDegreeJobCount
FROM dbo.job_postings_fact
WHERE job_no_degree_mention=1;

--What are the top 10 countries with the most job postings?

SELECT TOP 10 
job_country,
COUNT(job_posted_date) AS JobPostedDate
FROM dbo.job_postings_fact
GROUP BY job_country
ORDER BY JobPostedDate DESC;

--What is the earliest and latest job posting date?

SELECT 
CAST(MIN(job_posted_date) AS DATE) AS EarliestDate,
CAST(MAX(job_posted_date) AS DATE) AS LatestDate
FROM dbo.job_postings_fact; 

--Top 10 companies with the most job postings

SELECT TOP 10 
cd.name AS CompanyName,
COUNT(job_posted_date) AS JobCount
FROM dbo.company_dim cd
JOIN dbo.job_postings_fact jf
ON cd.company_id = jf.company_id
GROUP BY cd.name
ORDER BY JobCount DESC;

--Top 10 highest-paying jobs

SELECT TOP 10 
job_title,salary_year_avg
FROM dbo.job_postings_fact
WHERE salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC;

-- Top 10 highest-paying Data Analyst jobs

SELECT TOP 10 
job_title_short,salary_year_avg
FROM dbo.job_postings_fact
WHERE job_title_short = 'Data Analyst' AND salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC;

--Average salary by job title

SELECT
job_title_short,AVG (salary_year_avg) AS JobAvgSalary
FROM dbo.job_postings_fact
WHERE salary_year_avg IS NOT NULL
GROUP BY job_title_short
ORDER BY JobAvgsalary DESC;

--Average salary by country

SELECT
job_country,
ROUND(AVG (salary_year_avg),0) AS CountryAvgSalary
FROM dbo.job_postings_fact
WHERE salary_year_avg IS NOT NULL
AND job_country IS NOT NULL
GROUP BY job_country
ORDER BY CountryAvgSalary DESC;

--Average salary for remote vs non-remote jobs

SELECT
CASE
WHEN job_work_from_home = 1 THEN 'Remote'
ELSE 'Non-Remote'
END AS JobType,
ROUND(AVG(salary_year_avg),0) AS AvgSalary
FROM dbo.job_postings_fact
WHERE salary_year_avg IS NOT NULL
GROUP BY job_work_from_home
ORDER BY AvgSalary DESC;

--Which companies have the highest average salaries (at least 5 salary record)?
SELECT
cd.name AS CompanyName,
COUNT(*) AS NumberOfJobs,
ROUND(AVG(salary_year_avg),0) AS CompanyAvgSalary
FROM dbo.company_dim cd
JOIN dbo.job_postings_fact jp
ON cd.company_id = jp.company_id
WHERE salary_year_avg IS NOT NULL
GROUP BY cd.name
HAVING COUNT(*) >= 5
ORDER BY CompanyAvgSalary DESC;

--What are the most in-demand skills?

SELECT TOP 20 
sd.skills, 
COUNT (*) AS SkillsDemand
FROM dbo.skills_job_dim sj
JOIN dbo.skills_dim sd
ON sj.skill_id = sd.skill_id
GROUP BY sd.skills
ORDER BY SkillsDemand DESC;

--Top skills required for Data Analyst jobs

SELECT TOP 10
sd.skills,
COUNT(*) AS SkillsDemand
FROM dbo.job_postings_fact jp
JOIN dbo.skills_job_dim sj
ON jp.job_id = sj.job_id
JOIN dbo.skills_dim sd
ON sj.skill_id = sd.skill_id
WHERE jp.job_title_short = 'Data Analyst'
GROUP BY sd.skills
ORDER BY SkillsDemand DESC;

--Top skills required for Data Scientist jobs

SELECT TOP 10
sd.skills,
COUNT(*) AS SkillsDemand
FROM dbo.job_postings_fact jp
JOIN dbo.skills_job_dim sj
ON jp.job_id = sj.job_id
JOIN dbo.skills_dim sd
ON sj.skill_id = sd.skill_id
WHERE jp.job_title_short = 'Data Scientist'
GROUP BY sd.skills
ORDER BY SkillsDemand DESC;

--Top skills required for Data Engineer jobs

SELECT TOP 10
sd.skills,
COUNT(*) AS SkillsDemand
FROM dbo.job_postings_fact jp
JOIN dbo.skills_job_dim sj
ON jp.job_id = sj.job_id
JOIN dbo.skills_dim sd
ON sj.skill_id = sd.skill_id
WHERE jp.job_title_short = 'Data Engineer'
GROUP BY sd.skills
ORDER BY SkillsDemand DESC;

--Top 10 Most common job schedule types

SELECT TOP 10
job_schedule_type,
COUNT (*) AS JobTypeCount
FROM dbo.job_postings_fact
WHERE job_schedule_type IS NOT NULL
GROUP BY job_schedule_type
ORDER BY JobTypeCount DESC;

-- Which locations have the highest average salaries?

SELECT TOP 10
job_location,
ROUND(AVG(salary_year_avg),0) AS HighAvgSalary
FROM dbo.job_postings_fact
WHERE job_location IS NOT NULL
AND salary_year_avg IS NOT NULL
GROUP BY job_location
ORDER BY HighAvgSalary DESC;

--What percentage of jobs are remote?

SELECT
    ROUND(COUNT(*) * 100.0 /
        (SELECT COUNT(*)
            FROM dbo.job_postings_fact),2) AS RemoteJobsPercentage
FROM dbo.job_postings_fact
WHERE job_work_from_home = 1;

--What percentage of jobs do not require a degree?

SELECT
    ROUND(COUNT(*) * 100.0 /
        (SELECT COUNT(*)
            FROM dbo.job_postings_fact),2) AS JobNoDegreePercentage
FROM dbo.job_postings_fact
WHERE job_no_degree_mention = 1;


--Top 10 highest-paying skills

SELECT TOP 10
    sd.skills,
    COUNT(*) AS NumberOfJobs,
    ROUND(AVG(jp.salary_year_avg),0) AS AvgSalary
FROM dbo.job_postings_fact jp
JOIN dbo.skills_job_dim sj
    ON jp.job_id = sj.job_id
JOIN dbo.skills_dim sd
    ON sj.skill_id = sd.skill_id
WHERE jp.salary_year_avg IS NOT NULL
GROUP BY sd.skills
HAVING COUNT(*) >= 10
ORDER BY AvgSalary DESC;

--What skills appear most often in high-paying jobs?

SELECT TOP 10
    sd.skills,
    COUNT(*) AS SkillDemand
FROM dbo.job_postings_fact jp
JOIN dbo.skills_job_dim sj
ON jp.job_id = sj.job_id
JOIN dbo.skills_dim sd
ON sj.skill_id = sd.skill_id
WHERE jp.salary_year_avg >= 100000
GROUP BY sd.skills
ORDER BY SkillDemand DESC;

--Rank companies by average salary (at least 5 salary record)

SELECT
name,
AverageSalary,
RANK() OVER (ORDER BY AverageSalary DESC) AS CompanyRank
FROM
(SELECT
 cd.name,
 COUNT(*) AS NumberOfJobs,
 ROUND(AVG(jp.salary_year_avg), 0) AS AverageSalary
 FROM dbo.job_postings_fact jp
 JOIN dbo.company_dim cd
 ON jp.company_id = cd.company_id
 WHERE jp.salary_year_avg IS NOT NULL
 GROUP BY cd.name
 HAVING COUNT(*) >= 5) AS CompanySalary;

 --Rank locations by average salary

 SELECT
 job_location,
 AvgSalary,
 ROW_NUMBER() OVER (ORDER BY AvgSalary DESC) AS LocationRank
FROM

 (SELECT 
 job_location,
 ROUND (AVG (salary_year_avg),0) AS AvgSalary
 FROM dbo.job_postings_fact
 WHERE salary_year_avg IS NOT NULL
 AND job_location IS NOT NULL
 GROUP BY  job_location) AS Location_Salary;

 -- Top 5 skills for each job title using window functions

WITH SkillDemand AS (
    SELECT
        jp.job_title_short,
        sd.skills,
        COUNT(*) AS SkillCount
    FROM dbo.job_postings_fact jp
    JOIN dbo.skills_job_dim sj
        ON jp.job_id = sj.job_id
    JOIN dbo.skills_dim sd
        ON sj.skill_id = sd.skill_id
    GROUP BY
        jp.job_title_short,
        sd.skills
),

RankedSkills AS (
    SELECT
        job_title_short,
        skills,
        SkillCount,
        ROW_NUMBER() OVER (
            PARTITION BY job_title_short
            ORDER BY SkillCount DESC
        ) AS SkillRank
    FROM SkillDemand
)

SELECT
    job_title_short,
    skills,
    SkillCount,
    SkillRank
FROM RankedSkills
WHERE SkillRank <= 5
ORDER BY
    job_title_short,
    SkillRank;


--Find the salary difference between remote and non-remote jobs

-- Salary difference between remote and non-remote jobs

SELECT
    ROUND(
        AVG(CASE WHEN job_work_from_home = 1 THEN salary_year_avg END), 0) AS RemoteAvgSalary,

    ROUND(
        AVG(CASE WHEN job_work_from_home = 0 THEN salary_year_avg END), 0) AS NonRemoteAvgSalary,

    ROUND(
        AVG(CASE WHEN job_work_from_home = 1 THEN salary_year_avg END)
        -
        AVG(CASE WHEN job_work_from_home = 0 THEN salary_year_avg END),
        0
    ) AS SalaryDifference
FROM dbo.job_postings_fact
WHERE salary_year_avg IS NOT NULL;

-- Find the average salary for jobs that require a degree vs those that don't

SELECT
    ROUND(
        AVG(CASE WHEN job_no_degree_mention = 1 THEN salary_year_avg END), 0) AS JobDegreeSalary,

    ROUND(
        AVG(CASE WHEN job_no_degree_mention = 0 THEN salary_year_avg END), 0) AS JobNoDegreeSalary,

    ROUND(
        AVG(CASE WHEN job_no_degree_mention = 1 THEN salary_year_avg END)
        -
        AVG(CASE WHEN job_no_degree_mention = 0 THEN salary_year_avg END),
        0
    ) AS JobNoDegreeDifference
FROM dbo.job_postings_fact
WHERE salary_year_avg IS NOT NULL;


-- Find the top-paying company for each country

WITH CompanySalary AS 
(
SELECT
        jp.job_country,
        cd.name AS CompanyName,
        ROUND(AVG(jp.salary_year_avg),0) AS AvgSalary
    FROM dbo.job_postings_fact jp
    JOIN dbo.company_dim cd
      ON jp.company_id = cd.company_id
   WHERE jp.salary_year_avg IS NOT NULL
     AND jp.job_country IS NOT NULL
GROUP BY
        jp.job_country,
        cd.name
),

RankedCompanies AS (
    SELECT
        job_country,
        CompanyName,
        AvgSalary,
        ROW_NUMBER() OVER(
            PARTITION BY job_country
            ORDER BY AvgSalary DESC
        ) AS SalaryRank
    FROM CompanySalary
)

SELECT
    job_country,
    CompanyName,
    AvgSalary
FROM RankedCompanies
WHERE SalaryRank = 1
ORDER BY AvgSalary DESC;

-- Find the top-paying skill in each job category

WITH SkillSalary AS (
    SELECT
        jp.job_title_short,
        sd.skills,
        ROUND(AVG(jp.salary_year_avg),0) AS AvgSalary
    FROM dbo.job_postings_fact jp
    JOIN dbo.skills_job_dim sj
        ON jp.job_id = sj.job_id
    JOIN dbo.skills_dim sd
        ON sj.skill_id = sd.skill_id
    WHERE jp.salary_year_avg IS NOT NULL
    GROUP BY
        jp.job_title_short,
        sd.skills
),

RankedSkills AS (
    SELECT
        job_title_short,
        skills,
        AvgSalary,
        ROW_NUMBER() OVER(
            PARTITION BY job_title_short
            ORDER BY AvgSalary DESC
        ) AS SkillRank
    FROM SkillSalary
)

SELECT
    job_title_short,
    skills,
    AvgSalary
FROM RankedSkills
WHERE SkillRank = 1
ORDER BY AvgSalary DESC;

-- Find jobs that require both SQL and Python

SELECT
    jp.job_id,
    jp.job_title_short,
    COUNT(DISTINCT sd.skills) AS SkillCount
FROM dbo.job_postings_fact jp
JOIN dbo.skills_job_dim sj
  ON jp.job_id = sj.job_id
JOIN dbo.skills_dim sd
  ON sj.skill_id = sd.skill_id
WHERE sd.skills IN ('sql', 'python')
GROUP BY
    jp.job_id,
    jp.job_title_short
HAVING COUNT(DISTINCT sd.skills) = 2;

-- Find jobs that require SQL but not Python

SELECT
    jp.job_id,
    jp.job_title_short
FROM dbo.job_postings_fact jp
WHERE EXISTS (
    SELECT 1
    FROM dbo.skills_job_dim sj
    JOIN dbo.skills_dim sd
        ON sj.skill_id = sd.skill_id
    WHERE sj.job_id = jp.job_id
        AND sd.skills = 'sql'
)
AND NOT EXISTS (
    SELECT 1
    FROM dbo.skills_job_dim sj
    JOIN dbo.skills_dim sd
        ON sj.skill_id = sd.skill_id
    WHERE sj.job_id = jp.job_id
        AND sd.skills = 'python'
);




















