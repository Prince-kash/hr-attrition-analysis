-- Section 4 — Work Life Factors
-- Q14. Work life balance vs attrition
Select WorkLifeBalance,
case WorkLifeBalance
 WHEN 1 THEN 'Bad'
        WHEN 2 THEN 'Good'
        WHEN 3 THEN 'Better'
        WHEN 4 THEN 'Best'
    END AS balance_label,
    count(*) as total_employees,
sum(case when Attrition ='Yes' then 1 else 0 end) as company_left,
Round(sum(case when Attrition ='Yes' then 1 else 0 end) * 100.0 / count(*) ) as attrition_rate
from hr_employees
group by WorkLifeBalance, balance_label
order by  attrition_rate desc;

-- Does poor work life balance cause attrition?
-- yes

-- Q15. Job satisfaction vs attrition
    Select JobSatisfaction,
case JobSatisfaction
 WHEN 1 THEN 'Low'
        WHEN 2 THEN 'Medium'
        WHEN 3 THEN 'High'
        WHEN 4 THEN 'Very High'
    END AS Satisfaction_label,
    count(*) as total_employees,
sum(case when Attrition ='Yes' then 1 else 0 end) as company_left,
Round(sum(case when Attrition ='Yes' then 1 else 0 end) * 100.0 / count(*) ) as attrition_rate
from hr_employees
group by JobSatisfaction, Satisfaction_label
order by  attrition_rate desc;
-- Do unhappy employees leave more?
-- Yes

-- Q16. Years at company vs attrition
SELECT 
    CASE 
        WHEN YearsAtCompany <= 1 THEN '0-1 Years'
        WHEN YearsAtCompany BETWEEN 2 AND 5 THEN '2-5 Years'
        WHEN YearsAtCompany BETWEEN 6 AND 10 THEN '6-10 Years'
        ELSE '10+ Years'
    END AS tenure_band,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS left_company,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM hr_employees
GROUP BY tenure_band
ORDER BY attrition_rate DESC;

-- When in their career do employees leave most?
-- 0-1 Years

-- Q17. Distance from home vs attrition
Select 
   case 
   when DistanceFromHome <= 5 then 'near(0-5km)'
   when DistanceFromHome Between 6 And 15 then 'Medium(6-15km)'
   else 'Far(15+km)'
End as distance_band,
   COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS left_company,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM hr_employees
GROUP BY distance_band
ORDER BY attrition_rate DESC;

-- Does long commute cause people to quit?
-- yes
