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