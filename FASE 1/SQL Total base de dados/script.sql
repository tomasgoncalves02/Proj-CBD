--Identificação: 202100744_202100728

USE [AdventureWorks]
GO
/****** Object:  Table [dbo].[MetadadosTabelas]    Script Date: 16/11/2023 13:54:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MetadadosTabelas](
	[TabelaID] [int] IDENTITY(1,1) NOT NULL,
	[NomeTabela] [nvarchar](128) NULL,
	[NomeColuna] [nvarchar](128) NULL,
	[TipoDados] [nvarchar](128) NULL,
	[Tamanho] [int] NULL,
	[Restricoes] [nvarchar](512) NULL,
	[DataAlteracao] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[TabelaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[MetadadosTabelas_View]    Script Date: 16/11/2023 13:54:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[MetadadosTabelas_View]
AS
SELECT
    NomeTabela,
    NomeColuna,
    TipoDados,
    Tamanho,
    Restricoes,
    DataAlteracao
FROM dbo.MetadadosTabelas
WHERE DataAlteracao = (SELECT MAX(DataAlteracao) FROM dbo.MetadadosTabelas);
GO
/****** Object:  Table [dbo].[Sales2]    Script Date: 16/11/2023 13:54:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sales2](
	[ProductKey] [int] NOT NULL,
	[OrderDateKey] [int] NOT NULL,
	[DueDateKey] [int] NOT NULL,
	[ShipDateKey] [int] NOT NULL,
	[CustomerKey] [int] NOT NULL,
	[PromotionKey] [int] NOT NULL,
	[CurrencyKey] [int] NOT NULL,
	[SalesTerritoryKey] [int] NOT NULL,
	[SalesOrderNumber] [varchar](255) NOT NULL,
	[SalesOrderLineNumber] [int] NOT NULL,
	[RevisionNumber] [int] NOT NULL,
	[OrderQuantity] [int] NOT NULL,
	[UnitPrice] [int] NOT NULL,
	[ExtendedAmount] [int] NOT NULL,
	[UnitPriceDiscountPct] [int] NOT NULL,
	[DiscountAmount] [int] NOT NULL,
	[ProductStandardCost] [int] NOT NULL,
	[TotalProductCost] [int] NOT NULL,
	[SalesAmount] [int] NOT NULL,
	[TaxAmt] [int] NOT NULL,
	[Freight] [int] NOT NULL,
	[CarrierTrackingNumber] [nvarchar](255) NULL,
	[CustomerPONumber] [nvarchar](255) NULL,
	[OrderDate] [date] NOT NULL,
	[DueDate] [date] NOT NULL,
	[ShipDate] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductKey] ASC,
	[CustomerKey] ASC,
	[SalesTerritoryKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 16/11/2023 13:54:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[ProductKey] [int] IDENTITY(1,1) NOT NULL,
	[CategoryListID] [int] NOT NULL,
	[ColorKey] [int] NULL,
	[ModelKey] [int] NULL,
	[WeightUnitMeasureCode] [varchar](5) NULL,
	[SizeUnitMeasureCode] [varchar](5) NULL,
	[EnglishProductName] [varchar](255) NOT NULL,
	[SpanishProductName] [varchar](255) NULL,
	[FrenchProductName] [varchar](255) NULL,
	[StandardCost] [float] NULL,
	[FinishedGoodsFlag] [varchar](30) NOT NULL,
	[SafetyStockLevel] [int] NOT NULL,
	[ListPrice] [float] NULL,
	[Size] [varchar](55) NULL,
	[SizeRange] [varchar](55) NULL,
	[Weight] [float] NULL,
	[DaysToManufacture] [bit] NOT NULL,
	[ProductLine] [char](1) NULL,
	[DealerPrice] [float] NULL,
	[Class] [char](1) NULL,
	[Style] [char](1) NULL,
	[EnglishDescription] [varchar](255) NULL,
	[FrenchDescription] [varchar](max) NULL,
	[Status] [varchar](55) NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[ProductKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 16/11/2023 13:54:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[CustomerKey] [int] IDENTITY(1,1) NOT NULL,
	[Title] [varchar](55) NULL,
	[FirstName] [varchar](40) NOT NULL,
	[MiddleName] [varchar](20) NULL,
	[LastName] [varchar](20) NULL,
	[EmailAddress] [varchar](80) NOT NULL,
	[Password] [varchar](60) NULL,
	[NameStyle] [varchar](20) NOT NULL,
	[BirthDate] [date] NOT NULL,
	[MaritalStatus] [char](1) NOT NULL,
	[Gender] [char](1) NOT NULL,
	[YearlyIncome] [int] NOT NULL,
	[TotalChildren] [int] NOT NULL,
	[NumberChildrenAtHome] [int] NOT NULL,
	[Education] [varchar](255) NOT NULL,
	[Occupation] [varchar](40) NOT NULL,
	[HouseOwnerFlag] [bit] NOT NULL,
	[NumberCarsOwned] [int] NOT NULL,
	[AddressLine1] [varchar](60) NOT NULL,
	[AddressLine2] [varchar](60) NULL,
	[City] [varchar](60) NOT NULL,
	[StateProvinceCode] [varchar](60) NULL,
	[StateProvinceName] [varchar](60) NULL,
	[CountryRegionCode] [varchar](6) NULL,
	[CountryRegionName] [varchar](20) NULL,
	[PostalCode] [nvarchar](55) NULL,
	[Phone] [varchar](55) NOT NULL,
	[DateFirstPurchase] [date] NOT NULL,
	[CommuteDistance] [varchar](30) NOT NULL,
	[SalesTerritoryKey] [int] NOT NULL,
	[ResponseID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[CustomerKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[CustomerKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[HistoricoComprasCliente]    Script Date: 16/11/2023 13:54:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[HistoricoComprasCliente] AS
    SELECT 
        S2.SalesOrderNumber,
        S2.OrderDate,
        P.EnglishProductName AS NomeDoProduto,
        P.ListPrice AS PrecoDoProduto,
        C.CustomerKey
    FROM Sales2 AS S2
    INNER JOIN Customer AS C ON S2.CustomerKey = C.CustomerKey
    INNER JOIN Products AS P ON S2.ProductKey = P.ProductKey;
GO
/****** Object:  View [dbo].[CustomerPurchasesView]    Script Date: 16/11/2023 13:54:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[CustomerPurchasesView] AS
    SELECT 
        S2.SalesOrderNumber,
        S2.SalesOrderLineNumber,
        S2.OrderDate,
        S2.DueDate,
        S2.ShipDate,
        P.EnglishProductName AS ProductName,
        P.ListPrice AS ProductPrice,
        C.CustomerKey  
    FROM Sales2 AS S2
    INNER JOIN Customer AS C ON S2.CustomerKey = C.CustomerKey
    INNER JOIN Products AS P ON S2.ProductKey = P.ProductKey;
GO
/****** Object:  View [dbo].[CustomerDetailsView]    Script Date: 16/11/2023 13:54:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[CustomerDetailsView] AS
    SELECT *
    FROM Customer;
GO
/****** Object:  Table [dbo].[SalesTerritory]    Script Date: 16/11/2023 13:54:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SalesTerritory](
	[SalesTerritoryKey] [int] IDENTITY(1,1) NOT NULL,
	[SalesTerritoryRegion] [nvarchar](30) NOT NULL,
	[SalesTerritoryGroup] [nvarchar](30) NOT NULL,
	[SalesTerritoryCountry] [nvarchar](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[SalesTerritoryKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[SalesTerritoryKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VendasPorTerritorioView]    Script Date: 16/11/2023 13:54:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VendasPorTerritorioView] AS
    SELECT 
        ST.SalesTerritoryRegion AS RegiaoDeVendas,
        COUNT(S2.SalesOrderNumber) AS TotalDeVendas
    FROM Sales2 AS S2
    INNER JOIN SalesTerritory AS ST ON S2.SalesTerritoryKey = ST.SalesTerritoryKey
    GROUP BY ST.SalesTerritoryRegion;
GO
/****** Object:  View [dbo].[ProdutosEmEstoqueView]    Script Date: 16/11/2023 13:54:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ProdutosEmEstoqueView] AS
    SELECT 
        P.EnglishProductName AS NomeDoProduto,
        P.ListPrice AS PrecoDoProduto,
        P.StandardCost AS CustoDoProduto
    FROM Products AS P
    WHERE P.FinishedGoodsFlag = 'TRUE';
GO
/****** Object:  Table [dbo].[Acessos]    Script Date: 16/11/2023 13:54:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Acessos](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerKey] [int] NULL,
	[DataAcesso] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CategoryList]    Script Date: 16/11/2023 13:54:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CategoryList](
	[CategoryListID] [int] IDENTITY(1,1) NOT NULL,
	[ProductCategoryKey] [int] NOT NULL,
	[ProductSubCategoryKey] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[CategoryListID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Color]    Script Date: 16/11/2023 13:54:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Color](
	[ColorKey] [int] IDENTITY(1,1) NOT NULL,
	[Color] [nvarchar](55) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ColorKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Currency]    Script Date: 16/11/2023 13:54:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Currency](
	[CurrencyKey] [int] IDENTITY(1,1) NOT NULL,
	[CurrencyAlternateKey] [nvarchar](5) NOT NULL,
	[CurrencyName] [nvarchar](55) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CurrencyKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[CurrencyName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[CurrencyAlternateKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[CurrencyKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ErrorLog]    Script Date: 16/11/2023 13:54:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ErrorLog](
	[ErrorLogID] [int] IDENTITY(1,1) NOT NULL,
	[ErrorMessage] [nvarchar](4000) NULL,
	[ErrorNumber] [int] NULL,
	[ErrorSeverity] [int] NULL,
	[ErrorState] [int] NULL,
	[Timestamp] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ErrorLogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EstatisticasTabelas]    Script Date: 16/11/2023 13:54:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EstatisticasTabelas](
	[TabelaID] [int] IDENTITY(1,1) NOT NULL,
	[NomeTabela] [nvarchar](128) NULL,
	[NumRegistros] [int] NULL,
	[EspacoOcupadoKB] [decimal](10, 2) NULL,
	[DataRegistro] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[TabelaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Model]    Script Date: 16/11/2023 13:54:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Model](
	[ModelKey] [int] IDENTITY(1,1) NOT NULL,
	[ModelName] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[ModelKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductCategory]    Script Date: 16/11/2023 13:54:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductCategory](
	[ProductCategoryKey] [int] IDENTITY(1,1) NOT NULL,
	[EnglishProductCategoryName] [nvarchar](55) NULL,
	[FrenchProductCategoryName] [nvarchar](55) NOT NULL,
	[SpanishProductCategoryName] [nvarchar](55) NULL,
	[ModifiedDate] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductCategoryKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductSubCategory]    Script Date: 16/11/2023 13:54:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductSubCategory](
	[ProductSubCategoryKey] [int] IDENTITY(1,1) NOT NULL,
	[EnglishProductSubCategoryName] [varchar](55) NOT NULL,
	[SpanishProductSubCategoryName] [varchar](55) NOT NULL,
	[FrenchProductSubCategoryName] [varchar](55) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductSubCategoryKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[FrenchProductSubCategoryName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[SpanishProductSubCategoryName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[EnglishProductSubCategoryName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Questions]    Script Date: 16/11/2023 13:54:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Questions](
	[QuestionID] [int] IDENTITY(1,1) NOT NULL,
	[Question] [varchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[QuestionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Response]    Script Date: 16/11/2023 13:54:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Response](
	[ResponseID] [int] IDENTITY(1,1) NOT NULL,
	[Response] [varchar](255) NOT NULL,
	[QuestionID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ResponseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SentEmails]    Script Date: 16/11/2023 13:54:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SentEmails](
	[SentEmailID] [int] IDENTITY(1,1) NOT NULL,
	[Mensage] [nvarchar](max) NULL,
	[Timestamp] [datetime] NULL,
	[CustomerKey] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[SentEmailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Acessos]  WITH CHECK ADD FOREIGN KEY([CustomerKey])
REFERENCES [dbo].[Customer] ([CustomerKey])
GO
ALTER TABLE [dbo].[CategoryList]  WITH CHECK ADD FOREIGN KEY([ProductCategoryKey])
REFERENCES [dbo].[ProductCategory] ([ProductCategoryKey])
GO
ALTER TABLE [dbo].[CategoryList]  WITH CHECK ADD FOREIGN KEY([ProductSubCategoryKey])
REFERENCES [dbo].[ProductSubCategory] ([ProductSubCategoryKey])
GO
ALTER TABLE [dbo].[Customer]  WITH CHECK ADD FOREIGN KEY([SalesTerritoryKey])
REFERENCES [dbo].[SalesTerritory] ([SalesTerritoryKey])
GO
ALTER TABLE [dbo].[Customer]  WITH CHECK ADD  CONSTRAINT [FK_Customer_Response] FOREIGN KEY([ResponseID])
REFERENCES [dbo].[Response] ([ResponseID])
GO
ALTER TABLE [dbo].[Customer] CHECK CONSTRAINT [FK_Customer_Response]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD FOREIGN KEY([CategoryListID])
REFERENCES [dbo].[CategoryList] ([CategoryListID])
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD FOREIGN KEY([ColorKey])
REFERENCES [dbo].[Color] ([ColorKey])
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD FOREIGN KEY([ModelKey])
REFERENCES [dbo].[Model] ([ModelKey])
GO
ALTER TABLE [dbo].[Response]  WITH CHECK ADD FOREIGN KEY([QuestionID])
REFERENCES [dbo].[Questions] ([QuestionID])
GO
ALTER TABLE [dbo].[Sales2]  WITH CHECK ADD FOREIGN KEY([CurrencyKey])
REFERENCES [dbo].[Currency] ([CurrencyKey])
GO
ALTER TABLE [dbo].[Sales2]  WITH CHECK ADD FOREIGN KEY([CustomerKey])
REFERENCES [dbo].[Customer] ([CustomerKey])
GO
ALTER TABLE [dbo].[Sales2]  WITH CHECK ADD FOREIGN KEY([ProductKey])
REFERENCES [dbo].[Products] ([ProductKey])
GO
ALTER TABLE [dbo].[Sales2]  WITH CHECK ADD FOREIGN KEY([SalesTerritoryKey])
REFERENCES [dbo].[SalesTerritory] ([SalesTerritoryKey])
GO
ALTER TABLE [dbo].[SentEmails]  WITH CHECK ADD FOREIGN KEY([CustomerKey])
REFERENCES [dbo].[Customer] ([CustomerKey])
GO
/****** Object:  StoredProcedure [dbo].[AdicionarAcesso]    Script Date: 16/11/2023 13:54:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AdicionarAcesso]
    @UserID INT
AS
BEGIN
    INSERT INTO Acessos (CustomerKey, DataAcesso)
    VALUES (@UserID, CURRENT_TIMESTAMP);

    -- Verificar se a inserção foi bem-sucedida
    IF @@ROWCOUNT > 0
    BEGIN
        PRINT 'Acesso adicionado com sucesso.';
    END
    ELSE
    BEGIN
        PRINT 'Erro ao adicionar o acesso.';
    END
END
GO
/****** Object:  StoredProcedure [dbo].[CreateErrorTrigger]    Script Date: 16/11/2023 13:54:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CreateErrorTrigger]
    @TableName NVARCHAR(255)
AS
BEGIN
    DECLARE @TriggerScript NVARCHAR(MAX);
    
    -- Construir o script do gatilho dinâmico
   SET @TriggerScript = '
    CREATE TRIGGER Trg_' + @TableName + '_Error
    ON ' + @TableName + '
    AFTER INSERT, UPDATE, DELETE
    AS
    BEGIN
        -- Simular um erro (substitua por sua lógica de verificação de erro)
        IF (EXISTS (SELECT 1 FROM inserted) AND EXISTS (SELECT 1 FROM deleted))
        BEGIN
            DECLARE @ErrorMessage NVARCHAR(4000) = ''Erro simulado ocorreu na tabela ' + @TableName + ' durante uma operação de UPDATE.'';
            DECLARE @ErrorNumber INT = 50000;  -- Número de erro personalizado
            DECLARE @ErrorSeverity INT = 16;   -- Severidade do erro
            DECLARE @ErrorState INT = 1;       -- Estado do erro
            
            -- Chamar o procedimento armazenado para registrar o erro
            EXEC dbo.ErrorLog @ErrorMessage, @ErrorNumber, @ErrorSeverity, @ErrorState;
        END;
    END;
';

    -- Executar o script do gatilho dinâmico
    EXEC sp_executesql @TriggerScript;
END;
GO
/****** Object:  StoredProcedure [dbo].[EditarAcessos]    Script Date: 16/11/2023 13:54:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EditarAcessos]
    @UserID INT
AS
BEGIN
    UPDATE Acessos
    SET DataAcesso = CURRENT_TIMESTAMP
    WHERE CustomerKey = @UserID;

    -- Verificar se a atualização foi bem-sucedida
    IF @@ROWCOUNT > 0
    BEGIN
        PRINT 'Acesso atualizado com sucesso.';
    END
    ELSE
    BEGIN
        PRINT 'Utilizador não encontrado ou acesso não atualizado.';
    END
END
GO
/****** Object:  StoredProcedure [dbo].[GerarEntradasTabelaMetadados]    Script Date: 16/11/2023 13:54:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Metadaos -> Stored Procedure para gerar entradas na tabela de metadados:
CREATE PROCEDURE [dbo].[GerarEntradasTabelaMetadados]
AS
BEGIN
    -- Crie uma tabela de metadados (se ainda n�o existir)
    IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'MetadadosTabelas')
    BEGIN
        CREATE TABLE dbo.MetadadosTabelas (
            TabelaID INT IDENTITY(1,1) PRIMARY KEY,
            NomeTabela NVARCHAR(128),
            NomeColuna NVARCHAR(128),
            TipoDados NVARCHAR(128),
            Tamanho INT,
            Restricoes NVARCHAR(512),
            DataAlteracao DATETIME
        );
    END

    -- Insira as informa��es das tabelas e colunas no cat�logo
    INSERT INTO dbo.MetadadosTabelas (NomeTabela, NomeColuna, TipoDados, Tamanho, Restricoes, DataAlteracao)
    SELECT
        t.name AS NomeTabela,
        c.name AS NomeColuna,
        ty.name AS TipoDados,
        c.max_length AS Tamanho,
        dc.definition AS Restricoes,
        GETDATE() AS DataAlteracao
    FROM sys.tables t
    INNER JOIN sys.columns c ON t.object_id = c.object_id
    LEFT JOIN sys.default_constraints dc ON c.default_object_id = dc.object_id
    INNER JOIN sys.types ty ON c.user_type_id = ty.user_type_id;
END;
GO
/****** Object:  StoredProcedure [dbo].[GetProductsSoldByCategoryAndYear]    Script Date: 16/11/2023 13:54:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetProductsSoldByCategoryAndYear]
AS
BEGIN
    BEGIN TRY
        SELECT PC.EnglishProductCategoryName, YEAR(S2.OrderDate) AS Ano, COUNT(S2.ProductKey) AS NumeroDeProdutosVendidos
        FROM dbo.Sales2 S2
        INNER JOIN dbo.Products P ON S2.ProductKey = P.ProductKey
        INNER JOIN dbo.CategoryList CL ON P.CategoryListID = CL.CategoryListID
        INNER JOIN dbo.ProductCategory PC ON CL.ProductCategoryKey = PC.ProductCategoryKey
        GROUP BY PC.EnglishProductCategoryName, YEAR(S2.OrderDate)
        ORDER BY Ano, PC.EnglishProductCategoryName;
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SELECT @ErrorMessage = ERROR_MESSAGE(),
               @ErrorSeverity = ERROR_SEVERITY(),
               @ErrorState = ERROR_STATE();

        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[GetSalesByProductCategory]    Script Date: 16/11/2023 13:54:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetSalesByProductCategory]
AS
BEGIN
    BEGIN TRY
        SELECT PC.EnglishProductCategoryName, SUM(S2.SalesAmount) AS TotalMonetarioDeVendas
        FROM dbo.Sales2 S2
        INNER JOIN dbo.Products P ON S2.ProductKey = P.ProductKey
        INNER JOIN dbo.CategoryList CL ON P.CategoryListID = CL.CategoryListID
        INNER JOIN dbo.ProductCategory PC ON CL.ProductCategoryKey = PC.ProductCategoryKey
        GROUP BY PC.EnglishProductCategoryName
        ORDER BY TotalMonetarioDeVendas DESC;
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SELECT @ErrorMessage = ERROR_MESSAGE(),
               @ErrorSeverity = ERROR_SEVERITY(),
               @ErrorState = ERROR_STATE();

        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[GetSalesByProductSubCategory]    Script Date: 16/11/2023 13:54:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetSalesByProductSubCategory]
AS
BEGIN
    BEGIN TRY
        SELECT PSC.EnglishProductSubCategoryName, SUM(S2.SalesAmount) AS TotalMonetarioDeVendas
        FROM dbo.Sales2 S2
        INNER JOIN dbo.Products P ON S2.ProductKey = P.ProductKey
        INNER JOIN dbo.CategoryList CL ON P.CategoryListID = CL.CategoryListID
        INNER JOIN dbo.ProductSubCategory PSC ON CL.ProductSubCategoryKey = PSC.ProductSubCategoryKey
        GROUP BY PSC.EnglishProductSubCategoryName
        ORDER BY TotalMonetarioDeVendas DESC;
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SELECT @ErrorMessage = ERROR_MESSAGE(),
               @ErrorSeverity = ERROR_SEVERITY(),
               @ErrorState = ERROR_STATE();

        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[GetSalesByYear]    Script Date: 16/11/2023 13:54:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetSalesByYear]
AS
BEGIN
    BEGIN TRY
        SELECT YEAR(S2.OrderDate) AS Ano, SUM(S2.SalesAmount) AS TotalMonetarioDeVendas
        FROM dbo.Sales2 S2
        GROUP BY YEAR(S2.OrderDate)
        ORDER BY Ano;
    END TRY
    BEGIN CATCH
        -- Captura de erro e tratamento
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SELECT @ErrorMessage = ERROR_MESSAGE(),
               @ErrorSeverity = ERROR_SEVERITY(),
               @ErrorState = ERROR_STATE();

  
        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[InsertSalesTerritoryData]    Script Date: 16/11/2023 13:54:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertSalesTerritoryData]
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

        -- Registre o erro em um log de erros (se j� existir a stored procedure de log de erros)
        -- EXEC dbo.LogError @ErrorMessage, @ErrorNumber, @ErrorSeverity, @ErrorState;

        THROW 50000, 'Ocorreu um erro durante a migração de dados da tabela SalesTerritory. Entre em contato com o suporte.', 1;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[LogError]    Script Date: 16/11/2023 13:54:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[LogError]
    @ErrorMessage NVARCHAR(4000),
    @ErrorNumber INT,
    @ErrorSeverity INT,
    @ErrorState INT
AS
BEGIN
    INSERT INTO ErrorLog (ErrorMessage, ErrorNumber, ErrorSeverity, ErrorState, Timestamp)
    VALUES (@ErrorMessage, @ErrorNumber, @ErrorSeverity, @ErrorState, GETDATE());
END;
GO
/****** Object:  StoredProcedure [dbo].[MigrateCategoryListData]    Script Date: 16/11/2023 13:54:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[MigrateCategoryListData]
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

        -- Registre o erro em um log de erros
        EXEC dbo.LogError @ErrorMessage, @ErrorNumber, @ErrorSeverity, @ErrorState;

        -- Exiba uma mensagem amigável para o usuário
        THROW 50000, 'Ocorreu um erro durante a migração de dados da tabela CategoryList. Entre em contato com o suporte.', 1;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[MigrateColorData]    Script Date: 16/11/2023 13:54:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[MigrateColorData]
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

        -- Registre o erro em um log de erros
        EXEC dbo.LogError @ErrorMessage, @ErrorNumber, @ErrorSeverity, @ErrorState;

        -- Exiba uma mensagem amigável para o usuário
        THROW 50000, 'Ocorreu um erro durante a migração de dados da tabela Color. Entre em contato com o suporte.', 1;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[MigrateCurrencyData]    Script Date: 16/11/2023 13:54:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[MigrateCurrencyData]
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

        -- Registre o erro em um log de erros (se tiver um)
        EXEC dbo.LogError @ErrorMessage, @ErrorNumber, @ErrorSeverity, @ErrorState;

        -- Exiba uma mensagem amig�vel para o usu�rio
        THROW 50000, 'Ocorreu um erro durante a migração de dados da tabela Color. Entre em contato com o suporte.', 1;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[MigrateCustomerData]    Script Date: 16/11/2023 13:54:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[MigrateCustomerData]
AS
BEGIN
    BEGIN TRY
        -- Inicie a transa��o para garantir consist�ncia
        BEGIN TRANSACTION;

		SET IDENTITY_INSERT Customer ON;

        -- Inser��o de dados na tabela Customer
        INSERT INTO Customer (CustomerKey, Title, FirstName, MiddleName, LastName, EmailAddress, NameStyle, BirthDate, MaritalStatus, Gender, YearlyIncome, TotalChildren, NumberChildrenAtHome, Education, Occupation, HouseOwnerFlag, NumberCarsOwned, AddressLine1, AddressLine2, City, StateProvinceCode, StateProvinceName, CountryRegionCode, CountryRegionName, PostalCode, Phone, DateFirstPurchase, CommuteDistance, SalesTerritoryKey)
        SELECT CustomerKey, Title, FirstName, MiddleName, LastName, EmailAddress, NameStyle, BirthDate, MaritalStatus, Gender, YearlyIncome, TotalChildren, NumberChildrenAtHome, Education, Occupation, HouseOwnerFlag, NumberCarsOwned, AddressLine1, AddressLine2, City, StateProvinceCode, StateProvinceName, CountryRegionCode, CountryRegionName, PostalCode, Phone, DateFirstPurchase, CommuteDistance, SalesTerritoryKey
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

        -- Registre o erro em um log de erros (se tiver um)
        EXEC dbo.LogError @ErrorMessage, @ErrorNumber, @ErrorSeverity, @ErrorState;

        -- Exiba uma mensagem amig�vel para o usu�rio
        THROW 50000, 'Ocorreu um erro durante a migra��o de dados da tabela Customer. Entre em contato com o suporte.', 1;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[MigrateModelData]    Script Date: 16/11/2023 13:54:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[MigrateModelData]
AS
BEGIN
    BEGIN TRY
        -- Inicie a transação para garantir a consistência dos dados
        BEGIN TRANSACTION;

        -- Inserção de dados na tabela Model
        INSERT INTO Model (ModelName)
        SELECT DISTINCT ModelName
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

        -- Registre o erro em um log de erros (se disponível)
        EXEC dbo.LogError @ErrorMessage, @ErrorNumber, @ErrorSeverity, @ErrorState;

        -- Exiba uma mensagem amigável para o usuário
        THROW 50000, 'Ocorreu um erro durante a migração de dados da tabela Model. Entre em contato com o suporte.', 1;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[MigrateProductCategoryData]    Script Date: 16/11/2023 13:54:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[MigrateProductCategoryData]
AS
BEGIN
    BEGIN TRY
        -- Inicie a transação para garantir a consistência dos dados
        BEGIN TRANSACTION;

        -- Inserção de dados na tabela ProductCategory
        INSERT INTO ProductCategory (EnglishProductCategoryName, FrenchProductCategoryName, SpanishProductCategoryName)
        SELECT DISTINCT EnglishProductCategoryName, FrenchProductCategoryName, SpanishProductCategoryName
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

        -- Registre o erro em um log de erros (se disponível)
        EXEC dbo.LogError @ErrorMessage, @ErrorNumber, @ErrorSeverity, @ErrorState;

        -- Exiba uma mensagem amigável para o usuário
        THROW 50000, 'Ocorreu um erro durante a migração de dados da tabela ProductCategory. Entre em contato com o suporte.', 1;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[MigrateProductsData]    Script Date: 16/11/2023 13:54:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
        INNER JOIN AdventureWorks.dbo.Color c ON p.Color = c.Color
        INNER JOIN AdventureWorks.dbo.Model b ON p.ModelName = b.ModelName 
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
/****** Object:  StoredProcedure [dbo].[MigrateProductSubCategoryData]    Script Date: 16/11/2023 13:54:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[MigrateProductSubCategoryData]
AS
BEGIN
    BEGIN TRY
        -- Inicie a transa��o para garantir a consist�ncia dos dados
        BEGIN TRANSACTION;

        -- Inser��o de dados na tabela ProductSubCategory
        INSERT INTO ProductSubCategory (EnglishProductSubCategoryName, SpanishProductSubCategoryName, FrenchProductSubCategoryName)
        SELECT EnglishProductSubCategoryName, SpanishProductSubCategoryName, FrenchProductSubCategoryName
        FROM AdventureOldData.dbo.ProductSubCategory;

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

        -- Registre o erro em um log de erros (se dispon�vel)
        EXEC dbo.LogError @ErrorMessage, @ErrorNumber, @ErrorSeverity, @ErrorState;

        -- Exiba uma mensagem amig�vel para o usu�rio
        THROW 50000, 'Ocorreu um erro durante a migração de dados da tabela ProductSubCategory. Entre em contato com o suporte.', 1;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[MigrateSalesData]    Script Date: 16/11/2023 13:54:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[MigrateSalesData]
AS
BEGIN
    BEGIN TRY
        INSERT INTO Sales2
        (
            ProductKey, OrderDateKey, DueDateKey, ShipDateKey, CustomerKey, PromotionKey, CurrencyKey, SalesTerritoryKey,
            SalesOrderNumber, SalesOrderLineNumber, RevisionNumber, OrderQuantity, UnitPrice, ExtendedAmount, UnitPriceDiscountPct,
            DiscountAmount, ProductStandardCost, TotalProductCost, SalesAmount, TaxAmt, Freight, CarrierTrackingNumber,
            CustomerPONumber, OrderDate, DueDate, ShipDate
        )
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

        THROW 50000, 'Ocorreu um erro durante a migração de dados da tabela Sales2. Entre em contato com o suporte.', 1;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[RegistrarEstatisticasTabelas]    Script Date: 16/11/2023 13:54:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RegistrarEstatisticasTabelas]
AS
BEGIN
    -- Crie uma tabela de estatísticas (se ainda não existir)
    IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'EstatisticasTabelas')
    BEGIN
        CREATE TABLE dbo.EstatisticasTabelas (
            TabelaID INT IDENTITY(1,1) PRIMARY KEY,
            NomeTabela NVARCHAR(128),
            NumRegistros INT,
            EspacoOcupadoKB DECIMAL(10, 2),
            DataRegistro DATETIME
        );
    END

    -- Insira as estatísticas para cada tabela
    INSERT INTO dbo.EstatisticasTabelas (NomeTabela, NumRegistros, EspacoOcupadoKB, DataRegistro)
    SELECT
        t.name AS NomeTabela,
        SUM(p.rows) AS NumRegistros,
        SUM(a.total_pages) * 8 / 1024 AS EspacoOcupadoKB,
        GETDATE() AS DataRegistro
    FROM sys.tables t
    INNER JOIN sys.indexes i ON t.object_id = i.object_id
    INNER JOIN sys.partitions p ON i.object_id = p.object_id AND i.index_id = p.index_id
    INNER JOIN sys.allocation_units a ON p.partition_id = a.container_id
    GROUP BY t.name;
END;
GO
/****** Object:  StoredProcedure [dbo].[RemoverAcesso]    Script Date: 16/11/2023 13:54:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RemoverAcesso]
    @UserID INT
AS
BEGIN
    DELETE FROM Acessos
    WHERE CustomerKey = @UserID;

    -- Verificar se a exclusão foi bem-sucedida
    IF @@ROWCOUNT > 0
    BEGIN
        PRINT 'Acesso removido com sucesso.';
    END
    ELSE
    BEGIN
        PRINT 'Erro ao remover o acesso. Utilizador não encontrado.';
    END
END
GO
/****** Object:  StoredProcedure [dbo].[sp_SendPasswordResetEmail]    Script Date: 16/11/2023 13:54:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Criação da procedure sp_SendPasswordResetEmail
CREATE PROCEDURE [dbo].[sp_SendPasswordResetEmail]
  @RecipientEmail NVARCHAR(80),
  @EmailSubject NVARCHAR(255),
  @CustomerKey INT,
  @SecurityQuestion NVARCHAR(255),
  @SecurityAnswer NVARCHAR(255)
AS
BEGIN
  -- Gera uma senha aleatória
  DECLARE @CharacterSet NVARCHAR(255) = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  DECLARE @NewPassword NVARCHAR(60) = '';
  DECLARE @Counter INT = 1;

  WHILE @Counter <= 12 -- Altere o número 12 para o comprimento desejado da senha
  BEGIN
    SET @NewPassword = @NewPassword + SUBSTRING(@CharacterSet, CAST(RAND() * LEN(@CharacterSet) + 1 AS INT), 1);
    SET @Counter = @Counter + 1;
  END

  -- Simular o envio do e-mail (este é um exemplo fictício)
  PRINT 'Simulating email sending to ' + @RecipientEmail;
  PRINT 'Subject: ' + @EmailSubject;
  PRINT 'Body: Your new password is ' + @NewPassword;

  -- Insira os dados na tabela SentEmails
  INSERT INTO SentEmails (Mensage, Timestamp, CustomerKey)
  VALUES ('Your new password is ' + @NewPassword, GETDATE(), @CustomerKey);

  -- Verifica a resposta à pergunta de segurança usando a tabela Response
  IF EXISTS (
    SELECT 1
    FROM Response AS r
    JOIN Questions AS q ON r.QuestionID = q.QuestionID
    WHERE r.Response = @SecurityAnswer
      AND q.Question = @SecurityQuestion
  )
  BEGIN
    -- Simular uma atualização de senha na tabela Customer
    UPDATE Customer
    SET Password = @NewPassword
    WHERE CustomerKey = @CustomerKey;

    PRINT 'Senha atualizada com sucesso!';
  END
  ELSE
  BEGIN
    PRINT 'Resposta à pergunta de segurança incorreta. A senha não foi alterada.';
  END
END;
GO
