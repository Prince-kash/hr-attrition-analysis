-- Section 1 — Attrition Overview
Use hr_analytics;
Select 
    count(*) as total_employees,
sum(case when attrition = 'Yes' then 1 else 0 end ) as employees_left,
sum(case when attrition = 'No' then 1 else 0 end ) as employees_stayed,
round(sum(case when attrition = 'Yes' then 1 else 0 end ) * 100.0 / count(*), 2) as attrition_rate
from hr_employees;

-- Q2. Attrition by gender

Select 
Gender,
    count(*) as total_employees,
sum(case when attrition = 'Yes' then 1 else 0 end ) as left_company,
round(sum(case when attrition = 'Yes' then 1 else 0 end ) * 100.0 / count(*), 2) as attrition_rate
from hr_employees
group by gender
order by attrition_rate desc;

-- Q3. Attrition by age group
Select 
   CASE 
        WHEN Age < 25 THEN 'Under 25'
        WHEN Age BETWEEN 25 AND 34 THEN '25-34'
        WHEN Age BETWEEN 35 AND 44 THEN '35-44'
        WHEN Age BETWEEN 45 AND 54 THEN '45-54'
        ELSE '55+'
    END AS age_group,
    count(*) as total_employees,
sum(case when attrition = 'Yes' then 1 else 0 end ) as left_company,
round(sum(case when attrition = 'Yes' then 1 else 0 end ) * 100.0 / count(*), 2) as attrition_rate
from hr_employees
group by age_group
order by attrition_rate desc;

-- Which age group leaves most?
-- age_group - 25-34

-- Q4. Attrition by marital status
Select 
MaritalStatus,
    count(*) as total_employees,
sum(case when attrition = 'Yes' then 1 else 0 end ) as left_company,
round(sum(case when attrition = 'Yes' then 1 else 0 end ) * 100.0 / count(*), 2) as attrition_rate
from hr_employees
group by MaritalStatus
order by attrition_rate desc;

-- Q5. Attrition by business travel
Select 
BusinessTravel,
    count(*) as total_employees,
sum(case when attrition = 'Yes' then 1 else 0 end ) as left_company,
round(sum(case when attrition = 'Yes' then 1 else 0 end ) * 100.0 / count(*), 2) as attrition_rate
from hr_employees
group by BusinessTravel
order by attrition_rate desc;
