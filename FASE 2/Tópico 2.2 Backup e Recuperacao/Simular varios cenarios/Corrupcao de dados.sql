-- Identifique a extensão da corrupção e os objetos afetados
DBCC CHECKDB ('AdventureWorks') WITH NO_INFOMSGS;
GO
-- Restaure o último backup válido antes da corrupção
RESTORE DATABASE AdventureWorks
FROM DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\Backup\AdventureWorks.bak'
WITH REPLACE;
GO

-- Restaurar o último backup completo com NORECOVERY
RESTORE DATABASE AdventureWorks
FROM DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\Backup\AdventureWorks.bak'
WITH NORECOVERY;
GO

-- Aplicar backups diferenciais e de log
RESTORE DATABASE AdventureWorks
FROM DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\Backup\AdventureWorksDiferencial.bak'
WITH NORECOVERY;

GO
-- Finalizar a restauração
RESTORE DATABASE AdventureWorks WITH RECOVERY;