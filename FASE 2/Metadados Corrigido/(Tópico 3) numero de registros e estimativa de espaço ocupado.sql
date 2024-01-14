--Identificacao 202100744_202100728
-- Metadados: Stored Procedure para registrar o n�mero de registros e estimativa de espa�o ocupado:
CREATE PROCEDURE RegistrarEstatisticasTabelas
AS
BEGIN
    -- Criar tabela de estatísticas se ainda não existir
    IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'EstatisticasTabelas')
    BEGIN
        CREATE TABLE EstatisticasTabelas (
            TabelaID INT IDENTITY(1,1) PRIMARY KEY,
            NomeTabela NVARCHAR(128),
            NumRegistros INT,
            EspacoOcupadoKB DECIMAL(18, 2),
            DataRegistro DATETIME
        );
    END

    -- Tabela temporária para armazenar resultados atuais
    CREATE TABLE #TempResults (
        NomeTabela NVARCHAR(128),
        NumRegistros INT,
        EspacoOcupadoKB DECIMAL(18, 2)
    );

    -- Inserir dados na tabela temporária
    INSERT INTO #TempResults (NomeTabela, NumRegistros, EspacoOcupadoKB)
    SELECT
        t.name AS NomeTabela,
        SUM(p.rows) AS NumRegistros,
        SUM(a.total_pages) * 8 / 1024 AS EspacoOcupadoKB
    FROM sys.tables t
    INNER JOIN sys.indexes i ON t.object_id = i.object_id
    INNER JOIN sys.partitions p ON i.object_id = p.object_id AND i.index_id = p.index_id
    INNER JOIN sys.allocation_units a ON p.partition_id = a.container_id
    GROUP BY t.name;

    -- Inserir dados na tabela de estatísticas
    INSERT INTO EstatisticasTabelas (NomeTabela, NumRegistros, EspacoOcupadoKB, DataRegistro)
    SELECT
        NomeTabela,
        NumRegistros,
        EspacoOcupadoKB,
        GETDATE() AS DataRegistro
    FROM #TempResults;

    -- Apagar tabela temporária
    DROP TABLE #TempResults;
END;
GO
--Executar Procedimento RegistrarEstatisticasTabelas
EXEC dbo.RegistrarEstatisticasTabelas;
GO
-- Consultar a Tabela EstatisticasTabelas
SELECT * FROM dbo.EstatisticasTabelas;
