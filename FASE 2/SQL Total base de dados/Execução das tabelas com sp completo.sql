--Identificação: 202100744_202100728
-- Cria��o tabela ErrorLog
CREATE TABLE ErrorLog (
    ErrorLogID INT IDENTITY(1,1) PRIMARY KEY,
    ErrorMessage NVARCHAR(4000),
    ErrorNumber INT,
    ErrorSeverity INT,
    ErrorState INT,
    Timestamp DATETIME
);
GO
-- Criar uma stored procedure para inserir logs de erro
CREATE PROCEDURE dbo.LogError
    @ErrorMessage NVARCHAR(4000),
    @ErrorNumber INT,
    @ErrorSeverity INT,
    @ErrorState INT
AS
BEGIN
 -- Inser��o na tabela ErrorLog
    INSERT INTO ErrorLog (ErrorMessage, ErrorNumber, ErrorSeverity, ErrorState, Timestamp)
    VALUES (@ErrorMessage, @ErrorNumber, @ErrorSeverity, @ErrorState, GETDATE());
END;

GO
--Identificação: 202100744_202100728

-- Tabela Model
CREATE TABLE Model
(
    ModelKey INT IDENTITY(1,1) NOT NULL,
    ModelName VARCHAR(255),
    PRIMARY KEY (ModelKey)
);
GO

-- Crie uma stored procedure para realizar a migra��o de dados para a tabela Model
CREATE PROCEDURE dbo.MigrateModelData
AS
BEGIN
    BEGIN TRY
        -- Inicie a transa��o para garantir a consist�ncia dos dados
        BEGIN TRANSACTION;

        -- Inser��o de dados na tabela Model
        INSERT INTO Model (ModelName)
        SELECT DISTINCT ModelName
        FROM AdventureOldData.dbo.Products;

        -- Commit da transa��o se a inser��o for bem-sucedida
        COMMIT;
    END TRY
    BEGIN CATCH
        -- Rollback da transa��o em caso de erro
        ROLLBACK;

        -- Tratamento de erros
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorNumber INT = ERROR_NUMBER();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        -- Registo do erro num log de erros 
        EXEC dbo.LogError @ErrorMessage, @ErrorNumber, @ErrorSeverity, @ErrorState;

        -- Exibir uma mensagem amig�vel para o utilizador
        THROW 50000, 'Ocorreu um erro durante a migra��o de dados da tabela Model. Entre em contato com o suporte.', 1;
    END CATCH
END;
GO
--Executar o procedimento
exec dbo.MigrateModelData;
GO
--Identificação: 202100744_202100728
-- Criação da tabela Color
CREATE TABLE Color
(
  ColorKey INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
  Color NVARCHAR(55) NOT NULL
);
GO

-- Crie uma stored procedure para realizar a migração de dados
CREATE PROCEDURE dbo.MigrateColorData
AS
BEGIN
    BEGIN TRY
        -- Inicie a transação para garantir consistência
        BEGIN TRANSACTION;

        -- Inserção de dados na tabela Color
        INSERT INTO Color (Color)
        SELECT DISTINCT Color
        FROM AdventureOldData.dbo.Products;

        -- Commit da transação se a inserção for bem-sucedida
        COMMIT;
    END TRY
    BEGIN CATCH
        -- Rollback da transação em caso de erro
        ROLLBACK;

        -- Tratamento de erros
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorNumber INT = ERROR_NUMBER();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        -- Registo do erro num log de erros
        EXEC dbo.LogError @ErrorMessage, @ErrorNumber, @ErrorSeverity, @ErrorState;

        -- Exibir uma mensagem amigável para o utilizador
        THROW 50000, 'Ocorreu um erro durante a migração de dados da tabela Color. Entre em contato com o suporte.', 1;
    END CATCH
END;
GO
exec dbo.MigrateColorData;
GO
--Identificação: 202100744_202100728
-- Tabela ProductCategory
CREATE TABLE ProductCategory
(
    ProductCategoryKey INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    EnglishProductCategoryName NVARCHAR(55),
    FrenchProductCategoryName NVARCHAR(55) NOT NULL,
    SpanishProductCategoryName NVARCHAR(55),
    ModifiedDate DATE
);
GO

-- Crie uma stored procedure para realizar a migracao de dados para a tabela ProductCategory
CREATE PROCEDURE dbo.MigrateProductCategoryData
AS
BEGIN
    BEGIN TRY
        -- Inicia a transacao para garantir a consistencia dos dados
        BEGIN TRANSACTION;

        -- Inserir de dados na tabela ProductCategory
        INSERT INTO ProductCategory (EnglishProductCategoryName, FrenchProductCategoryName, SpanishProductCategoryName)
        SELECT DISTINCT EnglishProductCategoryName, FrenchProductCategoryName, SpanishProductCategoryName
        FROM AdventureOldData.dbo.Products;

        -- Commit da transacao se a insercao for bem-sucedida
        COMMIT;
    END TRY
    BEGIN CATCH
        -- Rollback da transacao em caso de erro
        ROLLBACK;

        -- Tratamento de erros
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorNumber INT = ERROR_NUMBER();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        -- Registar o erro em um log de erros
        EXEC dbo.LogError @ErrorMessage, @ErrorNumber, @ErrorSeverity, @ErrorState;

        -- Exiba uma mensagem amigavel para o utilizador
        THROW 50000, 'Ocorreu um erro durante a migracao de dados da tabela ProductCategory. Entre em contato com o suporte.', 1;
    END CATCH
END;
GO
--Executar o procedimento
exec dbo.MigrateProductCategoryData;
GO
--Identificação: 202100744_202100728
-- Criacao da tabela Questions
CREATE TABLE Questions
(
  QuestionID INT IDENTITY(1,1) NOT NULL,
  Question VARCHAR(255) NOT NULL,
  PRIMARY KEY (QuestionID),
);
GO

-- insercao de um registo na tabela Questions
INSERT INTO Questions (Question)
VALUES ('Qual é o nome do teu cão?');
GO
--Identificação: 202100744_202100728
-- Criação da tabela Response
CREATE TABLE Response
(
  ResponseID INT IDENTITY(1,1) NOT NULL,
  Response VARCHAR(255) NOT NULL,
  QuestionID INT
  PRIMARY KEY (ResponseID),
  FOREIGN KEY (QuestionID) REFERENCES Questions(QuestionID)
);
GO

-- inserção de um registo na tabela Response
INSERT INTO Response (Response, QuestionID)
VALUES ('Billy', 1);
GO
--Identificação: 202100744_202100728
-- Criacao da tabela SalesTerritory
CREATE TABLE SalesTerritory
(
  SalesTerritoryKey INT IDENTITY(1,1) NOT NULL,
  SalesTerritoryRegion NVARCHAR(30) NOT NULL,
  SalesTerritoryGroup NVARCHAR(30) NOT NULL,
  SalesTerritoryCountry NVARCHAR(30) NOT NULL,
  PRIMARY KEY (SalesTerritoryKey),
  UNIQUE (SalesTerritoryKey)
);
GO

-- Criar a stored procedure para inserir dados na SalesTerritory
CREATE PROCEDURE dbo.InsertSalesTerritoryData
AS
BEGIN
    BEGIN TRY
        INSERT INTO SalesTerritory (SalesTerritoryRegion, SalesTerritoryGroup, SalesTerritoryCountry)
        SELECT SalesTerritoryRegion, SalesTerritoryGroup, SalesTerritoryCountry
        FROM AdventureOldData.dbo.SalesTerritory;
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorNumber INT = ERROR_NUMBER();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();
        THROW 50000, 'Ocorreu um erro durante a migração de dados da tabela SalesTerritory. Entre em contato com o suporte.', 1;
    END CATCH
END;
GO
EXEC dbo.InsertSalesTerritoryData;
GO
--Identificação: 202100744_202100728
--Criacao da tabela Currency
CREATE TABLE Currency
(
    CurrencyKey INT IDENTITY(1,1) PRIMARY KEY,
    CurrencyAlternateKey NVARCHAR(5) NOT NULL,
    CurrencyName NVARCHAR(55) NOT NULL,
    UNIQUE (CurrencyKey),
    UNIQUE (CurrencyAlternateKey),
    UNIQUE (CurrencyName)
);
GO
-- Crie uma stored procedure para realizar a migra��o de dados da tabela Currency
CREATE PROCEDURE dbo.MigrateCurrencyData
AS
BEGIN
    BEGIN TRY
        -- Inicie a transa��o para garantir consist�ncia
        BEGIN TRANSACTION;

        -- Inser��o de dados na tabela Currency
        INSERT INTO Currency (CurrencyAlternateKey, CurrencyName)
        SELECT CurrencyAlternateKey, CurrencyName
        FROM AdventureOldData.dbo.Currency;

        -- Commit da transa��o se a inser��o for bem-sucedida
        COMMIT;
    END TRY
    BEGIN CATCH
        -- Rollback da transa��o em caso de erro
        ROLLBACK;

        -- Tratamento de erros
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorNumber INT = ERROR_NUMBER();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        -- Registo o erro num log de erros
        EXEC dbo.LogError @ErrorMessage, @ErrorNumber, @ErrorSeverity, @ErrorState;

        -- Exibir uma mensagem amig�vel para o utilizador
        THROW 50000, 'Ocorreu um erro durante a migração de dados da tabela Currency. Entre em contato com o suporte.', 1;
    END CATCH
END;
GO
exec dbo.MigrateCurrencyData;
GO
--Identificação: 202100744_202100728
--Criação da tabela ProductSubCategory
CREATE TABLE ProductSubCategory
(
    ProductSubCategoryKey INT IDENTITY(1,1) NOT NULL,
    EnglishProductSubCategoryName VARCHAR(55) NOT NULL,
    SpanishProductSubCategoryName VARCHAR(55) NOT NULL,
    FrenchProductSubCategoryName VARCHAR(55) NOT NULL,
    PRIMARY KEY (ProductSubCategoryKey),
    UNIQUE (EnglishProductSubCategoryName),
    UNIQUE (SpanishProductSubCategoryName),
    UNIQUE (FrenchProductSubCategoryName)
);
GO

-- Criar uma stored procedure para realizar a migracao de dados para a tabela ProductSubCategory
CREATE PROCEDURE dbo.MigrateProductSubCategoryData
AS
BEGIN
    BEGIN TRY
        -- Inicio da transacao para garantir a consistencia dos dados
        BEGIN TRANSACTION;

        -- Inser��o de dados na tabela ProductSubCategory
        INSERT INTO ProductSubCategory (EnglishProductSubCategoryName, SpanishProductSubCategoryName, FrenchProductSubCategoryName)
        SELECT EnglishProductSubCategoryName, SpanishProductSubCategoryName, FrenchProductSubCategoryName
        FROM AdventureOldData.dbo.ProductSubCategory;

        -- Commit da transacao se a insercao for bem-sucedida
        COMMIT;
    END TRY
    BEGIN CATCH
        -- Rollback da transacao em caso de erro
        ROLLBACK;

        -- Tratamento de erros
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorNumber INT = ERROR_NUMBER();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        -- Registo do erro num log de erros 
        EXEC dbo.LogError @ErrorMessage, @ErrorNumber, @ErrorSeverity, @ErrorState;

        -- Exiba uma mensagem amigavel para o utilizador
        THROW 50000, 'Ocorreu um erro durante a migração de dados da tabela ProductSubCategory. Entre em contato com o suporte.', 1;
    END CATCH
END;
GO
exec dbo.MigrateProductSubCategoryData;
GO
--Identificação: 202100744_202100728
-- Criação da tabela CategoryList
CREATE TABLE CategoryList
(
  CategoryListID INT IDENTITY(1,1) NOT NULL,
  ProductCategoryKey INT NOT NULL,
  ProductSubCategoryKey INT,
  PRIMARY KEY (CategoryListID),
  FOREIGN KEY (ProductCategoryKey) REFERENCES ProductCategory(ProductCategoryKey),
  FOREIGN KEY (ProductSubCategoryKey) REFERENCES ProductSubCategory(ProductSubCategoryKey),
);
GO

-- Criar uma stored procedure para realizar a migração de dados
CREATE PROCEDURE dbo.MigrateCategoryListData
AS
BEGIN
    BEGIN TRY
        -- Inicie a transação para garantir consistência
        BEGIN TRANSACTION;

        -- Inserção de dados na tabela CategoryList
        INSERT INTO CategoryList (ProductCategoryKey, ProductSubCategoryKey)
        SELECT DISTINCT c.ProductCategoryKey, b.ProductSubCategoryKey
        FROM AdventureOldData.dbo.Products a
        INNER JOIN AdventureOldData.dbo.ProductSubCategory b ON a.ProductSubcategoryKey = b.ProductSubcategoryKey
        INNER JOIN AdventureWorks.dbo.ProductCategory c ON a.EnglishProductCategoryName COLLATE SQL_Latin1_General_CP1_CI_AS = c.EnglishProductCategoryName COLLATE SQL_Latin1_General_CP1_CI_AS;

        -- Commit da transação se a inserção for bem-sucedida
        COMMIT;
    END TRY
    BEGIN CATCH
        -- Rollback da transação em caso de erro
        ROLLBACK;

        -- Tratamento de erros
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorNumber INT = ERROR_NUMBER();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        -- Registo do erro num log de erros
        EXEC dbo.LogError @ErrorMessage, @ErrorNumber, @ErrorSeverity, @ErrorState;

        -- Exibir uma mensagem amigável para o utilizador
        THROW 50000, 'Ocorreu um erro durante a migração de dados da tabela CategoryList. Entre em contato com o suporte.', 1;
    END CATCH
END;
GO
exec dbo.MigrateCategoryListData;
GO
--Identificação: 202100744_202100728
-- Criação tabela Products
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
GO

-- Criar uma stored procedure para inserir dados em Products
CREATE PROCEDURE [dbo].[MigrateProductsData]
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
        INNER JOIN AdventureWorks.dbo.Color c ON p.Color COLLATE Latin1_General_CI_AS = c.Color
        INNER JOIN AdventureWorks.dbo.Model b ON p.ModelName COLLATE Latin1_General_CI_AS = b.ModelName 
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

        -- Exiba uma mensagem amigável para o usuário
        THROW 50000, 'Ocorreu um erro durante a migração de dados da tabela Products. Entre em contato com o suporte.', 1;
    END CATCH
END;
GO
--Executar o procedimento
exec dbo.MigrateProductsData;
GO
--Identificação: 202100744_202100728
-- Tabela Customer
CREATE TABLE Customer
(
    CustomerKey INT IDENTITY(1,1) NOT NULL,
    Title VARCHAR(55),
    FirstName VARCHAR(40) NOT NULL,
    MiddleName VARCHAR(20),
    LastName VARCHAR(20),
    EmailAddress VARCHAR(80) NOT NULL,
	Password NVARCHAR(500),
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
	ResponseID INT,
    PRIMARY KEY (CustomerKey),
	FOREIGN KEY (ResponseID) REFERENCES Response(ResponseID),
    FOREIGN KEY (SalesTerritoryKey) REFERENCES SalesTerritory(SalesTerritoryKey),
    UNIQUE (CustomerKey)
);
GO
UPDATE Customer
SET ResponseID = 1;
GO
-- Crie uma stored procedure para realizar a migra��o de dados da tabela Customer
CREATE PROCEDURE dbo.MigrateCustomerData
AS
BEGIN
    BEGIN TRY
        -- Inicie a transa��o para garantir consist�ncia
        BEGIN TRANSACTION;

		SET IDENTITY_INSERT Customer ON;

        -- Inser��o de dados na tabela Customer
        INSERT INTO Customer (CustomerKey, Title, FirstName, MiddleName, LastName, 
        EmailAddress, NameStyle, BirthDate, MaritalStatus, Gender, YearlyIncome, 
        TotalChildren, NumberChildrenAtHome, Education, Occupation, HouseOwnerFlag, 
        NumberCarsOwned, AddressLine1, AddressLine2, City, StateProvinceCode, 
        StateProvinceName, CountryRegionCode, CountryRegionName, PostalCode, Phone, 
        DateFirstPurchase, CommuteDistance, SalesTerritoryKey)
        SELECT CustomerKey, Title, FirstName, MiddleName, LastName, EmailAddress, 
        NameStyle, BirthDate, MaritalStatus, Gender, YearlyIncome, TotalChildren, 
        NumberChildrenAtHome, Education, Occupation, HouseOwnerFlag, NumberCarsOwned, AddressLine1, AddressLine2, 
        City, StateProvinceCode, StateProvinceName, CountryRegionCode, CountryRegionName, PostalCode, Phone, DateFirstPurchase, CommuteDistance, SalesTerritoryKey
        FROM AdventureOldData.dbo.Customer;
		SET IDENTITY_INSERT Customer OFF;
        -- Commit da transa��o se a inser��o for bem-sucedida
        COMMIT;
    END TRY
    BEGIN CATCH
        -- Rollback da transa��o em caso de erro
        ROLLBACK;

        -- Tratamento de erros
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorNumber INT = ERROR_NUMBER();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        -- Registo do erro num log de erros 
        EXEC dbo.LogError @ErrorMessage, @ErrorNumber, @ErrorSeverity, @ErrorState;

        -- Exibir uma mensagem amig�vel para o utilizador
        THROW 50000, 'Ocorreu um erro durante a migra��o de dados da tabela Customer. Entre em contato com o suporte.', 1;
    END CATCH
END;

GO
--Executar o procedimento
exec dbo.MigrateCustomerData;
GO
--Identificação: 202100744_202100728
-- Criacao da tabela SentEmails
CREATE TABLE SentEmails
(
  SentEmailID INT IDENTITY(1,1) NOT NULL,
  Mensage NVARCHAR(MAX),
  Timestamp DATETIME,
  CustomerKey INT NOT NULL,
  PRIMARY KEY (SentEmailID),
  FOREIGN KEY (CustomerKey) REFERENCES Customer(CustomerKey)
);
GO
--Identificação: 202100744_202100728
-- Criação da tabela de Acessos
CREATE TABLE Acessos (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerKey INT, 
    DataAcesso DATETIME,
    FOREIGN KEY (CustomerKey) REFERENCES Customer(CustomerKey)
);
GO
-- Criacao da tabela SalesOrders
CREATE TABLE SalesOrders
(
    SalesOrderNumber NVARCHAR(255) PRIMARY KEY,
    OrderDate DATE NOT NULL,
    DueDate DATE NOT NULL,
    ShipDate DATE,
    CustomerKey int NOT NULL,
    SalesTerritoryKey int NOT NULL,
    PromotionKey float NOT NULL,
    CurrencyKey int NOT NULL,
    FOREIGN KEY (CustomerKey) REFERENCES Customer(CustomerKey),
    FOREIGN KEY (SalesTerritoryKey) REFERENCES SalesTerritory(SalesTerritoryKey),
    FOREIGN KEY (CurrencyKey) REFERENCES Currency(CurrencyKey)
);
GO
-- Criacao a stored procedure para mover os dados
CREATE PROCEDURE dbo.MigrateSalesOrder
AS
BEGIN
    BEGIN TRY

    --Insercao da nova tabela SalesOrders
        INSERT INTO SalesOrders
        (
            CustomerKey, PromotionKey, CurrencyKey, SalesTerritoryKey,
            SalesOrderNumber, OrderDate, DueDate, ShipDate
        )
        --Consulta para ir buscar os dados a tabela SalesOrders da base de dados antiga
        SELECT
            CustomerKey, PromotionKey, CurrencyKey, SalesTerritoryKey,
            SalesOrderNumber, OrderDate, DueDate, ShipDate
        FROM AdventureOldData.dbo.sales2;
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorNumber INT = ERROR_NUMBER();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        EXEC dbo.LogError @ErrorMessage, @ErrorNumber, @ErrorSeverity, @ErrorState;

        THROW 50000, 'Ocorreu um erro durante a migra��o de dados da tabela SalesOrders. Entre em contato com o suporte.', 1;
    END CATCH
END;
GO
--Executar procedimento
EXEC dbo.MigrateSalesOrder;
GO
-- Tabela SalesOrderCosts
CREATE TABLE SalesOrderCosts
(
    SalesOrderNumber NVARCHAR(255) PRIMARY KEY,
    ProductStandardCost float NOT NULL,
    TotalProductCost float NOT NULL,
    FOREIGN KEY (SalesOrderNumber) REFERENCES SalesOrders(SalesOrderNumber)
);
GO
CREATE PROCEDURE dbo.MigrateSalesOrderCosts
AS
BEGIN
    BEGIN TRY

    --Insercao da nova tabea SalesOrderCosts
        INSERT INTO SalesOrderCosts
        (
            SalesOrderNumber, ProductStandardCost, TotalProductCost
        )
        --Consulta para ir buscar os dados a tabela Sales2 da base de dados antiga
        SELECT
            SalesOrderNumber, ProductStandardCost, TotalProductCost
        FROM AdventureOldData.dbo.sales2;
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorNumber INT = ERROR_NUMBER();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        EXEC dbo.LogError @ErrorMessage, @ErrorNumber, @ErrorSeverity, @ErrorState;

        THROW 50000, 'Ocorreu um erro durante a migra��o de dados da tabela SalesOrderCosts. Entre em contato com o suporte.', 1;
    END CATCH
END;
GO
--Executar o procedimento
EXEC dbo.MigrateSalesOrderCosts;
GO
-- Tabela OrderDetails
CREATE TABLE OrderDetails
(
    SalesOrderNumber NVARCHAR(255) NOT NULL,
    SalesOrderLineNumber float NOT NULL,
    ProductKey int NOT NULL,
    RevisionNumber float NOT NULL,
    OrderQuantity float NOT NULL,
    UnitPrice float NOT NULL,
    ExtendedAmount float NOT NULL,
    UnitPriceDiscountPct float NOT NULL,
    DiscountAmount float NOT NULL,
    ProductStandardCost float NOT NULL,
    TotalProductCost float NOT NULL,
    SalesAmount float NOT NULL,
    TaxAmt float NOT NULL,
    Freight float NOT NULL,
    CarrierTrackingNumber NVARCHAR(255),
    CustomerPONumber NVARCHAR(255),
    PRIMARY KEY (SalesOrderNumber, SalesOrderLineNumber),
    FOREIGN KEY (SalesOrderNumber) REFERENCES SalesOrders(SalesOrderNumber),
    FOREIGN KEY (ProductKey) REFERENCES Products(ProductKey)
);
GO
-- Criacao a stored procedure para mover os dados
CREATE PROCEDURE dbo.MigrateOrderDetails
AS
BEGIN
    BEGIN TRY

    --Insercao da nova tabela OrderDetails
        INSERT INTO OrderDetails
        (
            ProductKey, SalesOrderNumber, SalesOrderLineNumber, RevisionNumber, OrderQuantity, UnitPrice, ExtendedAmount, UnitPriceDiscountPct,
            DiscountAmount, ProductStandardCost, TotalProductCost, SalesAmount, TaxAmt, Freight, CarrierTrackingNumber,
            CustomerPONumber
        )
        --Consulta para ir buscar os dados a tabela OrderDetails da base de dados antiga
        SELECT
            ProductKey, SalesOrderNumber, SalesOrderLineNumber, RevisionNumber, OrderQuantity, UnitPrice, ExtendedAmount, UnitPriceDiscountPct,
            DiscountAmount, ProductStandardCost, TotalProductCost, SalesAmount, TaxAmt, Freight, CarrierTrackingNumber,
            CustomerPONumber
        FROM AdventureOldData.dbo.sales2;
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorNumber INT = ERROR_NUMBER();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        EXEC dbo.LogError @ErrorMessage, @ErrorNumber, @ErrorSeverity, @ErrorState;

        THROW 50000, 'Ocorreu um erro durante a migra��o de dados da tabela OrderDetails. Entre em contato com o suporte.', 1;
    END CATCH
END;
GO
--Executar procedimento
EXEC dbo.MigrateOrderDetails;