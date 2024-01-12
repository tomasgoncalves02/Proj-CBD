--Identificacao 202100744_202100728
-- Metadados: Stored Procedure para registrar o n�mero de registros e estimativa de espa�o ocupado:
CREATE PROCEDURE dbo.RegistrarEstatisticasTabelas
AS
BEGIN
    -- Criar uma tabela de estat�sticas (se ainda n�o existir)
    IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'EstatisticasTabelas')
    BEGIN
        CREATE TABLE dbo.EstatisticasTabelas (
            TabelaID INT IDENTITY(1,1) PRIMARY KEY,
            NomeTabela NVARCHAR(128),
            NumRegistros INT,
            EspacoOcupadoKB DECIMAL(10, 2),
            DataRegistro DATETIME
        );
    END

    -- Estat�sticas para cada tabela
    INSERT INTO dbo.EstatisticasTabelas (NomeTabela, NumRegistros, EspacoOcupadoKB, DataRegistro)
    SELECT
        t.name AS NomeTabela,
        SUM(p.rows) AS NumRegistros,
        SUM(a.total_pages) * 8 / 1024 AS EspacoOcupadoKB,
        GETDATE() AS DataRegistro
    FROM sys.tables t
    INNER JOIN sys.indexes i ON t.object_id = i.object_id
    INNER JOIN sys.partitions p ON i.object_id = p.object_id AND i.index_id = p.index_id
    INNER JOIN sys.allocation_units a ON p.partition_id = a.container_id
    GROUP BY t.name;
END;
