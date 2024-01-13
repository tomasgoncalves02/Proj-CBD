/* 202100744_202100728 */
--3 
-- criar base de dados no SQL Server
create database AdventurWorksWeb;

-- Criar uma tabela para armazenar os resultados
CREATE TABLE SalesByModelProductYear (
    ModelKey INT,
    ProductKey INT,
    [Year] INT,
    TotalQuantity INT
)
GO
-- Popular a tabela temporária com as vendas por modelo, produto e ano
INSERT INTO SalesByModelProductYear (ModelKey, ProductKey, [Year], TotalQuantity)
SELECT P.ModelKey, P.ProductKey, YEAR(SO.OrderDate) AS [Year], SUM(OD.OrderQuantity) AS TotalQuantity
FROM AdventureWorks.dbo.SalesOrders SO
JOIN AdventureWorks.dbo.OrderDetails OD ON SO.SalesOrderNumber = OD.SalesOrderNumber
JOIN AdventureWorks.dbo.Products P ON OD.ProductKey = P.ProductKey
GROUP BY P.ModelKey, P.ProductKey, YEAR(SO.OrderDate)
GO
-- Exibir o conteúdo da tabela 
SELECT * FROM SalesByModelProductYear



-- Criar uma tabela para armazenar os resultados
CREATE TABLE MonthlyAnnualSalesBalance (
    [Year] INT,
    [Month] INT,
    TotalSales DECIMAL(18, 2)
);
GO

-- Popular a tabela com o balanço mensal e anual do total de vendas
INSERT INTO MonthlyAnnualSalesBalance ([Year], [Month], TotalSales)
SELECT YEAR(OrderDate) AS [Year], MONTH(OrderDate) AS [Month], SUM(od.SalesAmount) AS TotalSales
FROM AdventureWorks.dbo.SalesOrders so
INNER JOIN AdventureWorks.dbo.OrderDetails od ON so.SalesOrderNumber = od.SalesOrderNumber
GROUP BY YEAR(OrderDate), MONTH(OrderDate);
GO

-- Exibir o conteúdo da tabela MonthlyAnnualSalesBalance
SELECT * FROM MonthlyAnnualSalesBalance;



