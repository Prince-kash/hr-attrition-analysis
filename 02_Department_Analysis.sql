-- Section 2 — Department Analysis
-- Q6. Attrition by department
Select 
Department,
    count(*) as total_employees,
sum(case when attrition = 'Yes' then 1 else 0 end ) as left_company,
round(sum(case when attrition = 'Yes' then 1 else 0 end ) * 100.0 / count(*), 2) as attrition_rate
from hr_employees
group by Department
order by attrition_rate desc;
-- Which department most left company?
-- Research & Development
-- Which department has biggest retention problem?
-- Human Resources

-- Q7. Attrition by job role
Select 
JobRole,
    count(*) as total_employees,
sum(case when attrition = 'Yes' then 1 else 0 end ) as left_company,
round(sum(case when attrition = 'Yes' then 1 else 0 end ) * 100.0 / count(*), 2) as attrition_rate
from hr_employees
group by JobRole
order by attrition_rate desc;
-- Which job role loses most people?
-- Laboratory Technician

-- Q8. Attrition by education field
Select 
EducationField,
    count(*) as total_employees,
sum(case when attrition = 'Yes' then 1 else 0 end ) as left_company,
round(sum(case when attrition = 'Yes' then 1 else 0 end ) * 100.0 / count(*), 2) as attrition_rate
from hr_employees
group by EducationField
order by attrition_rate desc;
-- Does education background affect attrition?
-- Life Sciences

-- Q9. Department wise average salary
Select 
Department,
JobRole,
round(avg(MonthlyIncome),0) as avg_salary,
count(*) as total_employees,
sum(case when attrition = 'Yes' then 1 else 0 end) as company_left
from hr_employees
group by Department,
JobRole
order by  Department,avg_salary desc;
-- Which roles are underpaid within each department?
-- Sales Representatives and Lab Technicians 
