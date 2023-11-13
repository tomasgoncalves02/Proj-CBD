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
  Status VARCHAR(55),
  FOREIGN KEY (ColorKey) REFERENCES Color(ColorKey),
  FOREIGN KEY (CategoryListID) REFERENCES CategoryList(CategoryListID),
  FOREIGN KEY (ModelKey) REFERENCES Model(ModelKey),
  UNIQUE (ProductKey)
);

SET IDENTITY_INSERT Products ON;

INSERT INTO Products (ProductKey, WeightUnitMeasureCode, SizeUnitMeasureCode, EnglishProductName, SpanishProductName, FrenchProductName, StandardCost, FinishedGoodsFlag, 
SafetyStockLevel, ListPrice, Size, SizeRange, Weight, DaysToManufacture, 
ProductLine, DealerPrice, Class, Style, EnglishDescription, Status, CategoryListID, ModelKey, ColorKey)
SELECT distinct p.ProductKey, p.WeightUnitMeasureCode, 
p.SizeUnitMeasureCode, p.EnglishProductName, p.SpanishProductName, 
p.FrenchProductName, p.StandardCost, p.FinishedGoodsFlag, 
p.SafetyStockLevel, p.ListPrice, p.Size, p.SizeRange, p.Weight, 
p.DaysToManufacture, p.ProductLine, p.DealerPrice, p.Class, p.Style, 
p.EnglishDescription, p.Status, d.CategoryListID, b.ModelKey, c.ColorKey 
FROM AdventureOldData.dbo.Products p
inner join AdventureWorks.dbo.Color c on p.Color = c.Color
INNER JOIN AdventureWorks.dbo.Model b ON p.ModelName = b.ModelName 
INNER JOIN AdventureWorks.dbo.CategoryList d ON d.ProductSubCategoryKey = p.ProductSubcategoryKey;


SET IDENTITY_INSERT Products OFF;