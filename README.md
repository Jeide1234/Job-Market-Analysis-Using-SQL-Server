# 📊 Job Market Analysis Using SQL Server

## 📌 Project Overview

This project analyses a real-world job market dataset containing **787,686 job postings** using **Microsoft SQL Server** to uncover hiring trends, salary patterns, skill demand, and remote work insights.

The project demonstrates how SQL can be used to transform raw recruitment data into meaningful business insights that support decision-making for employers, recruiters, and job seekers.

---

# 🎯 Business Problem

The global job market generates a large volume of recruitment data, making it difficult to identify hiring trends, salary expectations, and the technical skills employers value most.

This project answers practical business questions such as:

* Which jobs pay the highest salaries?
* Which companies offer the highest average salaries?
* What skills are most in demand?
* Do remote jobs pay more?
* Which locations offer the highest salaries?
* Which skills are associated with high-paying jobs?

---

# 📂 Dataset

The dataset consists of **787,686 job postings** across multiple countries and contains four related tables:

| Table                 | Description                                                       |
| --------------------- | ----------------------------------------------------------------- |
| **job_postings_fact** | Job posting details including title, salary, location and company |
| **company_dim**       | Company information                                               |
| **skills_dim**        | List of technical skills                                          |
| **skills_job_dim**    | Bridge table connecting jobs and skills                           |

---

# 🛠️ Tools Used

* Microsoft SQL Server
* SQL Server Management Studio (SSMS)

---

# 🧠 SQL Skills Demonstrated

Throughout this project, I applied:

* SELECT Statements
* Filtering with WHERE
* Sorting using ORDER BY
* Aggregate Functions

  * COUNT()
  * AVG()
  * MIN()
  * MAX()
* GROUP BY
* HAVING
* INNER JOINs
* CASE Statements
* Subqueries
* Common Table Expressions (CTEs)
* Window Functions

  * RANK()
  * ROW_NUMBER()
* PARTITION BY
* EXISTS / NOT EXISTS
* Business-focused SQL Analysis

---

# ❓ Business Questions Answered

### Exploratory Analysis

* How many job postings are available?
* How many companies are in the dataset?
* How many unique skills exist?
* What are the most common job titles?
* Which countries have the most job postings?
* Which locations have the highest number of job postings?
* What percentage of jobs are remote?
* What percentage of jobs do not require a degree?

### Salary Analysis

* What are the highest-paying jobs?
* What are the highest-paying Data Analyst jobs?
* Which job categories have the highest average salaries?
* Which countries have the highest average salaries?
* Which locations have the highest average salaries?
* Which companies offer the highest average salaries?
* What is the salary difference between remote and non-remote jobs?
* What is the salary difference between jobs requiring a degree and those that do not?

### Skills Analysis

* What are the most in-demand skills?
* What skills are most required for:

  * Data Analysts
  * Data Scientists
  * Data Engineers
* Which skills appear most often in high-paying jobs?
* Which skills command the highest salaries?

### Advanced SQL Analysis

* Rank companies by average salary
* Rank locations by average salary
* Find the top 5 skills for each job category
* Find the top-paying company in each country
* Find the top-paying skill in each job category
* Find jobs requiring both SQL and Python
* Find jobs requiring SQL but not Python

---

# 📈 Key Insights

Some of the insights generated include:

* Remote jobs offered higher average salaries than non-remote jobs.
* Jobs requiring a degree generally paid more than jobs that did not require one.
* SQL, Python, Excel and Power BI appeared among the most sought-after technical skills.
* Salary levels varied significantly across countries, locations and companies.
* Advanced SQL techniques made it possible to identify high-value skills and hiring trends.

---

# 📸 Project Screenshots

Include screenshots of:

* Highest-paying jobs
* Top-paying skills
* Most in-demand skills
* Company salary rankings
* Remote vs Non-Remote salary comparison
* Top-paying company by country

---

# 🎯 Conclusion

This project demonstrates how SQL can be used to solve real-world business problems by analysing recruitment data and generating actionable insights. It showcases both foundational and advanced SQL techniques while applying analytical thinking to answer meaningful business questions.

---

## 👤 Author

**Jadesola Ogunkayode**

* LinkedIn: (linkedin.com/in/jadesola-ogunkayode-data-analyst)
* GitHub: https://github.com/Jeide1234
