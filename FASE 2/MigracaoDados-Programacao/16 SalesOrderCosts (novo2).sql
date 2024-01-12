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