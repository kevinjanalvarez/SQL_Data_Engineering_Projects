/*
QuestionL What are the highest-paying skills for data engineers?

1. Calculate the mediean salary for each skill requires in data engineer positions.
2. Focus on remote positions with specified salaries.
3. Include skill frequency to identify both salary and demand.

*/



SELECT
    sd.skills,
    COUNT(jpf.*) AS demand_count,
    ROUND(MEDIAN(jpf.salary_year_avg), 0) AS median_salary,
    ROUND(LN(COUNT(jpf.*)),1) AS ln_demand_count,
    ROUND((MEDIAN(jpf.salary_year_avg) * LN(COUNT(jpf.*)))/1_000_000, 2) AS optimal_score
    
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

ORDER BY optimal_score DESC

LIMIT 25;

/*

────────────┬──────────────┬───────────────┬─────────────────┬───────────────┐
│   skills   │ demand_count │ median_salary │ ln_demand_count │ optimal_score │
│  varchar   │    int64     │    double     │     double      │    double     │
├────────────┼──────────────┼───────────────┼─────────────────┼───────────────┤
│ terraform  │          193 │      184000.0 │             5.3 │          0.97 │
│ python     │         1133 │      135000.0 │             7.0 │          0.95 │
│ sql        │         1128 │      130000.0 │             7.0 │          0.91 │
│ aws        │          783 │      137320.0 │             6.7 │          0.91 │
│ airflow    │          386 │      150000.0 │             6.0 │          0.89 │
│ spark      │          503 │      140000.0 │             6.2 │          0.87 │
│ kafka      │          292 │      145000.0 │             5.7 │          0.82 │
│ snowflake  │          438 │      135500.0 │             6.1 │          0.82 │
│ azure      │          475 │      128000.0 │             6.2 │          0.79 │
│ java       │          303 │      135000.0 │             5.7 │          0.77 │
│ scala      │          247 │      137290.0 │             5.5 │          0.76 │
│ kubernetes │          147 │      150500.0 │             5.0 │          0.75 │
│ git        │          208 │      140000.0 │             5.3 │          0.75 │
│ databricks │          266 │      132750.0 │             5.6 │          0.74 │
│ redshift   │          274 │      130000.0 │             5.6 │          0.73 │
│ gcp        │          196 │      136000.0 │             5.3 │          0.72 │
│ hadoop     │          198 │      135000.0 │             5.3 │          0.71 │
│ nosql      │          193 │      134415.0 │             5.3 │          0.71 │
│ pyspark    │          152 │      140000.0 │             5.0 │           0.7 │
│ docker     │          144 │      135000.0 │             5.0 │          0.67 │
│ mongodb    │          136 │      135750.0 │             4.9 │          0.67 │
│ go         │          113 │      140000.0 │             4.7 │          0.66 │
│ r          │          133 │      134775.0 │             4.9 │          0.66 │
│ bigquery   │          123 │      135000.0 │             4.8 │          0.65 │
│ github     │          127 │      135000.0 │             4.8 │          0.65 │
└────────────┴──────────────┴───────────────┴─────────────────┴───────────────┘

*/