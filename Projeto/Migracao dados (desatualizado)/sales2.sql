-- Tabela Sales2
CREATE TABLE Sales2
(
	ProductKey INT NOT NULL,
	OrderDateKey INT NOT NULL,
	DueDateKey INT NOT NULL,
	ShipDateKey INT NOT NULL,
	CustomerKey INT NOT NULL,
	PromotionKey INT NOT NULL,
	CurrencyKey INT NOT NULL,
	SalesTerritoryKey INT NOT NULL,
	SalesOrderNumber VARCHAR(255) NOT NULL,
	SalesOrderLineNumber INT NOT NULL,
	RevisionNumber INT NOT NULL,
	OrderQuantity INT NOT NULL,
	UnitPrice INT NOT NULL,
	ExtendedAmount INT NOT NULL,
	UnitPriceDiscountPct INT NOT NULL,
	DiscountAmount INT NOT NULL,
	ProductStandardCost INT NOT NULL,
	TotalProductCost INT NOT NULL,
	SalesAmount INT NOT NULL,
	TaxAmt INT NOT NULL,
	Freight INT NOT NULL,
	CarrierTrackingNumber NVARCHAR(255),
	CustomerPONumber NVARCHAR(255),
	OrderDate DATE NOT NULL,
	DueDate DATE NOT NULL,
	ShipDate DATE,
	PRIMARY KEY (ProductKey, CustomerKey, SalesTerritoryKey),
	FOREIGN KEY (ProductKey) REFERENCES Products(ProductKey),
	FOREIGN KEY (CustomerKey) REFERENCES Customer(CustomerKey),
	FOREIGN KEY (SalesTerritoryKey) REFERENCES SalesTerritory(SalesTerritoryKey),
	FOREIGN KEY (CurrencyKey) REFERENCES Currency(CurrencyKey)
);

-- Mova os dados da tabela original para a nova tabela, incluindo a coluna CustomerKey
INSERT INTO Sales2 
(ProductKey,OrderDateKey,DueDateKey,ShipDateKey,CustomerKey,PromotionKey,CurrencyKey,SalesTerritoryKey,SalesOrderNumber,
SalesOrderLineNumber,RevisionNumber,OrderQuantity,UnitPrice,ExtendedAmount,UnitPriceDiscountPct,DiscountAmount,
ProductStandardCost,TotalProductCost,SalesAmount,TaxAmt,Freight,CarrierTrackingNumber,CustomerPONumber,OrderDate,
DueDate,ShipDate)
SELECT *
FROM AdventureOldData.dbo.sales2;
