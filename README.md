# IBM Telecom Customer Churn Analysis

## Project Overview
Customer churn is a major challenge in the telecom industry because losing existing customers directly impacts revenue and acquisition costs. This project analyzes the IBM Telecom Customer Churn dataset using SQL and Power BI to identify patterns associated with customer attrition and uncover factors that influence customer retention.
## Objective
The goal of this analysis is to understand the key drivers of churn and provide insights that could help telecom companies improve customer retention strategies.

## Dataset
## Dataset
The dataset used in this project is the IBM Telecom Customer Churn dataset from kaggle, which contains customer-level information on telecom subscribers.

Key attributes include:
- Customer demographics
- Subscription services
- Monthly charges
- Contract type
- Customer tenure
- Churn status

## Tools Used
- SQL (MySQL) for data exploration and aggregation techniques
- Power BI for Data visualization

## Key Questions
1. Which customer segments experience the highest churn rates?
2. How does contract type influence customer churn?
3. Is there a relationship between monthly charges and churn probability?

## Key Insights
- Customers on month-to-month contracts exhibited the highest churn rates compared to those on longer-term contracts.
- Higher monthly charges were associated with increased churn likelihood.
- Customers with longer-term contracts demonstrated significantly higher retention.

## Business Recommendations
Based on the analysis, telecom companies may consider:
- Encouraging customers to transition from month-to-month contracts to longer-term plans.
- Monitoring customers with high monthly charges and offering targeted retention incentives.
- Developing loyalty programs for customers approaching contract renewal periods.

## Files in This Repository
- `data_cleaning.sql` – SQL queries used to prepare and clean the dataset
- `exploratory_analysis.sql` – queries used for exploratory data analysis
- `churn_analysis.sql` – analysis queries used to identify churn patterns
- `powerbi_dashboard.pbix` – Power BI dashboard visualizing churn insights
