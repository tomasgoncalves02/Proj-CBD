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