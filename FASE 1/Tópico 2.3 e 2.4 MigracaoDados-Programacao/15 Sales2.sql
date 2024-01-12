--Identificação: 202100744_202100728
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

-- Criacao a stored procedure para mover os dados
CREATE PROCEDURE dbo.MigrateSalesData
AS
BEGIN
    BEGIN TRY

    --Insercao da nova tabea Sales2
        INSERT INTO Sales2
        (
            ProductKey, OrderDateKey, DueDateKey, ShipDateKey, CustomerKey, PromotionKey, CurrencyKey, SalesTerritoryKey,
            SalesOrderNumber, SalesOrderLineNumber, RevisionNumber, OrderQuantity, UnitPrice, ExtendedAmount, UnitPriceDiscountPct,
            DiscountAmount, ProductStandardCost, TotalProductCost, SalesAmount, TaxAmt, Freight, CarrierTrackingNumber,
            CustomerPONumber, OrderDate, DueDate, ShipDate
        )
        --Consulta para ir buscar os dados a tabela Sales2 da base de dados antiga
        SELECT
            ProductKey, OrderDateKey, DueDateKey, ShipDateKey, CustomerKey, PromotionKey, CurrencyKey, SalesTerritoryKey,
            SalesOrderNumber, SalesOrderLineNumber, RevisionNumber, OrderQuantity, UnitPrice, ExtendedAmount, UnitPriceDiscountPct,
            DiscountAmount, ProductStandardCost, TotalProductCost, SalesAmount, TaxAmt, Freight, CarrierTrackingNumber,
            CustomerPONumber, OrderDate, DueDate, ShipDate
        FROM AdventureOldData.dbo.sales2;
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorNumber INT = ERROR_NUMBER();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        EXEC dbo.LogError @ErrorMessage, @ErrorNumber, @ErrorSeverity, @ErrorState;

        THROW 50000, 'Ocorreu um erro durante a migra��o de dados da tabela Sales2. Entre em contato com o suporte.', 1;
    END CATCH
END;

--Executar o procedimento
EXEC dbo.MigrateSalesData;



