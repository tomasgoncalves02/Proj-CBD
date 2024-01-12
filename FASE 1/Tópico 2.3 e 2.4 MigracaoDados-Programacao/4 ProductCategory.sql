--Identificação: 202100744_202100728
-- Tabela ProductCategory
CREATE TABLE ProductCategory
(
    ProductCategoryKey INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    EnglishProductCategoryName NVARCHAR(55),
    FrenchProductCategoryName NVARCHAR(55) NOT NULL,
    SpanishProductCategoryName NVARCHAR(55),
    ModifiedDate DATE
);


-- Crie uma stored procedure para realizar a migracao de dados para a tabela ProductCategory
CREATE PROCEDURE dbo.MigrateProductCategoryData
AS
BEGIN
    BEGIN TRY
        -- Inicia a transacao para garantir a consistencia dos dados
        BEGIN TRANSACTION;

        -- Inserir de dados na tabela ProductCategory
        INSERT INTO ProductCategory (EnglishProductCategoryName, FrenchProductCategoryName, SpanishProductCategoryName)
        SELECT DISTINCT EnglishProductCategoryName, FrenchProductCategoryName, SpanishProductCategoryName
        FROM AdventureOldData.dbo.Products;

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

        -- Registar o erro em um log de erros
        EXEC dbo.LogError @ErrorMessage, @ErrorNumber, @ErrorSeverity, @ErrorState;

        -- Exiba uma mensagem amigavel para o utilizador
        THROW 50000, 'Ocorreu um erro durante a migracao de dados da tabela ProductCategory. Entre em contato com o suporte.', 1;
    END CATCH
END;

--Executar o procedimento
exec dbo.MigrateProductCategoryData;