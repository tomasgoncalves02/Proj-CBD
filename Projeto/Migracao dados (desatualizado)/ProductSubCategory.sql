-- Tabela ProductSubCategory
CREATE TABLE ProductSubCategory
(
  ProductSubCategoryKey INT IDENTITY(1,1) NOT NULL,
  EnglishProductSubCategoryName VARCHAR(55) NOT NULL,
  SpanishProductSubCategoryName VARCHAR(55) NOT NULL,
  FrenchProductSubCategoryName VARCHAR(55) NOT NULL,
  PRIMARY KEY (ProductSubCategoryKey),
  UNIQUE (ProductSubCategoryKey),
  UNIQUE (EnglishProductSubCategoryName),
  UNIQUE (SpanishProductSubCategoryName),
  UNIQUE (FrenchProductSubCategoryName)
);

INSERT INTO ProductSubCategory (EnglishProductSubCategoryName, SpanishProductSubCategoryName, FrenchProductSubCategoryName)
SELECT EnglishProductSubCategoryName, SpanishProductSubCategoryName, FrenchProductSubCategoryName
FROM AdventureOldData.dbo.ProductSubCategory;