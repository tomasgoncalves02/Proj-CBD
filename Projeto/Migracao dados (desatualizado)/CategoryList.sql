CREATE TABLE CategoryList
(
  CategoryListID INT IDENTITY(1,1) NOT NULL,
  ProductCategoryKey INT NOT NULL,
  ProductSubCategoryKey INT,
  PRIMARY KEY (CategoryListID),
  FOREIGN KEY (ProductCategoryKey) REFERENCES ProductCategory(ProductCategoryKey),
  FOREIGN KEY (ProductSubCategoryKey) REFERENCES ProductSubCategory(ProductSubCategoryKey),
);


INSERT INTO CategoryList (ProductCategoryKey, ProductSubCategoryKey)
SELECT distinct(c.ProductCategoryKey), b.ProductSubCategoryKey
FROM AdventureOldData.dbo.Products a
INNER JOIN AdventureOldData.dbo.ProductSubCategory b ON a.ProductSubcategoryKey = b.ProductSubcategoryKey
INNER JOIN AdventureWorks.dbo.ProductCategory c on a.EnglishProductCategoryName COLLATE SQL_Latin1_General_CP1_CI_AS = c.EnglishProductCategoryName COLLATE SQL_Latin1_General_CP1_CI_AS
