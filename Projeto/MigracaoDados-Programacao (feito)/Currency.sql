
--Criacao da tabela Currency
CREATE TABLE Currency
(
    CurrencyKey INT IDENTITY(1,1) PRIMARY KEY,
    CurrencyAlternateKey NVARCHAR(5) NOT NULL,
    CurrencyName NVARCHAR(55) NOT NULL,
    UNIQUE (CurrencyKey),
    UNIQUE (CurrencyAlternateKey),
    UNIQUE (CurrencyName)
);

-- Crie uma stored procedure para realizar a migra��o de dados da tabela Currency
CREATE PROCEDURE dbo.MigrateCurrencyData
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

        -- Exiba uma mensagem amig�vel para o utilizador
        THROW 50000, 'Ocorreu um erro durante a migração de dados da tabela Color. Entre em contato com o suporte.', 1;
    END CATCH
END;

exec dbo.MigrateCurrencyData;