CREATE TABLE SalesTerritory
(
  SalesTerritoryKey INT IDENTITY(1,1) NOT NULL,
  SalesTerritoryRegion NVARCHAR(30) NOT NULL,
  SalesTerritoryGroup NVARCHAR(30) NOT NULL,
  SalesTerritoryCountry NVARCHAR(30) NOT NULL,
  PRIMARY KEY (SalesTerritoryKey),
  UNIQUE (SalesTerritoryKey)
);

INSERT INTO SalesTerritory (SalesTerritoryRegion, SalesTerritoryGroup, SalesTerritoryCountry)
SELECT SalesTerritoryRegion, SalesTerritoryGroup, SalesTerritoryCountry
FROM AdventureOldData.dbo.SalesTerritory;