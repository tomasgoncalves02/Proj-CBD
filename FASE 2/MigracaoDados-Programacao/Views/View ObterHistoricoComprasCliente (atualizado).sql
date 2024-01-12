--Identificação: 202100744_202100728
-- Criar view HistoricoComprasCliente
CREATE VIEW HistoricoComprasCliente AS
    SELECT 
        OD.SalesOrderNumber,
        SO.OrderDate,
        P.EnglishProductName AS NomeDoProduto,
        P.ListPrice AS PrecoDoProduto,
        SO.CustomerKey
    FROM OrderDetails AS OD
    INNER JOIN SalesOrders AS SO ON OD.SalesOrderNumber = SO.SalesOrderNumber
    INNER JOIN Products AS P ON OD.ProductKey = P.ProductKey;

GO

-- Query da view HistoricoComprasCliente
SELECT *
FROM HistoricoComprasCliente
WHERE CustomerKey = 11000;
