# 📊 E-Commerce Sales Analysis using SQL

## 📌 Project Overview

This project analyzes an e-commerce dataset to extract key business insights related to sales performance, customer behavior, and regional demand using SQL.

The goal is to simulate real-world business scenarios and answer critical questions that help stakeholders make data-driven decisions.

---

## 📂 Dataset Tables

* Customers
* Orders
* OrderDetails
* Products
* Regions

---

## 🔍 Key Business Questions Solved

### 1. General Sales Insights

* Total Revenue generated
* Revenue excluding returned orders
* Monthly & yearly revenue trends
* Revenue by product and category

### 2. Customer & Order Analysis

* Average Order Value (AOV)
* AOV trends by month/year
* Order-level revenue calculation

### 3. Regional Analysis

* Average order size by region
* Demand insights for expansion strategy

---

## 🛠 SQL Concepts Used

* Joins (INNER JOIN, multiple table joins)
* Aggregations (SUM, AVG, COUNT)
* CTEs (Common Table Expressions)
* Subqueries
* CASE statements
* Date functions (`DATE_FORMAT`)
* Grouping & sorting

---

## 📊 Sample Query (AOV using CTE)

```sql
WITH Order_Value AS (
    SELECT 
        O.OrderID,
        SUM(OD.Quantity * P.Price) AS Total_Order_Value
    FROM OrderDetails OD
    JOIN Products P ON P.ProductID = OD.ProductID
    JOIN Orders O ON O.OrderID = OD.OrderID
    GROUP BY O.OrderID
)

SELECT AVG(Total_Order_Value) AS Avg_Order_Value
FROM Order_Value;
```

---

## 📈 Key Insights

* Revenue trends highlight seasonal patterns
* Certain products and categories contribute major revenue
* Regional analysis identifies high-demand areas
* AOV helps understand customer purchasing behavior

---

## 🚀 How to Use

1. Import dataset into MySQL
2. Run the SQL queries provided
3. Modify queries to explore additional insights

---

## 🎯 Skills Demonstrated

* Data Analysis using SQL
* Business problem solving
* Data aggregation & transformation
* Analytical thinking

---

## 📌 Future Enhancements

* Power BI dashboard integration
* Customer segmentation (RFM Analysis)
* Predictive analytics

---

## 🤝 Connect with Me

If you found this project useful or have suggestions, feel free to connect!

---

