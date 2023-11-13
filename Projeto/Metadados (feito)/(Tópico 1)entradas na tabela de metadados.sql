
-- Metadados -> Stored Procedure para gerar entradas na tabela de metadados:
CREATE PROCEDURE dbo.GerarEntradasTabelaMetadados
AS
BEGIN
    -- Criação de uma tabela de metadados
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

    -- Inserir as informações das tabelas e colunas no catalogo
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
