-- Restaurar o último backup que contenha os dados excluídos
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
