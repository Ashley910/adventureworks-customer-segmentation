------------------------------------------------------------
-- STEP 1: Explore customer-related tables
------------------------------------------------------------

SELECT TOP 50 * FROM Sales.Customer;
SELECT TOP 50 * FROM Person.Person;
SELECT TOP 50 * FROM Sales.SalesOrderHeader;
SELECT TOP 50 * FROM Sales.SalesOrderDetail;

------------------------------------------------------------
-- STEP 2: Validate customer data
------------------------------------------------------------

-- Missing PersonID
SELECT CustomerID
FROM Sales.Customer
WHERE PersonID IS NULL;

-- Missing TerritoryID
SELECT CustomerID
FROM Sales.Customer
WHERE TerritoryID IS NULL;

-- Duplicate customers
SELECT PersonID, COUNT(*) AS Cnt
FROM Sales.Customer
GROUP BY PersonID
HAVING COUNT(*) > 1;

------------------------------------------------------------
-- STEP 3: Build customer profile view
------------------------------------------------------------

SELECT 
    c.CustomerID,
    c.PersonID,
    p.FirstName,
    p.LastName,
    p.EmailPromotion,
    c.TerritoryID,
    t.Name AS TerritoryName
FROM Sales.Customer c
LEFT JOIN Person.Person p
    ON c.PersonID = p.BusinessEntityID
LEFT JOIN Sales.SalesTerritory t
    ON c.TerritoryID = t.TerritoryID;

------------------------------------------------------------
-- STEP 4: Calculate Customer Lifetime Value (CLV)
------------------------------------------------------------

SELECT 
    h.CustomerID,
    SUM(h.TotalDue) AS LifetimeValue,
    COUNT(h.SalesOrderID) AS TotalOrders,
    AVG(h.TotalDue) AS AvgOrderValue
FROM Sales.SalesOrderHeader h
GROUP BY h.CustomerID;

------------------------------------------------------------
-- STEP 5: Segment customers by lifetime value
------------------------------------------------------------

SELECT 
    CustomerID,
    LifetimeValue,
    CASE 
        WHEN LifetimeValue >= 5000 THEN 'High-Value'
        WHEN LifetimeValue BETWEEN 1000 AND 4999 THEN 'Medium-Value'
        ELSE 'Low-Value'
    END AS CustomerSegment
FROM (
    SELECT 
        h.CustomerID,
        SUM(h.TotalDue) AS LifetimeValue
    FROM Sales.SalesOrderHeader h
    GROUP BY h.CustomerID
) AS LV;

------------------------------------------------------------
-- STEP 6: Analyze customer behavior over time
------------------------------------------------------------

SELECT 
    h.CustomerID,
    YEAR(h.OrderDate) AS OrderYear,
    COUNT(h.SalesOrderID) AS OrdersPerYear,
    SUM(h.TotalDue) AS RevenuePerYear
FROM Sales.SalesOrderHeader h
GROUP BY h.CustomerID, YEAR(h.OrderDate)
ORDER BY h.CustomerID, OrderYear;

------------------------------------------------------------
-- STEP 7: Identify top customer territories
------------------------------------------------------------

SELECT 
    t.Name AS TerritoryName,
    COUNT(DISTINCT h.CustomerID) AS CustomerCount,
    SUM(h.TotalDue) AS TerritoryRevenue
FROM Sales.SalesOrderHeader h
JOIN Sales.Customer c
    ON h.CustomerID = c.CustomerID
JOIN Sales.SalesTerritory t
    ON c.TerritoryID = t.TerritoryID
GROUP BY t.Name
ORDER BY TerritoryRevenue DESC;

------------------------------------------------------------
-- STEP 8: Summary insights (SQL output only)
------------------------------------------------------------

-- Top 10 highest-value customers
SELECT TOP 10 
    h.CustomerID,
    SUM(h.TotalDue) AS LifetimeValue
FROM Sales.SalesOrderHeader h
GROUP BY h.CustomerID
ORDER BY LifetimeValue DESC;

-- Segment distribution
SELECT 
    Segment,
    COUNT(*) AS CountOfCustomers
FROM (
    SELECT 
        CustomerID,
        CASE 
            WHEN SUM(TotalDue) >= 5000 THEN 'High-Value'
            WHEN SUM(TotalDue) BETWEEN 1000 AND 4999 THEN 'Medium-Value'
            ELSE 'Low-Value'
        END AS Segment
    FROM Sales.SalesOrderHeader
    GROUP BY CustomerID
) AS Seg
GROUP BY Segment;
