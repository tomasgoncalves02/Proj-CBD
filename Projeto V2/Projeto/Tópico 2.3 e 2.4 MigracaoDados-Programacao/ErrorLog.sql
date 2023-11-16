
-- Criação tabela ErrorLog
CREATE TABLE ErrorLog (
    ErrorLogID INT IDENTITY(1,1) PRIMARY KEY,
    ErrorMessage NVARCHAR(4000),
    ErrorNumber INT,
    ErrorSeverity INT,
    ErrorState INT,
    Timestamp DATETIME
);

-- Criar uma stored procedure para inserir logs de erro
CREATE PROCEDURE dbo.LogError
    @ErrorMessage NVARCHAR(4000),
    @ErrorNumber INT,
    @ErrorSeverity INT,
    @ErrorState INT
AS
BEGIN
 -- Inserção na tabela ErrorLog
    INSERT INTO ErrorLog (ErrorMessage, ErrorNumber, ErrorSeverity, ErrorState, Timestamp)
    VALUES (@ErrorMessage, @ErrorNumber, @ErrorSeverity, @ErrorState, GETDATE());
END;

