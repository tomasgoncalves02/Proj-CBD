
--Identificação: 202100744_202100728
CREATE VIEW CustomerPurchasesView AS
    SELECT 
        OD.SalesOrderNumber,
        OD.SalesOrderLineNumber,
        SO.OrderDate,
        SO.DueDate,
        SO.ShipDate,
        P.EnglishProductName AS ProductName,
        P.ListPrice AS ProductPrice,
        SO.CustomerKey  
    FROM OrderDetails AS OD
    INNER JOIN SalesOrders AS SO ON OD.SalesOrderNumber = SO.SalesOrderNumber
    INNER JOIN Products AS P ON OD.ProductKey = P.ProductKey;
GO



-- Query view ComprasCliente
SELECT *
FROM CustomerPurchasesView
WHERE CustomerKey = 11001;
