Use final_project_ecommerce;

Select*From Customers;
Select*From orderdetails;
Select*From Orders;
Select*From products;
Select*From Regions;

-- 1.	General Sales Insights;
-- 1.1.	What is the total revenue generated over the entire period? (Revenue = Product Qty * Price)

Select Round(Sum(OD.Quantity*P.price)) as Revenue
from orderdetails OD 
Join products P on P.ProductID = OD.ProductID;

--  1.2.	Revenue Excluding Returned Orders
Select Round(Sum(OD.Quantity * P.price)) AS Revenue_Excluding_returns_order
From orderdetails OD
Join products P on OD.ProductID = P.ProductID
Join Orders O on OD.orderID = O.orderID
Where O.IsReturned= FALSE;

-- 1.3.	Total Revenue per Year / Month
Select date_format(OrderDate, "%Y-%m-01") As Order_Month, Round(Sum(OD.Quantity * P.price)) As Monthly_Revenue
From orderdetails OD
Join products P on OD.ProductID = P.ProductID
Join Orders O on OD.orderID = O.orderID
Group by Order_Month
Order BY Order_Month;

-- 1.4.	Revenue by Product / Category

Select P.Category,P.ProductName,Round(Sum(OD.Quantity*P.Price)) As Product_Revenue
From Orderdetails OD
Join products P On P.ProductID = OD.ProductID
Join Orders O ON O.OrderID = OD.OrderID
GROUP BY P.Category,P.ProductName
ORDER BY P.Category,P.ProductName;

-- 1.5.	What is the average order value (AOV) across all orders?

-- With Sub Query

Select Round(AVG(Total_Order_Value)) as AVG_Order_Value
From(Select O.OrderID, SUm(OD.Quantity*P.Price) AS Total_Order_Value
From Orderdetails OD
Join Products P on P.ProductID =OD.ProductID
Join Orders O ON O.OrderID = OD.OrderID
Group BY O.OrderID)T;

-- WIth CTE

With Order_Value AS(
	SELECT O.OrderID, Round(SUM(OD.Quantity*P.Price))AS Total_Order_Value
    From OrderDetails OD
    Join Products P ON P.ProductID = OD. ProductID
    JOin Orders O ON O.OrderID = OD.OrderID
    GROUP BY O.OrderID)
Select	AVG(TOtal_Order_Value) AS AVG_Order_Value,
		MAX(TOtal_Order_Value) AS MAX_Order_Value,
        MIN(TOtal_Order_Value) AS MIN_Order_Value
        From Order_Value;
        
-- 1.6.	AOV per Year / Month

SELECT O.OrderID,O.OrderDate, Round(SUM(OD.Quantity*P.Price))AS Total_Order_Value
    From OrderDetails OD
    Join Products P ON P.ProductID = OD. ProductID
    JOin Orders O ON O.OrderID = OD.OrderID
    GROUP BY O.OrderID,O.OrderDate	;

With Order_Value AS(
	SELECT O.OrderID,O.OrderDate, Round(SUM(OD.Quantity*P.Price))AS Total_Order_Value
    From OrderDetails OD
    Join Products P ON P.ProductID = OD. ProductID
    JOin Orders O ON O.OrderID = OD.OrderID
    GROUP BY O.OrderID,O.OrderDate)
Select date_format(OrderDate,"%Y-%m-01")as Order_Year_Month,Round(AVG(Total_Order_Value)) As AVG_Order_Value
From Order_Value
GROUP BY Order_Year_Month;


-- 1.7.	What is the average order size by region?

With Order_Size as(
Select O.OrderID,R.RegionName,Sum(OD.Quantity) AS Total_Order_Size
From OrderDetails OD 
Join Orders O ON O.orderID = OD.OrderID
Join Customers C on C.CustomerID =O.CustomerID
Join Regions R on R.RegionID =C.RegionID 
GROUP BY O.OrderID,R.RegionName)
Select RegionName,Avg(Total_Order_Size) As Avg_Order_Size
From Order_Size
GROUP BY RegionName
ORDER BY Avg_Order_Size desc;
