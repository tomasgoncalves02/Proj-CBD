--Identificação: 202100744_202100728
-- Criar view HistoricoComprasCliente
CREATE VIEW HistoricoComprasCliente AS
    SELECT 
        S2.SalesOrderNumber,
        S2.OrderDate,
        P.EnglishProductName AS NomeDoProduto,
        P.ListPrice AS PrecoDoProduto,
        C.CustomerKey
    FROM Sales2 AS S2
    INNER JOIN Customer AS C ON S2.CustomerKey = C.CustomerKey
    INNER JOIN Products AS P ON S2.ProductKey = P.ProductKey;


-- Query da view HistoricoComprasCliente
SELECT *
FROM HistoricoComprasCliente
WHERE CustomerKey = 11000;
