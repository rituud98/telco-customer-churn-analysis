# Telco Customer Churn Analysis Dashboard

## Project Overview

An end-to-end data analytics project analyzing customer churn behavior for a telecom company. The project covers data cleaning in Excel, business insights using SQL (PostgreSQL), and an interactive Power BI dashboard — helping the business identify **why customers leave** and **what can be done to retain them**.

---

## Business Problem

The telecom company is losing customers every month. Management wants to understand:
- What is the overall churn rate?
- Which customer segments are most likely to churn?
- Does contract type affect churn?
- Does monthly charge amount influence churn decisions?
- Which payment methods are associated with higher churn?

---

##  Tools Used

| Tool | Purpose |
|---|---|
| Microsoft Excel | Data cleaning, calculated columns |
| PostgreSQL (pgAdmin) | Business queries and insight generation |
| Power BI Desktop | Interactive dashboard and visualization |

---

## Dataset

- **Source:** [Telco Customer Churn — Kaggle (IBM Dataset)](https://www.kaggle.com/datasets/blastchar/telco-customer-churn)
- **Rows:** 7,043 customers
- **Columns:** 21 fields including Contract, InternetService, MonthlyCharges, TotalCharges, Churn

---

## Step 1 — Data Cleaning (Excel)

- Handled blank values in `TotalCharges` column
- Added **SeniorCitizen_Label** column: converted 0/1 to Yes/No for readability
- Added **Tenure_Group** column to group customers by tenure:
  - 0–12 Months, 13–24 Months, 25–48 Months, 49–60 Months, 61–72 Months
- Added **Charge_Category** column: Low, Medium, High based on MonthlyCharges
- Added **Churn_Value** column: converted Yes/No to 1/0 for calculations
- Saved clean dataset as `telco_clean.csv`

---

##  Step 2 — SQL Analysis (PostgreSQL)

Key business questions answered using SQL:

```sql
-- Total Customers and Churn Rate
SELECT 
    COUNT(*) AS Total_Customers,
    SUM(Churn_Value) AS Total_Churned,
    ROUND(AVG(Churn_Value::NUMERIC) * 100, 2) AS Churn_Rate_Pct
FROM telco;

-- Churn by Contract Type
SELECT 
    Contract,
    COUNT(*) AS Total_Customers,
    SUM(Churn_Value) AS Churned,
    ROUND(AVG(Churn_Value::NUMERIC) * 100, 2) AS Churn_Rate_Pct
FROM telco
GROUP BY Contract
ORDER BY Churn_Rate_Pct DESC;

-- Churn by Payment Method
SELECT 
    PaymentMethod,
    COUNT(*) AS Total_Customers,
    SUM(Churn_Value) AS Churned,
    ROUND(AVG(Churn_Value::NUMERIC) * 100, 2) AS Churn_Rate_Pct
FROM telco
GROUP BY PaymentMethod
ORDER BY Churn_Rate_Pct DESC;

-- Average Monthly Charges (Churned vs Retained)
SELECT 
    Churn,
    ROUND(AVG(MonthlyCharges::NUMERIC), 2) AS Avg_Monthly_Charges,
    ROUND(AVG(TotalCharges::NUMERIC), 2) AS Avg_Total_Charges
FROM telco
GROUP BY Churn;
```

---

## Step 3 — Power BI Dashboard

### KPI Cards
| Metric | Value |
|---|---|
| Total Customers | 7K |
| Total Churned | 2K |
| Churn Rate % | 26.54% |
| Retained Customers | 5K |
| Avg Monthly Charge | $64.76 |

### Visuals Built
- **Bar Chart** — Churn by Contract Type
- **Donut Chart** — Churned by Internet Service
- **Bar Chart** — Churn by Payment Method
- **Bar Chart** — Avg Monthly Charges (Churned vs Retained)
- **Line Chart** — Churn by Tenure Group

### Slicers (Interactive Filters)
- Tenure Group (0–12, 13–24, 25–48, 49–60, 61–72 Months)
- Contract Type (Month-to-month, One year, Two year)
- Internet Service (DSL, Fiber optic, No)

---

##  Key Insights

- Overall churn rate is **26.54%** — more than 1 in 4 customers are leaving
- **Month-to-month contract** customers churn the most (43%) compared to One year (11%) and Two year (3%) — long term contracts significantly improve retention
- **Fiber optic** internet service users have the highest churn at **69.4%** of all churned customers
- **Electronic check** payment method has the highest churn rate (45%) — suggests these customers are less committed
- Churned customers pay **$74 avg monthly** vs retained customers at **$61** — higher charges are linked to churn
- Customers in **0–12 months tenure** group churn the most (47) — new customers are at highest risk


---

## Dashboard Preview

<img width="1366" height="768" alt="Screenshot (38)" src="https://github.com/user-attachments/assets/017abd0d-7917-45cf-99f7-47957550b7b7" />


---

## How to Run This Project

1. Download `telco_clean.csv` 
2. Import into PostgreSQL using the script 
3. Open `Telco_Customer_Churn_Dashboard.pbix` in Power BI Desktop
4. Refresh the data source to point to your local CSV file
5. Explore the interactive dashboard using slicers!
