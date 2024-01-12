-- User 1 - Transa��o A
BEGIN TRANSACTION;

-- Information -> SalesOrders
DECLARE @SalesOrderNumber1 VARCHAR(255) = 'SO50000';
DECLARE @OrderDate1 DATE = GETDATE();
DECLARE @DueDate1 DATE;
DECLARE @ShipDate1 DATE;
DECLARE @CustomerKey1 INT = 11003;
DECLARE @SalesTerritoryKey1 INT = 9;
DECLARE @PromotionKey1 INT = 1;
DECLARE @CurrencyKey1 INT = 6;

-- Information -> OrderDetails 
DECLARE @ProductKey1 INT = 210;
DECLARE @OrderQuantity1 INT = 2; -- Definir um valor para OrderQuantity
DECLARE @UnitPrice1 FLOAT;
DECLARE @UnitPriceDiscountPct1 FLOAT = 5.0;
DECLARE @SalesOrderLineNumber1 INT = 1;
DECLARE @RevisionNumber1 INT = 1;
DECLARE @ExtendedAmount1 FLOAT;
DECLARE @DiscountAmount1 FLOAT;
DECLARE @ProductStandardCost1 FLOAT; -- SalesOrderCosts
DECLARE @TotalProductCost1 FLOAT; -- SalesOrderCosts
DECLARE @SalesAmount1 FLOAT;
DECLARE @TaxAmt1 FLOAT;
DECLARE @Freight1 FLOAT;

-- Obter informa��es do produto
SELECT 
    @UnitPrice1 = ISNULL(ListPrice, 0)
FROM 
    Products
WHERE 
    ProductKey = @ProductKey1;

BEGIN TRY
    -- Iniciar transa��o A
    BEGIN TRANSACTION;

	-- Cont -> SalesOrders
	IF NOT EXISTS (SELECT 1 FROM dbo.SalesOrders WHERE SalesOrderNumber = @SalesOrderNumber1)
	BEGIN
		-- SalesOrder n�o existe, prosseguir com a inser��o
		SET @DueDate1 = DATEADD(YEAR, 1, @OrderDate1);
		SET @ShipDate1 = DATEADD(DAY, -1, @DueDate1);

		-- Cont -> OrderDetails
		SET @ExtendedAmount1 = @UnitPrice1 * @OrderQuantity1;
		SET @DiscountAmount1 = 0.0;
		SET @ProductStandardCost1 = 5.0;
		SET @TotalProductCost1 = @ExtendedAmount1 + @DiscountAmount1 + @ProductStandardCost1;
		SET @SalesAmount1 = @ExtendedAmount1 - @DiscountAmount1;
		SET @TaxAmt1 = 2.0;
		SET @Freight1 = 3.0;

		-- Utilizar bloco TRY-CATCH para controle de erros
		BEGIN TRY
			-- Inserir na tabela SalesOrders
			INSERT INTO dbo.SalesOrders (SalesOrderNumber, OrderDate, DueDate, ShipDate, CustomerKey, SalesTerritoryKey, PromotionKey, CurrencyKey)
			VALUES (@SalesOrderNumber1, @OrderDate1, @DueDate1, @ShipDate1,@CustomerKey1,@SalesTerritoryKey1, @PromotionKey1, @CurrencyKey1);
			
			-- Verificar se a inser��o foi bem-sucedida
			DECLARE @RowCount1 INT = @@ROWCOUNT;
			IF @RowCount1 > 0
			BEGIN
				-- PRINT 'Inser��o na SalesOrders bem-sucedida.';
				
				-- Inserir na tabela OrderDetails
				INSERT INTO dbo.OrderDetails(SalesOrderNumber, SalesOrderLineNumber, ProductKey, RevisionNumber, OrderQuantity, UnitPrice, ExtendedAmount, UnitPriceDiscountPct, DiscountAmount, ProductStandardCost, TotalProductCost, SalesAmount, TaxAmt, Freight) 
				VALUES (@SalesOrderNumber1, @SalesOrderLineNumber1, @ProductKey1, @RevisionNumber1, @OrderQuantity1, @UnitPrice1, @ExtendedAmount1, @UnitPriceDiscountPct1, @DiscountAmount1, @ProductStandardCost1, @TotalProductCost1, @SalesAmount1, @TaxAmt1, @Freight1);
				
				-- Verificar se a inser��o na OrderDetails foi bem-sucedida
				DECLARE @RowCountOrderDetails1 INT = @@ROWCOUNT;
				IF @RowCountOrderDetails1 > 0
				BEGIN
					-- PRINT 'Inser��o na OrderDetails bem-sucedida.';
					-- add SalesOrderConts
					INSERT INTO dbo.SalesOrderCosts(SalesOrderNumber, ProductStandardCost, TotalProductCost)
					VALUES(@SalesOrderNumber1, @ProductStandardCost1, @TotalProductCost1);
				END
				ELSE
				BEGIN
					PRINT 'Falha na inser��o na OrderDetails.';
				END
			END
			ELSE
			BEGIN
				PRINT 'Falha na inser��o na SalesOrders.';
			END

			-- Efetivar a transa��o A
			COMMIT;
		END TRY
		BEGIN CATCH
			-- Em caso de erro, fazer rollback da transa��o A
			ROLLBACK;
			PRINT ERROR_MESSAGE();
		END CATCH;
	END
	ELSE
	BEGIN
		-- SalesOrder j� existe, imprimir mensagem de erro
		PRINT 'SalesOrderNumber1 j� existe na tabela SalesOrders.';
	END
END TRY
BEGIN CATCH
    -- Lidar com erros
    PRINT ERROR_MESSAGE();
END CATCH;
GO

-- User 2 - Transa��o B
DECLARE @SalesOrderNumber2 VARCHAR(255) = 'SO80000';
DECLARE @OrderDate2 DATE = GETDATE();
DECLARE @DueDate2 DATE;
DECLARE @ShipDate2 DATE;
DECLARE @CustomerKey2 INT = 11003;
DECLARE @SalesTerritoryKey2 INT = 9;
DECLARE @PromotionKey2 INT = 1;
DECLARE @CurrencyKey2 INT = 6;

-- Information -> OrderDetails 
DECLARE @ProductKey2 INT = 210;
DECLARE @OrderQuantity2 INT = 2; -- Definir um valor para OrderQuantity
DECLARE @UnitPrice2 FLOAT;
DECLARE @UnitPriceDiscountPct2 FLOAT = 5.0;
DECLARE @SalesOrderLineNumber2 INT = 1;
DECLARE @RevisionNumber2 INT = 1;
DECLARE @ExtendedAmount2 FLOAT;
DECLARE @DiscountAmount2 FLOAT;
DECLARE @ProductStandardCost2 FLOAT; -- SalesOrderCosts
DECLARE @TotalProductCost2 FLOAT; -- SalesOrderCosts
DECLARE @SalesAmount2 FLOAT;
DECLARE @TaxAmt2 FLOAT;
DECLARE @Freight2 FLOAT;

-- Obter informa��es do produto
SELECT 
    @UnitPrice2 = ISNULL(ListPrice, 0)
FROM 
    Products
WHERE 
    ProductKey = @ProductKey2;

BEGIN TRY
    -- Iniciar transa��o B
    BEGIN TRANSACTION;

	-- Cont -> SalesOrders
	IF NOT EXISTS (SELECT 1 FROM dbo.SalesOrders WHERE SalesOrderNumber = @SalesOrderNumber2)
	BEGIN
		-- SalesOrder n�o existe, prosseguir com a inser��o
		SET @DueDate2 = DATEADD(YEAR, 1, @OrderDate2);
		SET @ShipDate2 = DATEADD(DAY, -1, @DueDate2);

		-- Cont -> OrderDetails
		SET @ExtendedAmount2 = @UnitPrice2 * @OrderQuantity2;
		SET @DiscountAmount2 = 0.0;
		SET @ProductStandardCost2 = 6.0;
		SET @TotalProductCost2 = @ExtendedAmount2 + @DiscountAmount2 + @ProductStandardCost2;
		SET @SalesAmount2 = @ExtendedAmount2 - @DiscountAmount2;
		SET @TaxAmt2 = 3.0;
		SET @Freight2 = 4.0;

		-- Utilizar bloco TRY-CATCH para controle de erros
		BEGIN TRY
			
			-- Inserir na tabela SalesOrders
			INSERT INTO dbo.SalesOrders (SalesOrderNumber, OrderDate, DueDate, ShipDate, CustomerKey, SalesTerritoryKey, PromotionKey, CurrencyKey)
			VALUES (@SalesOrderNumber2, @OrderDate2, @DueDate2, @ShipDate2,@CustomerKey2,@SalesTerritoryKey2, @PromotionKey2, @CurrencyKey2);
			
			DECLARE @RowCount1 INT = @@ROWCOUNT;
			IF @RowCount1 > 0
			BEGIN
				-- Inserir na tabela OrderDetails
				INSERT INTO dbo.OrderDetails(SalesOrderNumber, SalesOrderLineNumber, ProductKey, RevisionNumber, OrderQuantity, UnitPrice, ExtendedAmount, UnitPriceDiscountPct, DiscountAmount, ProductStandardCost, TotalProductCost, SalesAmount, TaxAmt, Freight) 
				VALUES (@SalesOrderNumber2, @SalesOrderLineNumber2, @ProductKey2, @RevisionNumber2, @OrderQuantity2, @UnitPrice2, @ExtendedAmount2, @UnitPriceDiscountPct2, @DiscountAmount2, @ProductStandardCost2, @TotalProductCost2, @SalesAmount2, @TaxAmt2, @Freight2);
				
				DECLARE @RowCountOrderDetails1 INT = @@ROWCOUNT;
				IF @RowCountOrderDetails1 > 0
				BEGIN
					PRINT 'Inser��o na OrderDetails bem-sucedida.';
					-- add SalesOrderConts
					INSERT INTO dbo.SalesOrderCosts(SalesOrderNumber, ProductStandardCost, TotalProductCost)
					VALUES(@SalesOrderNumber2, @ProductStandardCost2, @TotalProductCost2);
				END
				ELSE
				BEGIN
					PRINT 'Falha na inser��o na OrderDetails.';
				END
			END
			ELSE
			BEGIN
				PRINT 'Falha na inser��o na SalesOrders.';
			END
			-- Efetivar a transa��o B
			COMMIT;
		END TRY
		BEGIN CATCH
			-- Em caso de erro, fazer rollback da transa��o B
			ROLLBACK;
			PRINT '1.';
			PRINT ERROR_MESSAGE();
		END CATCH;
	END
	ELSE
	BEGIN
		-- SalesOrder j� existe, imprimir mensagem de erro
		PRINT 'SalesOrderNumber2 j� existe na tabela SalesOrders.';
	END
END TRY
BEGIN CATCH
    -- Lidar com erros
    PRINT ERROR_MESSAGE();
END CATCH;
COMMIT;

-- Selecionar resultados
SELECT * FROM dbo.OrderDetails where SalesOrderNumber = 'SO50000' or SalesOrderNumber = 'SO80000';
