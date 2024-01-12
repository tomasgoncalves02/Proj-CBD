--Identificação: 202100744_202100728

-- Layout da BD

-- Espaço ocupado por registo de cada tabela;
EXEC sp_spaceused 'Acessos';
EXEC sp_spaceused 'CategoryList';
EXEC sp_spaceused 'Currency';
EXEC sp_spaceused 'Customer';
EXEC sp_spaceused 'ErrorLog';
EXEC sp_spaceused 'EstatisticasTabelas';
EXEC sp_spaceused 'MetadadosTabelas';
EXEC sp_spaceused 'Model';
EXEC sp_spaceused 'ProductCategory';
EXEC sp_spaceused 'Products';
EXEC sp_spaceused 'ProductSubCategory';
EXEC sp_spaceused 'Questions';
EXEC sp_spaceused 'Response';
EXEC sp_spaceused 'Sales2';
EXEC sp_spaceused 'SalesTerritory';
EXEC sp_spaceused 'SentEmails';
EXEC sp_spaceused 'sysdiagrams';


-- Espaço ocupado por cada tabela com o número atual de registos;

SELECT 
    t.name AS 'Nome da Tabela',
    ds.name AS 'Filegroup',
    f.type_desc AS 'Tipo de Filegroup',
    df.growth AS 'Taxa de Crescimento (KB)',
    df.max_size * 8 AS 'Tamanho Máximo (KB)',
    SUM(p.rows) AS 'Número de Registros',
    SUM(a.total_pages) * 8 AS 'Espaço Total (KB)'
FROM sys.tables t
INNER JOIN sys.indexes i ON t.object_id = i.object_id
INNER JOIN sys.partitions p ON i.object_id = p.object_id AND i.index_id = p.index_id
INNER JOIN sys.allocation_units a ON p.partition_id = a.container_id
INNER JOIN sys.data_spaces ds ON ds.data_space_id = i.data_space_id
INNER JOIN sys.filegroups f ON f.data_space_id = ds.data_space_id
INNER JOIN sys.database_files df ON f.data_space_id = df.data_space_id
GROUP BY t.name, ds.name, f.type_desc, df.growth, df.max_size
ORDER BY SUM(a.total_pages) DESC;



-- Propor uma taxa de crescimento por tabela 

-- Criação de tabela temporaria 'HistoricalGrowth'
WITH HistoricalGrowth AS (
    -- Consulta para obter informações sobre o espaço da tabela
    SELECT 
        t.name AS TableName,
        MAX(p.rows) AS MaxRows,
        MAX(a.total_pages) * 8 AS MaxSpaceKB
    FROM sys.tables t
    INNER JOIN sys.indexes i ON t.object_id = i.object_id
    INNER JOIN sys.partitions p ON i.object_id = p.object_id AND i.index_id = p.index_id
    INNER JOIN sys.allocation_units a ON p.partition_id = a.container_id
    GROUP BY t.name
)

SELECT 
    TableName,
    CAST(
        COALESCE(
            NULLIF(
                ROUND(
                    AVG(CAST(MaxSpaceKB AS DECIMAL) / NULLIF(CAST(MaxRows AS DECIMAL), 0)),
                    2
                ),
                0
            ),
            0
        ) AS DECIMAL(18, 2)
    ) AS AverageGrowthRate
FROM HistoricalGrowth
GROUP BY TableName;



-- Dimensionar o nº e tipos de acessos.
-- Procedimento armazenado para criar dinamicamente um Trigger de erro
CREATE PROCEDURE dbo.CreateErrorTrigger
    @TableName NVARCHAR(255)
AS
BEGIN
    DECLARE @TriggerScript NVARCHAR(MAX);
    
    -- Construir o script do Trigger dinâmico (ou seja criar trigger para todas as tabelas)
   SET @TriggerScript = '
    CREATE TRIGGER Trg_' + @TableName + '_Error
    ON ' + @TableName + '
    AFTER INSERT, UPDATE, DELETE
    AS
    BEGIN
        -- Simular um erro (substitua por sua lógica de verificação de erro)
        IF (EXISTS (SELECT 1 FROM inserted) AND EXISTS (SELECT 1 FROM deleted))
        BEGIN
            DECLARE @ErrorMessage NVARCHAR(4000) = ''Erro simulado ocorreu na tabela ' + @TableName + ' durante uma operação de UPDATE.'';
            DECLARE @ErrorNumber INT = 50000;  -- Número de erro personalizado
            DECLARE @ErrorSeverity INT = 16;   -- Severidade do erro
            DECLARE @ErrorState INT = 1;       -- Estado do erro
            
            -- Chamar o procedimento armazenado para registrar o erro
            EXEC dbo.ErrorLog @ErrorMessage, @ErrorNumber, @ErrorSeverity, @ErrorState;
        END;
    END;
';

    -- Executar o script do Trigger dinâmico
    EXEC sp_executesql @TriggerScript;
END;


-- Uso do procedimento armazenado para criar um Trigger dinâmico
EXEC dbo.CreateErrorTrigger @TableName = 'Sales2';
EXEC dbo.CreateErrorTrigger @TableName = 'Products';
EXEC dbo.CreateErrorTrigger @TableName = 'ProductSubCategory';
EXEC dbo.CreateErrorTrigger @TableName = 'SalesTerritory';
EXEC dbo.CreateErrorTrigger @TableName = 'Model';
EXEC dbo.CreateErrorTrigger @TableName = 'ProductCategory';
EXEC dbo.CreateErrorTrigger @TableName = 'Questions';
EXEC dbo.CreateErrorTrigger @TableName = 'Response';
EXEC dbo.CreateErrorTrigger @TableName = 'CategoryList';
EXEC dbo.CreateErrorTrigger @TableName = 'Color';
EXEC dbo.CreateErrorTrigger @TableName = 'SentEmails';