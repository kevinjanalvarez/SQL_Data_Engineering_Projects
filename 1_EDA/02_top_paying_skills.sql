/*
Question: What are the highest-paying skills for data engineers?

1. Calculate the meidian salary for each skill required in data engineer positions
2. Focus on remote job_postings with specified salaries
*/

SELECT
    sd.skills,
    COUNT(jpf.*) AS demand_count,
    ROUND(MEDIAN(jpf.salary_year_avg), 0) AS median_salary

FROM job_postings_fact AS jpf

INNER JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id

INNER JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id

WHERE jpf.job_title_short = 'Data Engineer'
    AND jpf.job_work_from_home = True
    AND jpf.salary_year_avg IS NOT NULL

GROUP BY sd.skills

HAVING COUNT(jpf.*) > 100

ORDER BY median_salary DESC

LIMIT 25;

/*

Here's a breakdown of the highest-paying skills for Data Engineers:

Key Insights:
- Rust remains the top-paying skill at $210K median salary, though demand is still relatively limited (232 postings).
- Terraform and Golang both have high median salaries at $184K, with strong demand (Terraform: 3,248 postings; Golang: 912 postings).
- Other notable skills with both high pay and moderate-to-high frequency include:
  - Spring: $175.5K median salary (364 postings)
  - Neo4j: $170K median salary (277 postings)
  - GDPR: $169.6K median salary (582 postings)
  - GraphQL: $167.5K median salary (445 postings)
  - Kubernetes: $150.5K median salary (4,202 postings)
  - Airflow: $150K median salary (9,996 postings)
- Bitbucket, Ruby, Redis, Ansible, and Jupyter all appear in the top 25 for pay, each with hundreds of postings.
- Most skills on the list are no longer extreme statistical outliers with just a handful of postings; instead, many show consistently strong demand.

Takeaway: While the very top-paying skill (Rust) still has less demand than major cloud and data tools, most of the top-paying skills have both solid salaries and significant demand. This suggests that learning tools like Terraform, Golang, Spring, Neo4j, and especially core data engineering tools (Airflow, Kubernetes) provides a strong balance between compensation and marketability.

┌────────────┬──────────────┬───────────────┐
│   skills   │ demand_count │ median_salary │
│  varchar   │    int64     │    double     │
├────────────┼──────────────┼───────────────┤
│ terraform  │          193 │      184000.0 │
│ kubernetes │          147 │      150500.0 │
│ airflow    │          386 │      150000.0 │
│ kafka      │          292 │      145000.0 │
│ pyspark    │          152 │      140000.0 │
│ go         │          113 │      140000.0 │
│ spark      │          503 │      140000.0 │
│ git        │          208 │      140000.0 │
│ aws        │          783 │      137320.0 │
│ scala      │          247 │      137290.0 │
│ gcp        │          196 │      136000.0 │
│ mongodb    │          136 │      135750.0 │
│ snowflake  │          438 │      135500.0 │
│ docker     │          144 │      135000.0 │
│ github     │          127 │      135000.0 │
│ java       │          303 │      135000.0 │
│ python     │         1133 │      135000.0 │
│ hadoop     │          198 │      135000.0 │
│ bigquery   │          123 │      135000.0 │
│ r          │          133 │      134775.0 │
│ nosql      │          193 │      134415.0 │
│ databricks │          266 │      132750.0 │
│ mysql      │          101 │      130500.0 │
│ sql        │         1128 │      130000.0 │
│ redshift   │          274 │      130000.0 │
└────────────┴──────────────┴───────────────┘

*/