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