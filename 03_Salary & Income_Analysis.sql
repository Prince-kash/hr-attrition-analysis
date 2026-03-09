-- Section 3 — Salary & Income Analysis
-- Q10. Average salary — left vs stayed
Select 
Attrition,
round(avg(MonthlyIncome),0) as avg_salary,
round(min(MonthlyIncome),0) as min_salary,
round(max(MonthlyIncome),0) as max_salary
from hr_employees
group by Attrition;

-- Do people who leave earn less?
-- Yes

-- Q11. Salary range vs attrition
Select 
       CASE 
        WHEN MonthlyIncome < 3000 THEN 'Low (Under 3K)'
        WHEN MonthlyIncome BETWEEN 3000 AND 6000 THEN 'Medium (3K-6K)'
        WHEN MonthlyIncome BETWEEN 6001 AND 10000 THEN 'High (6K-10K)'
        ELSE 'Very High (10K+)'
    END AS salary_band,
    count(*) as total_employess,
	sum(case when attrition = 'Yes' then 1 else 0 end) as company_left,
    Round(sum(case when attrition = 'Yes' then 1 else 0 end) * 100 / count(*),2) as attrition_rate
    from hr_employees
    group by salary_band
    order by attrition_rate;
    
-- Which salary band has highest attrition?
-- Low (Under 3K)

-- Q12. Overtime vs attrition
Select OverTime,
count(*) as total_employees,
sum(case when Attrition ='Yes' then 1 else 0 end) as company_left,
Round(sum(case when Attrition ='Yes' then 1 else 0 end) * 100.0 / count(*) ) as attrition_rate
from hr_employees
group by OverTime
order by attrition_rate desc;

-- Does working overtime cause people to quit?
-- Yes

-- Q13. Salary hike vs attrition
Select  
 CASE 
        WHEN PercentSalaryHike < 12 THEN 'Low Hike (Under 12%)'
        WHEN PercentSalaryHike BETWEEN 12 AND 15 THEN 'Medium Hike (12-15%)'
        ELSE 'High Hike (15%+)'
    END AS hike_band,
count(*) as total_employees,
sum(case when Attrition ='Yes' then 1 else 0 end) as company_left,
Round(sum(case when Attrition ='Yes' then 1 else 0 end) * 100.0 / count(*) ) as attrition_rate
from hr_employees
group by hike_band
order by attrition_rate desc;
-- Does a low salary hike push people to leave?
-- Yes
