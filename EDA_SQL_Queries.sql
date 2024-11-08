use dataspark_database;

-- 1. Avg Customer Age --
SELECT AVG(Age) AS AverageAge
FROM (
    SELECT CustomerKey, AVG(Age) AS Age
    FROM GE_Data
    GROUP BY CustomerKey
) AS CustomerAges;

-- 2. Avg Order per Customer --
SELECT 
    COUNT(DISTINCT OrderNumber) / COUNT(DISTINCT CustomerKey) AS AvgOrdersPerCustomer
FROM GE_Data;

-- 3. Online Sales --
SELECT SUM(TotalPriceUSD) AS OnlineSales
FROM GE_Data
WHERE StoreKey = '0';

-- 4. Avg Store Area -- 
SELECT AVG(MaxSquareMeters) AS AvgStoreArea
FROM (
    SELECT StoreKey, MAX(SquareMeters) AS MaxSquareMeters
    FROM GE_Data
    GROUP BY StoreKey
) AS StoreMaxSquares;

-- 5. Avg Days taken to Delivery -- 
SELECT AVG(Days_Taken) AS AvgDaysTaken
FROM GE_Data
WHERE Days_Taken > 0;

-- 6. Total Revenue --
SELECT SUM(TotalPriceUSD) AS TotalRevenue
FROM GE_Data;

-- 7. Total Profit --
SELECT SUM(TotalPriceUSD) - SUM(TotalCostUSD) AS TotalProfit
FROM GE_Data;

-- 8. Product Popularity --
-- Most Popular
SELECT ProductName, SUM(Quantity) AS TotalQuantitySold
FROM GE_Data
GROUP BY ProductName
ORDER BY TotalQuantitySold DESC
LIMIT 1;
-- Least Popular  
SELECT ProductName, SUM(Quantity) AS TotalQuantitySold
FROM GE_Data
GROUP BY ProductName
HAVING TotalQuantitySold = 1;

-- 9. Top Brand --
-- By Sales
SELECT Brand, SUM(Quantity) AS TotalQuantitySold
FROM GE_Data
GROUP BY Brand
ORDER BY TotalQuantitySold DESC
LIMIT 1;

-- By Revenue
SELECT Brand, SUM(TotalPriceUSD) AS TotalRevenue
FROM GE_Data
GROUP BY Brand
ORDER BY TotalRevenue DESC
LIMIT 1;

-- 10. Top Performing Stores by Revenue --
SELECT StoreKey, Country_Store, State_Store, SUM(TotalPriceUSD) AS TotalRevenue
FROM GE_Data
GROUP BY StoreKey, Country_Store, State_Store
ORDER BY TotalRevenue DESC
LIMIT 3;
