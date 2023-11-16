-- Tabela Model
CREATE TABLE Model
(
    ModelKey INT IDENTITY(1,1) NOT NULL,
    ModelName VARCHAR(255),
    PRIMARY KEY (ModelKey)
);


-- Crie uma stored procedure para realizar a migração de dados para a tabela Model
CREATE PROCEDURE dbo.MigrateModelData
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

        -- Exiba uma mensagem amigável para o utilizador
        THROW 50000, 'Ocorreu um erro durante a migração de dados da tabela Model. Entre em contato com o suporte.', 1;
    END CATCH
END;

--Executar o procedimento
exec dbo.MigrateModelData;



