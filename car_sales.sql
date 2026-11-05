create database car_dataset;
use car_dataset;
select * from car_sales;
-- Part 1 — Overall KPIs 
-- 1. Overall Car Sales KPIs 
--Calculate:  Total number of cars sold 
select COUNT(Car_id) AS Total_Cars_Sold from car_sales;

-- Total sales amount
    select SUM(Price) AS Total_Sales_Amount from car_sales;

-- Average car price
    select AVG(Price) AS Average_Car_Price from car_sales;

 --Highest car price
   select MAX(Price) AS Highest_Car_Price from car_sales;

-- Lowest car price
   select MIN(Price) AS Lowest_Car_Price from car_sales;

-- Number of unique customers 
   select COUNT(DISTINCT Customer_Name) AS Unique_Customers FROM car_sales;

 --2. Average Sales Per Customer 
 --Find: Total sales 
  select SUM(Price) AS Total_Sales from car_sales;
      
 -- Total customers 
   select COUNT(DISTINCT Customer_Name) AS Total_Customers from car_sales;

 --Average sales per customer 
  select SUM(Price) / COUNT(DISTINCT Customer_Name) AS Average_Sales_Per_Customer FROM car_sales;
  
  --Part 2 — Dealer and Company Analysis 
  --3. Dealer Performance For each dealer, 
  --calculate: Number of cars sold
  SELECT Dealer_Name,
  COUNT(*) AS Number_of_Cars_Sold FROM car_sales GROUP BY Dealer_Name ORDER BY SUM(Price) DESC;

  --Total sales 
  select Dealer_Name,SUM(Price) AS Total_Sales FROM car_sales GROUP BY Dealer_Name ORDER BY SUM(Price) DESC;

  --Average car price Display dealers from highest to lowest total sales. 
  select Dealer_Name, AVG(Price) AS Average_Car_Price FROM car_sales GROUP BY Dealer_Name ORDER BY SUM(Price)DESC;

 -- 4. Company Performance For each car company,
 --calculate:Number of cars sold 
 SELECT Company,COUNT(*) AS Number_of_Cars_Sold FROM car_sales GROUP BY Company ORDER BY SUM(Price) DESC;

 --Total sales 
  select SUM(Price) AS Total_Sales FROM car_sales GROUP BY Company ORDER BY SUM(Price) DESC;

 --Average car price Display companies from highest to lowest total sales. 
  select AVG(Price) AS Average_Car_Price FROM car_sales GROUP BY Company ORDER BY SUM(Price) DESC;

  --5. Model Performance
  --Find the top 10 car models based on total sales.
  --Display:  Company  Model  Number of cars sold  Total sales  Average price 
  SELECT TOP 10
    Company,
    Model,
    COUNT(*) AS Number_of_Cars_Sold,
    SUM(Price) AS Total_Sales,
    AVG(Price * 1.0) AS Average_Price
FROM Car_Sales
GROUP BY Company, Model
ORDER BY Total_Sales DESC;

--6. Dealer Region Performance For each dealer region, 
--calculate: Number of cars sold 
SELECT Dealer_Region,
COUNT(*) AS Number_of_Cars_Sold FROM Car_Sales GROUP BY Dealer_Region ORDER BY SUM(Price) DESC;
    
--Total sales
 select SUM(Price) AS Total_Sales FROM Car_Sales GROUP BY Dealer_Region ORDER BY Total_Sales DESC;

--Average car price Display the regions from highest to lowest sales. 
 select AVG(Price * 1.0) AS Average_Price FROM Car_Sales GROUP BY Dealer_Region ORDER BY SUM(Price) DESC;


 --Part 3 — Customer Analysis 
 --7. Gender-Based Sales Analysis For each gender, 
 --calculate:  Number of cars purchased 
 SELECT Gender,COUNT(*) AS Number_of_Cars_Purchased FROM Car_Sales GROUP BY Gender ORDER BY SUM(Price) DESC;

---- Total sales 
SELECT Gender,SUM(Price) AS Total_Sales FROM Car_Sales GROUP BY Gender ORDER BY Total_Sales DESC;

-- Average car price
SELECT Gender,ROUND(AVG(Price * 1.0), 2) AS Average_Price FROM Car_Sales GROUP BY Gender ORDER BY SUM(Price) DESC;

-- Average annual income 
SELECT Gender,ROUND(AVG([Annual_Income] * 1.0), 2) AS Average_Annual_Income
FROM Car_Sales GROUP BY Gender ORDER BY SUM(Price) DESC;

--8. Customer Income Analysis 
--Find customers whose annual income is greater than 100,000. 
--Display:  Customer Name  Annual Income  Company  Model  Price  Dealer Region 
SELECT Customer_Name,Annual_Income,Company,Model,Price AS Price,Dealer_Region
FROM Car_Sales WHERE Annual_Income > 100000 ORDER BY Annual_Income DESC;

--9. Top 5 Customers Based on Car Price 
--Find the top 5 customers who purchased the most expensive cars.
--Display:  Customer Name  Company  Model  Price  Annual Income
SELECT TOP 5 Customer_Name,Company,Model,Price AS Price,Annual_Income
FROM Car_Sales ORDER BY Price DESC;

--Part 4 — Car Analysis
--10. Body Style Analysis For each body style, 
--calculate:  Number of cars sold 
SELECT Body_Style, COUNT(*) AS Number_of_Cars_Sold FROM Car_Sales GROUP BY Body_Style ORDER BY SUM(Price)DESC;

-- Total sales
SELECT Body_Style,SUM(Price) AS Total_Sales FROM Car_Sales GROUP BY Body_Style ORDER BY Total_Sales DESC;

-- Average car price Display the body styles from highest to lowest sales. 
SELECT Body_Style,ROUND(AVG(Price * 1.0), 2) AS Average_Price FROM Car_Sales GROUP BY Body_Style ORDER BY SUM(Price) DESC;

--11. Transmission Analysis Compare cars sold with different transmission types. For each transmission type, 
--calculate:  Number of cars sold 
SELECT Transmission,COUNT(*) AS Number_of_Cars_Sold FROM Car_Sales
GROUP BY Transmission ORDER BY SUM(Price) DESC;

-- Total sales 
SELECT Transmission, SUM(Price) AS Total_Sales FROM Car_Sales
GROUP BY Transmission ORDER BY Total_Sales DESC;

-- Average car price 
SELECT Transmission,ROUND(AVG(Price * 1.0), 2) AS Average_Price
FROM Car_Sales GROUP BY Transmission ORDER BY SUM(Price) DESC;

--12. Engine Type Analysis For each engine type, 
--calculate:  Number of cars sold
SELECT Engine,COUNT(*) AS Number_of_Cars_Sold
FROM Car_Sales GROUP BY Engine ORDER BY SUM(Price) DESC;

-- Total sales 
SELECT Engine,SUM(Price) AS Total_Sales FROM Car_Sales GROUP BY Engine ORDER BY Total_Sales DESC;

-- Average car price Show the engine types from highest to lowest total sales. 
SELECT Engine,ROUND(AVG(Price * 1.0), 2) AS Average_Price
FROM Car_Sales GROUP BY Engine ORDER BY SUM(Price) DESC;

--Part 5 — Price Analysis 
--13. Expensive Car Analysis 
--Find all cars where the price is greater than 50,000. 
--Display:  Company  Model  Price  Body Style  Engine  Transmission 
SELECT Company,Model, Price AS Price,Body_Style,Engine,Transmission
FROM Car_Sales WHERE Price > 50000 ORDER BY Price DESC;


--14. Create Price Category Create a new column called price_category. 
--Classify cars as:  Luxury → Price >= 50,000  Premium → Price between 30,000 and 49,999  Economy → Price below 30,000 
 Alter table car_sales
 drop column price_category;

 ALTER TABLE car_sales
 ADD price_category varchar(20);
 
 UPDATE car_sales
 SET price_category=
  CASE
        WHEN Price >= 50000 THEN 'Luxury'
        WHEN Price BETWEEN 30000 AND 49999 THEN 'Premium'
        ELSE 'Economy'
  END;

--Part 6 — Date Analysis 
--15. Yearly Sales Analysis Extract the year from Date. For each year, calculate:
-- Number of cars sold
SELECT YEAR(Date) AS SaleYear,COUNT(*) AS CarsSold FROM car_sales GROUP BY YEAR(date) ORDER BY SaleYear;

-- Total sales 
SELECT YEAR(Date) AS SaleYear,SUM(Price) AS TotalSales FROM car_sales GROUP BY YEAR(date)ORDER BY SaleYear;

-- Average car price
SELECT YEAR(Date) AS SaleYear,AVG(Price) AS TotalSales FROM car_sales GROUP BY YEAR(date)ORDER BY SaleYear;

---16. Monthly Sales Analysis Find total sales for each month. Display:
--Display:
-- Month number 
SELECT MONTH(Date) AS Month_Number FROM car_sales
GROUP BY MONTH(Date),DATENAME(MONTH, Date) ORDER BY SUM(Price) DESC;

-- Month name
SELECT DATENAME(MONTH, Date) AS Month_Name FROM car_sales 
GROUP BY MONTH(Date),DATENAME(MONTH, Date) ORDER BY SUM(Price) DESC;

-- Number of cars sold
SELECT COUNT(*) AS Number_of_Cars_Sold FROM car_sales
GROUP BY MONTH(Date),DATENAME(MONTH, Date) ORDER BY SUM(Price) DESC;

-- Total sales Sort the months based on total sales from highest to lowest.
SELECT SUM(Price) AS Total_Sales FROM car_sales
GROUP BY MONTH(Date),DATENAME(MONTH, Date) ORDER BY SUM(Price) DESC;

----Part 7 — Intermediate Analysis 
---17. Top Dealer in Each Region Find the dealer with the highest total sales in each dealer region. Display:
-- Dealer Region
SELECT dealer_region,SUM(price) AS TotalSales FROM car_sales 
GROUP BY dealer_region, dealer_name ORDER BY dealer_region, TotalSales DESC;

-- Dealer Name 
SELECT dealer_name,SUM(price) AS TotalSales FROM car_sales 
GROUP BY dealer_region, dealer_name ORDER BY dealer_region, TotalSales DESC;

--- Total Sales
SELECT Dealer_region,dealer_name,SUM(price) AS TotalSales FROM car_sales 
GROUP BY dealer_region, dealer_name ORDER BY dealer_region, TotalSales DESC;

---18. Rank Companies Based on Total Sales Calculate the total sales for each company and rank them from highest to lowest. Display: 
--- Company 
SELECT company,SUM(price) AS TotalSales FROM car_sales GROUP BY company ORDER BY TotalSales DESC;

-- Total Sales
SELECT company,SUM(price) AS TotalSales FROM car_sales GROUP BY company ORDER BY TotalSales DESC;

-- Cars Sold
SELECT company,COUNT(*) AS CarsSold,SUM(price) AS TotalSales FROM car_sales 
GROUP BY company ORDER BY TotalSales DESC;

--- Company Rank 
SELECT company,COUNT(*) AS CarsSold,SUM(price) AS TotalSales,RANK() OVER (ORDER BY SUM(price) DESC) AS CompanyRank
FROM car_sales GROUP BY company ORDER BY CompanyRank;

----19. Product Ranking Within Each Company For every company, rank its car models based on total sales. Display: 
-- Company 
SELECT company,model,SUM(price) AS TotalSales,RANK() OVER (PARTITION BY company ORDER BY SUM(price) DESC) AS ModelRank
FROM car_sales GROUP BY company, model ORDER BY company, ModelRank;

-- Model 
SELECT  company,model,SUM(price) AS TotalSales,RANK() OVER (PARTITION BY company ORDER BY SUM(price) DESC) AS ModelRank
FROM car_sales GROUP BY company, model ORDER BY company, ModelRank;

-- Total Sales
SELECT company,model,SUM(price) AS TotalSales,RANK() OVER (PARTITION BY company ORDER BY SUM(price) DESC) AS ModelRank
FROM car_sales GROUP BY company, model ORDER BY company, ModelRank;

-- Total Cars Sold
SELECT COUNT(*) AS TotalCarsSold FROM car_sales;

-- Model Rank
SELECT Company,Model,COUNT(*) AS TotalCarsSold,RANK() OVER (PARTITION BY Company ORDER BY COUNT(*) DESC) AS ModelRank
FROM car_sales GROUP BY Company, Model ORDER BY Company, ModelRank;

--The highest-selling model within each company should have rank 1.
SELECT  Company, Model,COUNT(*) AS TotalCarsSold,RANK() OVER (
PARTITION BY Company ORDER BY COUNT(*) DESC) AS ModelRank FROM car_sales GROUP BY Company, Model;

---20. Compare Each Car's Price with the Average Car Price Find cars whose price is higher than the overall average car price. Display:
-- Company 
-- Model
-- Price
-- Average Price 
SELECT
    Company,
    Model,
    Price AS Price,
    (SELECT AVG(Price)
     FROM car_sales) AS Average_Price FROM car_sales
WHERE Price > (SELECT AVG(Price) FROM car_sales) ORDER BY Price DESC;