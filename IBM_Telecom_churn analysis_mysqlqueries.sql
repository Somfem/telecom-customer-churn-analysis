-- Find the top 10 cities generating the highest total revenue.
select loc.city, sum(pay.total_revenue) as sum_total_revenue
from location_data as loc
join payment_info as pay
on loc.customer_id = pay.customer_id
group by loc.city
order by sum_total_revenue desc
limit 10;

-- Which contract type generates the highest total revenue?
select contract, sum(total_revenue) as total_revenue
from payment_info
group by contract
order by total_revenue desc;

-- Is the revenue based on contract type from higher prices or higher rentention
select contract, avg(monthly_charges) as avg_monthly_charges
from payment_info
group by contract
order by avg_monthly_charges desc;

-- Which contract type has the highest churn rate?
SELECT pay.contract,
       COUNT(*) AS total_customers,
       SUM(CASE WHEN stat.churn_label = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
       ROUND(
       SUM(CASE WHEN stat.churn_label = 'Yes' THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS churn_rate
FROM payment_info pay
JOIN status_analysis stat
ON pay.customer_id = stat.customer_id
GROUP BY pay.contract;

-- Do customers with higher monthly charges churn more?
SELECT 
CASE
    WHEN pay.monthly_charges < 50 THEN 'Low'
    WHEN pay.monthly_charges BETWEEN 50 AND 80 THEN 'Medium'
    ELSE 'High'
END AS charge_category,

COUNT(*) AS total_customers,

SUM(CASE WHEN stat.churn_label = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,

ROUND(
    SUM(CASE WHEN stat.churn_label = 'Yes' THEN 1 ELSE 0 END) / COUNT(*) * 100,
    2
) AS churn_rate_pct

FROM payment_info pay
JOIN status_analysis stat
ON pay.customer_id = stat.customer_id

GROUP BY charge_category;

-- Which cities have the highest churn rates?
select count(*) total_customers, loc.city,
sum(case when stat.churn_label = 'Yes' then 1 else 0 end) as churned_customers,
round( 
Sum(case when stat.churn_label = 'Yes' then 1 else 0 end)/count(*) *100) as churn_perct
from location_data loc
join status_analysis stat
on loc.customer_id = stat.customer_id
group by loc.city
HAVING COUNT(*) > 30
order by churn_perct desc;

-- Top 10 cities generating the highest total revenue.
select loc.city, SUM(pay.total_revenue) as total_revenue
from location_data loc
join payment_info pay
on loc.customer_id = pay.customer_id
group by city
order by total_revenue desc
limit 10;

-- Which cities generate the most revenue but also have high churn rates?
select loc.city, sum(pay.total_revenue) as total_revenue, 
sum(case when stat.churn_label = 'Yes' then 1 else 0 end)/ count(*)*100 as churn_rate_perct
from payment_info pay
join location_data loc on pay.customer_id = loc.customer_id
join status_analysis stat on loc.customer_id = stat.customer_id
group by city
HAVING COUNT(*) >= 30 
order by total_revenue desc, churn_rate_perct desc;

-- Which contract type produces the highest revenue per customer (think average)?

SELECT contract,
       AVG(total_revenue) AS avg_revenue_per_customer
FROM payment_info
GROUP BY contract
ORDER BY avg_revenue_per_customer DESC;

-- Which contract type has the highest average monthly charge
SELECT contract,
       AVG(monthly_charges) AS avg_monthly_charge
FROM payment_info
GROUP BY contract
ORDER BY avg_monthly_charge DESC;

-- Which cities have the highest revenue per customer?
select loc.city, avg(pay.total_revenue) as avg_revenue_per_customer
from payment_info pay
join location_data loc
on loc.customer_id = pay.customer_id
group by city
HAVING COUNT(*) >= 30 -- we add having to filter out cities with small number of customers becus they will have high average over larger cities
order by avg_revenue_per_customer desc;

-- Total customers in each city
select city, count(*) as total_customers
from location_data
group by city
order by total_customers desc;

-- Which cities generate the most revenue per customer but also have high churn rates?
select loc. city, avg(pay.total_revenue) as avg_total_revenue_per_customer,
sum(case when stat.churn_label = 'Yes' then 1 else 0 end)/ count(*) *100 as churn_rates_perct
from location_data loc
join payment_info pay on loc.customer_id = pay.customer_id
join status_analysis stat on pay.customer_id = stat.customer_id
group by city
Having count(*) >= 30   
ORDER BY churn_rates_perct DESC, avg_total_revenue_per_customer DESC
;
-- Do senior citizens churn more than younger customers

Select case 
when under_30 = 'Yes' then 'under_30'
when senior_citizen = 'Yes' then 'senior_citizen'
    when middle_age = 'Yes' then 'middle_age' 
    else 0
    end as age_group, count(*) as total_customers,
    sum(case when stat.churn_label = 'Yes' then 1 else 0 end) / count(*) * 100 as churned_perct
from customer_info cus
join status_analysis stat 
on cus.customer_id = stat.customer_id
group by age_group
;

-- Which contract type has the highest churn rate among high-revenue customers?
SELECT pay.contract,
       COUNT(*) AS total_high_revenue_customers,
       ROUND(
           SUM(CASE WHEN stat.churn_label = 'Yes' THEN 1 ELSE 0 END) / COUNT(*) * 100,
           2
       ) AS churn_rate_pct
FROM payment_info pay
JOIN status_analysis stat
     ON pay.customer_id = stat.customer_id
WHERE pay.total_revenue > 5000
GROUP BY pay.contract
ORDER BY churn_rate_pct DESC;

-- Which contract type loses the most revenue due to churn?
SELECT pay.contract,
       SUM(pay.total_revenue) AS lost_revenue
FROM payment_info pay
JOIN status_analysis stat
ON pay.customer_id = stat.customer_id
WHERE stat.churn_label = 'Yes'
GROUP BY pay.contract
ORDER BY lost_revenue DESC;










