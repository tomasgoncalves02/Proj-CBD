CREATE TABLE Products
(
  ProductKey INT IDENTITY(1,1) PRIMARY KEY,
  CategoryListID INT NOT NULL,
  ColorKey INT,
  ModelKey INT,
  WeightUnitMeasureCode VARCHAR(5),
  SizeUnitMeasureCode VARCHAR(5),
  EnglishProductName VARCHAR(255) NOT NULL,
  SpanishProductName VARCHAR(255),
  FrenchProductName VARCHAR(255),
  StandardCost FLOAT,
  FinishedGoodsFlag VARCHAR(30) NOT NULL,
  SafetyStockLevel INT NOT NULL,
  ListPrice FLOAT,
  Size VARCHAR(55),
  SizeRange VARCHAR(55),
  Weight FLOAT,
  DaysToManufacture BIT NOT NULL,
  ProductLine CHAR,
  DealerPrice FLOAT,
  Class CHAR,
  Style CHAR,
  EnglishDescription VARCHAR(255),
  FrenchDescription VARCHAR(MAX),
  Status VARCHAR(55),
  FOREIGN KEY (ColorKey) REFERENCES Color(ColorKey),
  FOREIGN KEY (CategoryListID) REFERENCES CategoryList(CategoryListID),
  FOREIGN KEY (ModelKey) REFERENCES Model(ModelKey),
  UNIQUE (ProductKey)
);


-- Crie uma stored procedure para inserir dados em Products
CREATE PROCEDURE dbo.MigrateProductsData
AS
BEGIN
    BEGIN TRY
        SET IDENTITY_INSERT Products ON;

        INSERT INTO Products (ProductKey, WeightUnitMeasureCode, SizeUnitMeasureCode, EnglishProductName, SpanishProductName, FrenchProductName, StandardCost, FinishedGoodsFlag, 
            SafetyStockLevel, ListPrice, Size, SizeRange, Weight, DaysToManufacture, ProductLine, DealerPrice, Class, Style, EnglishDescription, FrenchDescription, Status, CategoryListID, ModelKey, ColorKey)
        SELECT DISTINCT p.ProductKey, p.WeightUnitMeasureCode, p.SizeUnitMeasureCode, p.EnglishProductName, p.SpanishProductName, p.FrenchProductName, 
            p.StandardCost, p.FinishedGoodsFlag, p.SafetyStockLevel, p.ListPrice, p.Size, p.SizeRange, p.Weight, p.DaysToManufacture, p.ProductLine, p.DealerPrice, 
            p.Class, p.Style, p.EnglishDescription, p.FrenchDescription, p.Status, d.CategoryListID, b.ModelKey, c.ColorKey 
        FROM AdventureOldData.dbo.Products p
        INNER JOIN AdventureWorks.dbo.Color c ON p.Color = c.Color
        INNER JOIN AdventureWorks.dbo.Model b ON p.ModelName = b.ModelName 
        INNER JOIN AdventureWorks.dbo.CategoryList d ON d.ProductSubCategoryKey = p.ProductSubcategoryKey;

        SET IDENTITY_INSERT Products OFF;
    END TRY
    BEGIN CATCH
        -- Tratamento de erros
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorNumber INT = ERROR_NUMBER();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        -- Registre o erro em um log de erros
        EXEC dbo.LogError @ErrorMessage, @ErrorNumber, @ErrorSeverity, @ErrorState;

        -- Exiba uma mensagem amigável para o utilizador
        THROW 50000, 'Ocorreu um erro durante a migração de dados da tabela Products. Entre em contato com o suporte.', 1;
    END CATCH
END;

--Executar o procedimento
exec dbo.MigrateProductsData;
