
---Total monetário de vendas por ano---
SELECT YEAR(S2.OrderDate) AS Ano, SUM(S2.SalesAmount) AS TotalMonetarioDeVendas
FROM dbo.Sales2 S2
GROUP BY YEAR(S2.OrderDate)
ORDER BY Ano;


---Total monetário de vendas por Product Category---
SELECT PC.EnglishProductCategoryName, SUM(S2.SalesAmount) AS TotalMonetarioDeVendas
FROM dbo.Sales2 S2
INNER JOIN dbo.Products P ON S2.ProductKey = P.ProductKey
INNER JOIN dbo.CategoryList CL ON P.CategoryListID = CL.CategoryListID
INNER JOIN dbo.ProductCategory PC ON CL.ProductCategoryKey = PC.ProductCategoryKey
GROUP BY PC.EnglishProductCategoryName
ORDER BY TotalMonetarioDeVendas DESC;


---Total monetário de vendas por Product SubCategory---
SELECT PSC.EnglishProductSubCategoryName, SUM(S2.SalesAmount) AS TotalMonetarioDeVendas
FROM dbo.Sales2 S2
INNER JOIN dbo.Products P ON S2.ProductKey = P.ProductKey
INNER JOIN dbo.CategoryList CL ON P.CategoryListID = CL.CategoryListID
INNER JOIN dbo.ProductSubCategory PSC ON CL.ProductSubCategoryKey = PSC.ProductSubCategoryKey
GROUP BY PSC.EnglishProductSubCategoryName
ORDER BY TotalMonetarioDeVendas DESC;


---Número de produtos vendidos por Category por ano---
SELECT PC.EnglishProductCategoryName, YEAR(S2.OrderDate) AS Ano, COUNT(S2.ProductKey) AS NumeroDeProdutosVendidos
FROM dbo.Sales2 S2
INNER JOIN dbo.Products P ON S2.ProductKey = P.ProductKey
INNER JOIN dbo.CategoryList CL ON P.CategoryListID = CL.CategoryListID
INNER JOIN dbo.ProductCategory PC ON CL.ProductCategoryKey = PC.ProductCategoryKey
GROUP BY PC.EnglishProductCategoryName, YEAR(S2.OrderDate)
ORDER BY Ano, PC.EnglishProductCategoryName;




