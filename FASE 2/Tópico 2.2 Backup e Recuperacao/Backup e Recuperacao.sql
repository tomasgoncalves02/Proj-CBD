/*202100728_202100744*/
/*
	2.2 Backup e Recupera��o
	
	--  modelo de recuperação como 'Full' para permitir backups de log */
ALTER DATABASE AdventureWorks SET RECOVERY FULL;


/*
	Backup Integral (Full):
*/

BACKUP DATABASE AdventureWorks TO DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\Backup\AdventureWorks.bak';

/*
	Backup Diferencial:
*/

BACKUP DATABASE AdventureWorks TO DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\Backup\AdventureWorksDiferencial.bak' WITH DIFFERENTIAL;


/*
	Backup de Log:
*/

BACKUP LOG AdventureWorks TO DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\Backup\BackLog.trn';
