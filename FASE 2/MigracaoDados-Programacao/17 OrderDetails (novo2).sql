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