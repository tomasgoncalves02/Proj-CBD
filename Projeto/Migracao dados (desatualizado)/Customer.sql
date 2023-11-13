-- Tabela NewCustomer
CREATE TABLE Customer
(
	CustomerKey INT IDENTITY(1,1) NOT NULL,
	Title VARCHAR(55),
	FirstName VARCHAR(40) NOT NULL,
	MiddleName VARCHAR(20),
	LastName VARCHAR(20),
	NameStyle VARCHAR(20) NOT NULL,
	BirthDate DATE NOT NULL,
	MaritalStatus CHAR NOT NULL,
	Gender CHAR NOT NULL,
	YearlyIncome INT NOT NULL,
	TotalChildren INT NOT NULL,
	NumberChildrenAtHome INT NOT NULL,
	Education VARCHAR(255) NOT NULL,
	Occupation VARCHAR(40) NOT NULL,
	HouseOwnerFlag BIT NOT NULL,
	NumberCarsOwned INT NOT NULL,
	AddressLine1 VARCHAR(60) NOT NULL,
	AddressLine2 VARCHAR(60),
	City VARCHAR(60) NOT NULL,
	StateProvinceCode VARCHAR(60),
	StateProvinceName VARCHAR(60),
	CountryRegionCode VARCHAR(6),
	CountryRegionName VARCHAR(20),
	PostalCode NVARCHAR(55),
	Phone VARCHAR(55) NOT NULL,
	DateFirstPurchase DATE NOT NULL,
	CommuteDistance VARCHAR(30) NOT NULL,
	SalesTerritoryKey INT NOT NULL,
	PRIMARY KEY (CustomerKey),
	FOREIGN KEY (SalesTerritoryKey) REFERENCES SalesTerritory(SalesTerritoryKey),
	UNIQUE (CustomerKey)
);



SET IDENTITY_INSERT Customer ON;

-- Mova os dados da tabela original para a nova tabela, incluindo a coluna CustomerKey
INSERT INTO Customer (CustomerKey, Title, FirstName, MiddleName, LastName, NameStyle, BirthDate, MaritalStatus, Gender, YearlyIncome, TotalChildren, NumberChildrenAtHome, Education, Occupation, HouseOwnerFlag, NumberCarsOwned, AddressLine1, AddressLine2, City, StateProvinceCode, StateProvinceName, CountryRegionCode, CountryRegionName, PostalCode, Phone, DateFirstPurchase, CommuteDistance, SalesTerritoryKey)
SELECT CustomerKey, Title, FirstName, MiddleName, LastName, NameStyle, BirthDate, MaritalStatus, Gender, YearlyIncome, TotalChildren, NumberChildrenAtHome, Education, Occupation, HouseOwnerFlag, NumberCarsOwned, AddressLine1, AddressLine2, City, StateProvinceCode, StateProvinceName, CountryRegionCode, CountryRegionName, PostalCode, Phone, DateFirstPurchase, CommuteDistance, SalesTerritoryKey
FROM AdventureOldData.dbo.Customer;

SET IDENTITY_INSERT Customer OFF;
