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

