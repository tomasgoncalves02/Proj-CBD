
---Total monet�rio de vendas por ano---
CREATE PROCEDURE GetSalesByYear
AS
BEGIN
    BEGIN TRY
        SELECT YEAR(S2.OrderDate) AS Ano, SUM(S2.SalesAmount) AS TotalMonetarioDeVendas
        FROM dbo.Sales2 S2
        GROUP BY YEAR(S2.OrderDate)
        ORDER BY Ano;
    END TRY
    BEGIN CATCH
        -- Captura de erro e tratamento
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SELECT @ErrorMessage = ERROR_MESSAGE(),
               @ErrorSeverity = ERROR_SEVERITY(),
               @ErrorState = ERROR_STATE();
        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END

exec GetSalesByYear;



---Total monet�rio de vendas por Product Category---

CREATE PROCEDURE GetSalesByProductCategory
AS
BEGIN
    BEGIN TRY
        SELECT PC.EnglishProductCategoryName, SUM(S2.SalesAmount) AS TotalMonetarioDeVendas
        FROM dbo.Sales2 S2
        INNER JOIN dbo.Products P ON S2.ProductKey = P.ProductKey
        INNER JOIN dbo.CategoryList CL ON P.CategoryListID = CL.CategoryListID
        INNER JOIN dbo.ProductCategory PC ON CL.ProductCategoryKey = PC.ProductCategoryKey
        GROUP BY PC.EnglishProductCategoryName
        ORDER BY TotalMonetarioDeVendas DESC;
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SELECT @ErrorMessage = ERROR_MESSAGE(),
               @ErrorSeverity = ERROR_SEVERITY(),
               @ErrorState = ERROR_STATE();

        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END

exec GetSalesByProductCategory;


---Total monet�rio de vendas por Product SubCategory---

CREATE PROCEDURE GetSalesByProductSubCategory
AS
BEGIN
    BEGIN TRY
        SELECT PSC.EnglishProductSubCategoryName, SUM(S2.SalesAmount) AS TotalMonetarioDeVendas
        FROM dbo.Sales2 S2
        INNER JOIN dbo.Products P ON S2.ProductKey = P.ProductKey
        INNER JOIN dbo.CategoryList CL ON P.CategoryListID = CL.CategoryListID
        INNER JOIN dbo.ProductSubCategory PSC ON CL.ProductSubCategoryKey = PSC.ProductSubCategoryKey
        GROUP BY PSC.EnglishProductSubCategoryName
        ORDER BY TotalMonetarioDeVendas DESC;
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SELECT @ErrorMessage = ERROR_MESSAGE(),
               @ErrorSeverity = ERROR_SEVERITY(),
               @ErrorState = ERROR_STATE();

        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END

exec GetSalesByProductSubCategory;


---N�mero de produtos vendidos por Category por ano---
CREATE PROCEDURE GetProductsSoldByCategoryAndYear
AS
BEGIN
    BEGIN TRY
        SELECT PC.EnglishProductCategoryName, YEAR(S2.OrderDate) AS Ano, COUNT(S2.ProductKey) AS NumeroDeProdutosVendidos
        FROM dbo.Sales2 S2
        INNER JOIN dbo.Products P ON S2.ProductKey = P.ProductKey
        INNER JOIN dbo.CategoryList CL ON P.CategoryListID = CL.CategoryListID
        INNER JOIN dbo.ProductCategory PC ON CL.ProductCategoryKey = PC.ProductCategoryKey
        GROUP BY PC.EnglishProductCategoryName, YEAR(S2.OrderDate)
        ORDER BY Ano, PC.EnglishProductCategoryName;
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SELECT @ErrorMessage = ERROR_MESSAGE(),
               @ErrorSeverity = ERROR_SEVERITY(),
               @ErrorState = ERROR_STATE();

        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END

exec GetProductsSoldByCategoryAndYear;







