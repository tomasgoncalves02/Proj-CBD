-- 2.1) �ndices

-- Criação dos índices
CREATE INDEX IX_Customer_City ON [dbo].[Customer] ([City]);
CREATE INDEX IX_SalesOrders_CustomerKey ON [dbo].[SalesOrders] ([CustomerKey]);
GO
-- Consulta para Pesquisa de vendas por cidade com contagem de vendas corrigida
CREATE VIEW VendasPorCidade AS
SELECT
    c.City,
    c.StateProvinceName AS Estado,
    COUNT(DISTINCT so.SalesOrderNumber) AS NumeroVendas,
    SUM(od.SalesAmount) AS TotalVendas
FROM
    [dbo].[SalesOrders] so
JOIN
    [dbo].[Customer] c ON so.CustomerKey = c.CustomerKey
JOIN
    [dbo].[OrderDetails] od ON so.SalesOrderNumber = od.SalesOrderNumber
GROUP BY
    c.City, c.StateProvinceName;
GO
Select * from VendasPorCidade;



------------------------------------------------------------
-- Para o total de vendas calcular a taxa de crescimento de cada ano, face ao ano anterior, por categoria de produto;

-- �ndices
CREATE INDEX IX_SalesOrder_OrderDate ON SalesOrders (OrderDate);
CREATE INDEX IX_OrderDetails_SalesOrderNumber ON OrderDetails (SalesOrderNumber);
CREATE INDEX IX_OrderDetails_ProductKey ON OrderDetails (ProductKey);
CREATE INDEX IX_Products_ProductKey_CategoryListID ON Products (ProductKey, CategoryListID);
CREATE INDEX IX_CategoryList_CategoryListID ON CategoryList (CategoryListID);
GO

-- Consulta para calcular a taxa de crescimento de vendas por categoria de produto
CREATE VIEW VendasPorAno1 AS
WITH VendasPorAno AS (
    SELECT
        YEAR(SO.OrderDate) AS Ano,
        CL.ProductCategoryKey,
        SUM(OD.SalesAmount) AS TotalVendas
    FROM
        SalesOrders AS SO
    JOIN
        OrderDetails AS OD ON SO.SalesOrderNumber = OD.SalesOrderNumber
    JOIN
        Products AS P ON OD.ProductKey = P.ProductKey
    JOIN
        CategoryList AS CL ON P.CategoryListID = CL.CategoryListID
    GROUP BY
        YEAR(SO.OrderDate), CL.ProductCategoryKey
)
SELECT
    Ano,
    ProductCategoryKey,
    TotalVendas,
    LAG(TotalVendas) OVER (PARTITION BY ProductCategoryKey ORDER BY Ano) AS VendasAnoAnterior,
    CASE 
        WHEN LAG(TotalVendas) OVER (PARTITION BY ProductCategoryKey ORDER BY Ano) = 0 THEN NULL
        ELSE (TotalVendas - LAG(TotalVendas) OVER (PARTITION BY ProductCategoryKey ORDER BY Ano)) * 1.0 / LAG(TotalVendas) OVER (PARTITION BY ProductCategoryKey ORDER BY Ano)
    END AS TaxaCrescimento
FROM
    VendasPorAno;


GO
Select * from VendasPorAno1;

---------------------------------------------------------------------

-- N�mero de produtos nas vendas por cor.

-- Índices
CREATE INDEX IX_Color_ColorKey ON [dbo].[Color] ([ColorKey]);
CREATE INDEX IX_Products_ColorKey_ProductKey ON [dbo].[Products] ([ColorKey], [ProductKey]);
GO
-- Consulta para calcular o número de produtos nas vendas por cor
Create VIEW CalcularNumeroProdutos AS
SELECT
    c.Color,
    COUNT(DISTINCT p.ProductKey) AS NumeroProdutos
FROM
    [dbo].[OrderDetails] od
JOIN
    [dbo].[Products] p ON od.ProductKey = p.ProductKey
JOIN
    [dbo].[Color] c ON p.ColorKey = c.ColorKey
GROUP BY
    c.Color;
GO

Select * from CalcularNumeroProdutos;


