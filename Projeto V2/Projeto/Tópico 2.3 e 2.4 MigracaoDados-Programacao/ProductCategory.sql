-- Tabela ProductCategory
CREATE TABLE ProductCategory
(
    ProductCategoryKey INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    EnglishProductCategoryName NVARCHAR(55),
    FrenchProductCategoryName NVARCHAR(55) NOT NULL,
    SpanishProductCategoryName NVARCHAR(55),
    ModifiedDate DATE
);


-- Crie uma stored procedure para realizar a migração de dados para a tabela ProductCategory
CREATE PROCEDURE dbo.MigrateProductCategoryData
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

        -- Exiba uma mensagem amigável para o utilizador
        THROW 50000, 'Ocorreu um erro durante a migração de dados da tabela ProductCategory. Entre em contato com o suporte.', 1;
    END CATCH
END;

--executar o procedimento
exec dbo.MigrateProductCategoryData;