USE [AdventureWorks]
GO
/****** Object:  Table [dbo].[Acessos]    Script Date: 13/12/2023 17:31:29 ******/
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
/****** Object:  Table [dbo].[CategoryList]    Script Date: 13/12/2023 17:31:29 ******/
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
/****** Object:  Table [dbo].[Color]    Script Date: 13/12/2023 17:31:29 ******/
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
/****** Object:  Table [dbo].[Currency]    Script Date: 13/12/2023 17:31:29 ******/
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
/****** Object:  Table [dbo].[Customer]    Script Date: 13/12/2023 17:31:29 ******/
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
/****** Object:  Table [dbo].[ErrorLog]    Script Date: 13/12/2023 17:31:29 ******/
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
/****** Object:  Table [dbo].[EstatisticasTabelas]    Script Date: 13/12/2023 17:31:29 ******/
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
/****** Object:  Table [dbo].[MetadadosTabelas]    Script Date: 13/12/2023 17:31:29 ******/
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
/****** Object:  Table [dbo].[Model]    Script Date: 13/12/2023 17:31:29 ******/
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
/****** Object:  Table [dbo].[OrderDetails]    Script Date: 13/12/2023 17:31:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetails](
	[SalesOrderNumber] [varchar](255) NOT NULL,
	[SalesOrderLineNumber] [int] NOT NULL,
	[ProductKey] [int] NOT NULL,
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
PRIMARY KEY CLUSTERED 
(
	[SalesOrderNumber] ASC,
	[SalesOrderLineNumber] ASC,
	[ProductKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductCategory]    Script Date: 13/12/2023 17:31:29 ******/
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
/****** Object:  Table [dbo].[Products]    Script Date: 13/12/2023 17:31:29 ******/
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
/****** Object:  Table [dbo].[ProductSubCategory]    Script Date: 13/12/2023 17:31:29 ******/
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
/****** Object:  Table [dbo].[Questions]    Script Date: 13/12/2023 17:31:29 ******/
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
/****** Object:  Table [dbo].[Response]    Script Date: 13/12/2023 17:31:29 ******/
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
/****** Object:  Table [dbo].[SalesOrder]    Script Date: 13/12/2023 17:31:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SalesOrder](
	[SalesOrderNumber] [varchar](255) NOT NULL,
	[OrderDate] [date] NOT NULL,
	[DueDate] [date] NOT NULL,
	[ShipDate] [date] NULL,
	[CustomerKey] [int] NOT NULL,
	[PromotionKey] [int] NOT NULL,
	[CurrencyKey] [int] NOT NULL,
	[SalesTerritoryKey] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[SalesOrderNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SalesTerritory]    Script Date: 13/12/2023 17:31:29 ******/
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
/****** Object:  Table [dbo].[SentEmails]    Script Date: 13/12/2023 17:31:29 ******/
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
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD FOREIGN KEY([ProductKey])
REFERENCES [dbo].[Products] ([ProductKey])
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD FOREIGN KEY([SalesOrderNumber])
REFERENCES [dbo].[SalesOrder] ([SalesOrderNumber])
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
ALTER TABLE [dbo].[SalesOrder]  WITH CHECK ADD FOREIGN KEY([CurrencyKey])
REFERENCES [dbo].[Currency] ([CurrencyKey])
GO
ALTER TABLE [dbo].[SalesOrder]  WITH CHECK ADD FOREIGN KEY([CustomerKey])
REFERENCES [dbo].[Customer] ([CustomerKey])
GO
ALTER TABLE [dbo].[SalesOrder]  WITH CHECK ADD FOREIGN KEY([SalesTerritoryKey])
REFERENCES [dbo].[SalesTerritory] ([SalesTerritoryKey])
GO
ALTER TABLE [dbo].[SentEmails]  WITH CHECK ADD FOREIGN KEY([CustomerKey])
REFERENCES [dbo].[Customer] ([CustomerKey])
GO
