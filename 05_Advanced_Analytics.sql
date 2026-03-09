-- Section 5 — Advanced Analytics
Use hr_analytics;
With risk_fators As(
select 
     EmployeeNumber,
     Age,
     Department,
     JobRole,
     MonthlyIncome,
     Attrition,
     (Case when OverTime ='Yes' Then 1 else 0 end +
     Case when JobSatisfaction = '1' Then 1 else 0 end +
     Case When WorkLifeBalance = '1' Then 1 else 0 end +
     Case when MonthlyIncome <= '3000' Then 1 else 0 end +
     Case when DistanceFromHome >= '15' Then 1 else 0 end +
     Case when YearsAtCompany <=1 Then 1 else 0 end ) As risk_score
From hr_employees
)
SELECT 
    EmployeeNumber,
    Age,
    Department,
    JobRole,
    MonthlyIncome,
    Attrition,
    risk_score,
    Case 
        When risk_score >=4 Then 'High Risk'
        When risk_score >=2 Then 'Medium Risk'
        else 'low Risk'
    End As risk_category
from risk_fators     
ORDER BY risk_score DESC
LIMIT 20;

-- Which specific employees are highest flight risk?
-- Laboratory Technician

-- Q19. Department attrition ranking using window function
WITH dept_attrition AS (
    SELECT 
        Department,
        COUNT(*) AS total_employees,
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS left_company,
        ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
    FROM hr_employees
    GROUP BY Department
)
SELECT 
    Department,
    total_employees,
    left_company,
    attrition_rate,
    RANK() OVER (ORDER BY attrition_rate DESC) AS attrition_rank
FROM dept_attrition;


-- Q20. Cumulative attrition by age
WITH age_attrition AS (
    SELECT 
        Age,
        COUNT(*) AS total_employees,
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS left_company
    FROM hr_employees
    GROUP BY Age
)
SELECT 
    Age,
    total_employees,
    left_company,
    SUM(left_company) OVER (ORDER BY Age) AS cumulative_attrition,
    ROUND(SUM(left_company) OVER (ORDER BY Age) * 100.0 / SUM(left_company) OVER (), 2) AS cumulative_pct
FROM age_attrition
ORDER BY Age;


-- Q21. High risk employee profile summary
SELECT 
    Department,
    JobRole,
    ROUND(AVG(Age), 0) AS avg_age,
    ROUND(AVG(MonthlyIncome), 0) AS avg_income,
    ROUND(AVG(YearsAtCompany), 1) AS avg_tenure,
    COUNT(*) AS employees_left,
    ROUND(AVG(DistanceFromHome), 1) AS avg_distance
FROM hr_employees
WHERE Attrition = 'Yes'
GROUP BY Department, JobRole
ORDER BY employees_left DESC
LIMIT 10;


--Q22. What is the average income of employees who left?
SELECT 
    ROUND(AVG(MonthlyIncome), 0) AS avg_income_left
FROM hr_employees
WHERE Attrition = 'Yes';


Select 
JobRole,
round(avg(MonthlyIncome),0) as avg_salary
from hr_employees
group by JobRole
order by avg_salary desc;
