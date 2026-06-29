CREATE DATABASE telco_churn;
CREATE TABLE telco (
    customerID VARCHAR(20),
    gender VARCHAR(10),
    SeniorCitizen INT,
    Partner VARCHAR(5),
    Dependents VARCHAR(5),
    tenure INT,
    PhoneService VARCHAR(5),
    MultipleLines VARCHAR(20),
    InternetService VARCHAR(20),
    OnlineSecurity VARCHAR(20),
    OnlineBackup VARCHAR(20),
    DeviceProtection VARCHAR(20),
    TechSupport VARCHAR(20),
    StreamingTV VARCHAR(20),
    StreamingMovies VARCHAR(20),
    Contract VARCHAR(20),
    PaperlessBilling VARCHAR(5),
    PaymentMethod VARCHAR(30),
    MonthlyCharges DECIMAL(10,2),
    TotalCharges DECIMAL(10,2),
    Churn VARCHAR(5),
    SeniorCitizen_Label VARCHAR(5),
    Tenure_Group VARCHAR(20),
    Charge_Category VARCHAR(15),
    Churn_Value INT
);

COPY telco
FROM 'C:/telco_clean.csv'
DELIMITER ','
CSV HEADER;

-- 1 — Total Customers and Churn Count
SELECT 
    COUNT(*) AS Total_Customers,
    SUM(Churn_Value) AS Total_Churned,
    ROUND(AVG(Churn_Value::NUMERIC) * 100, 2) AS Churn_Rate_Pct
FROM telco;

--2 — Churn by Gender
SELECT 
    gender,
    COUNT(*) AS Total_Customers,
    SUM(Churn_Value) AS Churned,
    ROUND(AVG(Churn_Value::NUMERIC) * 100, 2) AS Churn_Rate_Pct
FROM telco
GROUP BY gender;

-- 3 — Churn by Contract Type
SELECT 
    Contract,
    COUNT(*) AS Total_Customers,
    SUM(Churn_Value) AS Churned,
    ROUND(AVG(Churn_Value::NUMERIC) * 100, 2) AS Churn_Rate_Pct
FROM telco
GROUP BY Contract
ORDER BY Churn_Rate_Pct DESC;

--4 — Churn by Internet Service
SELECT 
    InternetService,
    COUNT(*) AS Total_Customers,
    SUM(Churn_Value) AS Churned,
    ROUND(AVG(Churn_Value::NUMERIC) * 100, 2) AS Churn_Rate_Pct
FROM telco
GROUP BY InternetService
ORDER BY Churn_Rate_Pct DESC;
--5 — Churn by Tenure Group
SELECT 
    Tenure_Group,
    COUNT(*) AS Total_Customers,
    SUM(Churn_Value) AS Churned,
    ROUND(AVG(Churn_Value::NUMERIC) * 100, 2) AS Churn_Rate_Pct
FROM telco
GROUP BY Tenure_Group
ORDER BY Churn_Rate_Pct DESC;

-- 6 — Churn by Payment Method
SELECT 
    PaymentMethod,
    COUNT(*) AS Total_Customers,
    SUM(Churn_Value) AS Churned,
    ROUND(AVG(Churn_Value::NUMERIC) * 100, 2) AS Churn_Rate_Pct
FROM telco
GROUP BY PaymentMethod
ORDER BY Churn_Rate_Pct DESC;

--7 — Churn by Senior Citizen
SELECT 
    SeniorCitizen_Label AS Senior_Citizen,
    COUNT(*) AS Total_Customers,
    SUM(Churn_Value) AS Churned,
    ROUND(AVG(Churn_Value::NUMERIC) * 100, 2) AS Churn_Rate_Pct
FROM telco
GROUP BY SeniorCitizen_Label;

--8 — Average Monthly Charges (Churned vs Retained)
SELECT 
    Churn,
    ROUND(AVG(MonthlyCharges::NUMERIC), 2) AS Avg_Monthly_Charges,
    ROUND(AVG(TotalCharges::NUMERIC), 2) AS Avg_Total_Charges
FROM telco
GROUP BY Churn;

-- 9 — Churn by Charge Category
SELECT 
    Charge_Category,
    COUNT(*) AS Total_Customers,
    SUM(Churn_Value) AS Churned,
    ROUND(AVG(Churn_Value::NUMERIC) * 100, 2) AS Churn_Rate_Pct
FROM telco
GROUP BY Charge_Category
ORDER BY Churn_Rate_Pct DESC;

--10 — Churn by Tech Support and Online Security
SELECT 
    TechSupport,
    OnlineSecurity,
    COUNT(*) AS Total_Customers,
    SUM(Churn_Value) AS Churned,
    ROUND(AVG(Churn_Value::NUMERIC) * 100, 2) AS Churn_Rate_Pct
FROM telco
GROUP BY TechSupport, OnlineSecurity
ORDER BY Churn_Rate_Pct DESC;