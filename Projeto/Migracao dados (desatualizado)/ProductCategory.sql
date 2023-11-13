-- Tabela ProductCategory
CREATE TABLE ProductCategory
(
    ProductCategoryKey INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    EnglishProductCategoryName NVARCHAR(55),
    FrenchProductCategoryName NVARCHAR(55) NOT NULL,
    SpanishProductCategoryName NVARCHAR(55),
    ModifiedDate DATE,
);


-- Inserir dados da tabela ProductCategory da base de dados original na nova tabela
INSERT INTO ProductCategory (EnglishProductCategoryName, FrenchProductCategoryName, SpanishProductCategoryName)
SELECT Distinct EnglishProductCategoryName, FrenchProductCategoryName, SpanishProductCategoryName
FROM AdventureOldData.dbo.Products;



