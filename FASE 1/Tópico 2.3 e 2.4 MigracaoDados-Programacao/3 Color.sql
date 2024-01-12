--Identificação: 202100744_202100728
-- Criação da tabela Color
CREATE TABLE Color
(
  ColorKey INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
  Color NVARCHAR(55) NOT NULL
);


-- Crie uma stored procedure para realizar a migração de dados
CREATE PROCEDURE dbo.MigrateColorData
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

        -- Registo do erro num log de erros
        EXEC dbo.LogError @ErrorMessage, @ErrorNumber, @ErrorSeverity, @ErrorState;

        -- Exibir uma mensagem amigável para o utilizador
        THROW 50000, 'Ocorreu um erro durante a migração de dados da tabela Color. Entre em contato com o suporte.', 1;
    END CATCH
END;

exec dbo.MigrateColorData;