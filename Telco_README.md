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
```
<img width="381" height="77" alt="Screenshot (44)" src="https://github.com/user-attachments/assets/7c7d2035-6ddf-4124-bf0a-12c9055698fb" />
```sql
-- Churn by Gender
SELECT 
    gender,
    COUNT(*) AS Total_Customers,
    SUM(Churn_Value) AS Churned,
    ROUND(AVG(Churn_Value::NUMERIC) * 100, 2) AS Churn_Rate_Pct
FROM telco
GROUP BY gender;
```
<img width="498" height="102" alt="Screenshot (45)" src="https://github.com/user-attachments/assets/6f84520b-801c-4a00-888b-901b21061b09" />

```sql
-- Churn by Contract Type
SELECT 
    Contract,
    COUNT(*) AS Total_Customers,
    SUM(Churn_Value) AS Churned,
    ROUND(AVG(Churn_Value::NUMERIC) * 100, 2) AS Churn_Rate_Pct
FROM telco
GROUP BY Contract
ORDER BY Churn_Rate_Pct DESC;
```
<img width="507" height="101" alt="Screenshot (46)" src="https://github.com/user-attachments/assets/c068730d-bf2c-45df-b69b-d10536eb22b2" />

```sql
-- Churn by Internet Service
SELECT 
    InternetService,
    COUNT(*) AS Total_Customers,
    SUM(Churn_Value) AS Churned,
    ROUND(AVG(Churn_Value::NUMERIC) * 100, 2) AS Churn_Rate_Pct
FROM telco
GROUP BY InternetService
ORDER BY Churn_Rate_Pct DESC;
```
<img width="502" height="97" alt="Screenshot (47)" src="https://github.com/user-attachments/assets/e68a9cab-bb93-47d4-b3d0-609764d915eb" />

```sql
-- Churn by Tenure Group
SELECT 
    Tenure_Group,
    COUNT(*) AS Total_Customers,
    SUM(Churn_Value) AS Churned,
    ROUND(AVG(Churn_Value::NUMERIC) * 100, 2) AS Churn_Rate_Pct
FROM telco
GROUP BY Tenure_Group
ORDER BY Churn_Rate_Pct DESC;
```
<img width="497" height="167" alt="Screenshot (48)" src="https://github.com/user-attachments/assets/ebc3fa29-5b7f-4429-8b1b-93f7c040cdd5" />

```sql
-- Churn by Payment Method
SELECT 
    PaymentMethod,
    COUNT(*) AS Total_Customers,
    SUM(Churn_Value) AS Churned,
    ROUND(AVG(Churn_Value::NUMERIC) * 100, 2) AS Churn_Rate_Pct
FROM telco
GROUP BY PaymentMethod
ORDER BY Churn_Rate_Pct DESC;
```
<img width="512" height="138" alt="Screenshot (49)" src="https://github.com/user-attachments/assets/188cfccf-65d1-4d72-a9e8-c9b3a239eff9" />
```sql
-- Churn by Senior Citizen
SELECT 
    SeniorCitizen_Label AS Senior_Citizen,
    COUNT(*) AS Total_Customers,
    SUM(Churn_Value) AS Churned,
    ROUND(AVG(Churn_Value::NUMERIC) * 100, 2) AS Churn_Rate_Pct
FROM telco
GROUP BY SeniorCitizen_Label;
```
<img width="493" height="87" alt="image" src="https://github.com/user-attachments/assets/86943528-0616-4f0d-bbd1-6ff2c0f98f28" />

```sql
-- Average Monthly Charges (Churned vs Retained)
SELECT 
    Churn,
    ROUND(AVG(MonthlyCharges::NUMERIC), 2) AS Avg_Monthly_Charges,
    ROUND(AVG(TotalCharges::NUMERIC), 2) AS Avg_Total_Charges
FROM telco
GROUP BY Churn;
```
<img width="467" height="94" alt="image" src="https://github.com/user-attachments/assets/750bb2b2-6c4f-4ffb-ac52-e2715c624746" />
```sql
-- Churn by Charge Category:
SELECT 
    Charge_Category,
    COUNT(*) AS Total_Customers,
    SUM(Churn_Value) AS Churned,
    ROUND(AVG(Churn_Value::NUMERIC) * 100, 2) AS Churn_Rate_Pct
FROM telco
GROUP BY Charge_Category
ORDER BY Churn_Rate_Pct DESC;
```
<img width="500" height="154" alt="image" src="https://github.com/user-attachments/assets/8eb462ba-b5fb-4e2c-99e5-a61b97788efc" />
```sql
-- Churn by Tech Support and Online Security
SELECT 
    TechSupport,
    OnlineSecurity,
    COUNT(*) AS Total_Customers,
    SUM(Churn_Value) AS Churned,
    ROUND(AVG(Churn_Value::NUMERIC) * 100, 2) AS Churn_Rate_Pct
FROM telco
GROUP BY TechSupport, OnlineSecurity
ORDER BY Churn_Rate_Pct DESC;
```
<img width="645" height="168" alt="image" src="https://github.com/user-attachments/assets/eea6a18b-4b6d-4973-ad89-b71b05212a63" />


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

<img width="740" height="472" alt="Dashboard_preview (2)" src="https://github.com/user-attachments/assets/054a53ce-4a8d-4dcb-ac2b-8e403aa0a6bd" />



---

## How to Run This Project

1. Download `telco_clean.csv` 
2. Import into PostgreSQL using the script 
3. Open `Telco_Customer_Churn_Dashboard.pbix` in Power BI Desktop
4. Refresh the data source to point to your local CSV file
5. Explore the interactive dashboard using slicers!
