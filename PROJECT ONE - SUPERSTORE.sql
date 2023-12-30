SELECT *
FROM Superstore_data

--REGION WITH THE HIGHEST SALES
SELECT Region, ROUND (SUM(Sales), 2) AS Total_Sales 
FROM Superstore_data
GROUP BY Region
ORDER BY Total_Sales DESC
--- THE CENTRAL REGION POST THE HIGHEST SALES---

--REGION WITH THE HIGHEST PROFIT IN SALES---
SELECT Region, ROUND(SUM(Profit), 2) AS Total_Profit
FROM Superstore_data
GROUP BY Region
ORDER BY Total_Profit DESC
---THE CENTRAL REGION POST THE HIGHEST PROFIT---

--WHICH SUB-CATEGORY HAVE GENERATED THE MOST POFIT--
SELECT [Product Sub-Category], ROUND (SUM(Profit), 0) AS Total_Profit
FROM Superstore_data
GROUP BY [Product Sub-Category]
ORDER BY Total_Profit DESC
---TELEPHONES AND COMMUNICATION ARE THE MOST PROFITABLE INVENTORY FOR THE COMPANY---

--SALES BY CUSTOMERS FOR THE YEAR-- I WANT CUSTOMER WITH HIGHEST SALES--
SELECT TOP 5 [Customer Name], Sales, SUM(Sales) AS Customers_Sales
FROM Superstore_data
GROUP BY [Customer Name], Sales
ORDER BY Customers_Sales DESC

SELECT DISTINCT TOP 5 [Customer Name], SUM(Sales) AS Customers_Sales 
FROM Superstore_data
GROUP BY [Customer Name]
ORDER BY Customers_Sales DESC

---MAXIMUM SALES ACHIEVED---
SELECT MAX(Sales) AS MAX_SALES
FROM Superstore_data

---Total sales from California---
SELECT COUNT ([Customer Name]) AS Total_customers_in_Califonia
FROM Superstore_data
WHERE [State or Province] = 'California'

---PRODUCT CATEGORY WITH HIGHEST SALES AND PROFIT--
SELECT [Product Category], SUM(Sales) as Total_Sales
FROM Superstore_data
GROUP BY [Product Category]
ORDER BY Total_Sales DESC

SELECT [Product Category], SUM(Profit) AS TOTAL_PROFIT
FROM Superstore_data
GROUP BY [Product Category]
ORDER BY TOTAL_PROFIT DESC

---PRODUCT CATEGORY WITH HIGHEST SHIPPING COST--
SELECT [Product Category],ROUND(SUM([Shipping Cost]),2) AS Shipping_Cost
FROM Superstore_data
GROUP BY [Product Category]
ORDER BY Shipping_Cost DESC

---CUSTOMER WITH THE HIGHEST SALES---
SELECT DISTINCT ([Customer Name]), SUM (Sales) AS TOTALSALES
FROM Superstore_data
GROUP BY [Customer Name]
ORDER BY TOTALSALES DESC

SELECT [Customer Name], Sales
FROM Superstore_data
WHERE [Customer Name] = 'Gordon Brandt'

---SALES MADE FROM JANUARY 2013 AND ABOVE---
SELECT *
FROM Superstore_data
WHERE [Ship Date] > '2013-01-01'

---COMMISSION FOR CUSTOMERS WITH NO DISCOUNT AND SALES ABOVE 5000---
SELECT DISTINCT([Customer Name]), SUM(Sales) AS TOTALSALES, SALES *0.1 AS COMMISSION
FROM Superstore_data
WHERE Discount = 0 
AND Sales >5000
GROUP BY [Customer Name], Sales
ORDER BY TOTALSALES DESC

---OUTPUT LIST OF CUSTOMERS THAT RETURNED PRODUCT AND THE PRODUCT NAME--
SELECT [Customer Name],[Product Name],Status
FROM Superstore_data 
INNER JOIN Returns$
ON Superstore_data.[Order ID] = Returns$.[Order ID]


---AVERAGE SALES > 5000 WITH 10% COMMISSION USING CTE----
WITH BONUSTABLE AS
(
SELECT [Customer Name], ROUND(AVG(Sales),0) AS AVERAGESALES
FROM Superstore_data
GROUP BY [Customer Name]
)
SELECT *, (AVERAGESALES*0.1 + 100) AS BONUS 
FROM BONUSTABLE
WHERE AVERAGESALES > 5000

---SUB QUERY---
SELECT *, (AVERAGESALES *0.10)AS BONUS
FROM
(
SELECT DISTINCT [Customer Name], ROUND(AVG(Sales),0) AS AVERAGESALES
FROM Superstore_data
GROUP BY [Customer Name]
) TABLE1
WHERE AVERAGESALES > 1000
ORDER BY AVERAGESALES DESC

---OUTPUT SALES FIGURES ACCORDING TO DAILY, MONTHLY AND YEARLY SALES MADE---

SELECT
DAY([Order Date]) AS Daily_Sales,
COUNT([Order ID]) AS Total_orders,
ROUND(SUM(Sales), 2) AS Sales
FROM Superstore_data
GROUP BY DAY([Order Date])
ORDER BY Daily_Sales

SELECT 
MONTH([Order Date]) AS Monthly_Sales, 
COUNT([Order ID]) AS Total_Order,
ROUND(SUM (Sales),2) AS Total_sales
FROM Superstore_data
GROUP BY MONTH([Order Date])
ORDER BY Monthly_Sales

SELECT
YEAR([Order Date]) AS yearly_Sales,
COUNT([Order ID]) AS Total_orders,
ROUND(SUM(Sales), 2) AS Sales
FROM Superstore_data
GROUP BY YEAR([Order Date])
ORDER BY yearly_Sales

SELECT 
    DATENAME(dw, [Order Date]) AS Days,
    COUNT([Order ID]) AS Total_Orders,
    SUM(SALES) AS Total_Sales
FROM Superstore_data
GROUP BY DATENAME(dw, [Order Date])
ORDER BY DATENAME(dw, [Order Date]) 

SELECT 
    DATENAME(month, [Order Date]) AS month,
    COUNT([Order ID]) AS Total_Orders,
    SUM(SALES) AS Total_Sales
FROM Superstore_data
GROUP BY DATENAME(month, [Order Date])
ORDER BY DATENAME(month, [Order Date])

---OUTPUT DIFFERENCES IN ORDERING AND SHIPMENT DATE--

SELECT
 [Customer Name], [Product Sub-Category], [Product Category], [Order Date], [Ship Date], DATEDIFF(day,[Order Date],[Ship Date]) AS daysdifference
FROM Superstore_data
ORDER BY daysdifference DESC