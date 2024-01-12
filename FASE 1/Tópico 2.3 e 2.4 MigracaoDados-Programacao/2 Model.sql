--Identificação: 202100744_202100728

-- Tabela Model
CREATE TABLE Model
(
    ModelKey INT IDENTITY(1,1) NOT NULL,
    ModelName VARCHAR(255),
    PRIMARY KEY (ModelKey)
);


-- Crie uma stored procedure para realizar a migra��o de dados para a tabela Model
CREATE PROCEDURE dbo.MigrateModelData
AS
BEGIN
    BEGIN TRY
        -- Inicie a transa��o para garantir a consist�ncia dos dados
        BEGIN TRANSACTION;

        -- Inser��o de dados na tabela Model
        INSERT INTO Model (ModelName)
        SELECT DISTINCT ModelName
        FROM AdventureOldData.dbo.Products;

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

        -- Registo do erro num log de erros 
        EXEC dbo.LogError @ErrorMessage, @ErrorNumber, @ErrorSeverity, @ErrorState;

        -- Exibir uma mensagem amig�vel para o utilizador
        THROW 50000, 'Ocorreu um erro durante a migra��o de dados da tabela Model. Entre em contato com o suporte.', 1;
    END CATCH
END;

--Executar o procedimento
exec dbo.MigrateModelData;



