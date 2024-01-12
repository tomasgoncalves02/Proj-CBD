-- 1 Criacao da base de dados
use AdventurWorksWeb

--3 
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


--5
-- Listar por Produto o "histórico de vendas" adquiridos por cidade
db.SalesByModelProductYear.aggregate([
  {
    $lookup: {
      from: "SalesOrders",
      localField: "SalesOrderNumber",
      foreignField: "SalesOrderNumber",
      as: "orderDetails"
    }
  },
  {
    $unwind: "$orderDetails"
  },
  {
    $lookup: {
      from: "Customer",
      localField: "orderDetails.CustomerKey",
      foreignField: "CustomerKey",
      as: "customerInfo"
    }
  },
  {
    $project: {
      _id: 0,
      EnglishProductName: 1,
      "customerInfo.City": 1,
      SalesAmount: 1
    }
  }
])

-- Listar por Produto o valor total por mês/ano e a média mensal
db.MonthlyAnnualSalesBalance.aggregate([
  {
    $group: {
      _id: {
        Product: "$EnglishProductName",
        Year: { $year: "$OrderDate" },
        Month: { $month: "$OrderDate" }
      },
      TotalSales: { $sum: "$SalesAmount" }
    }
  },
  {
    $project: {
      _id: 0,
      Product: "$_id.Product",
      Year: "$_id.Year",
      Month: "$_id.Month",
      TotalSales: 1
    }
  }
])

-- Listar por Modelo, os produtos e quantidades adquiridas
db.SalesByModelProductYear.aggregate([
  {
    $group: {
      _id: {
        Model: "$ModelName",
        Product: "$EnglishProductName"
      },
      TotalQuantity: { $sum: "$OrderQuantity" }
    }
  },
  {
    $project: {
      _id: 0,
      Model: "$_id.Model",
      Product: "$_id.Product",
      TotalQuantity: 1
    }
  }
])


