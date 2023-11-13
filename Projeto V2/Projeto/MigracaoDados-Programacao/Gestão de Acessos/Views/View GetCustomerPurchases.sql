

-- Create view CustomerPurchasesView
CREATE VIEW CustomerPurchasesView AS
    SELECT 
        S2.SalesOrderNumber,
        S2.SalesOrderLineNumber,
        S2.OrderDate,
        S2.DueDate,
        S2.ShipDate,
        P.EnglishProductName AS ProductName,
        P.ListPrice AS ProductPrice,
        C.CustomerKey  
    FROM Sales2 AS S2
    INNER JOIN Customer AS C ON S2.CustomerKey = C.CustomerKey
    INNER JOIN Products AS P ON S2.ProductKey = P.ProductKey;



-- Query view CustomerPurchasesView
SELECT *
FROM CustomerPurchasesView
WHERE CustomerKey = 11001;
