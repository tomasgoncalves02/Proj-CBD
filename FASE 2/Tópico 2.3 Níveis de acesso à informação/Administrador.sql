/*202100728_202100744*/

-- Criação de um login para o administrador 
CREATE LOGIN Admin1 WITH PASSWORD = '12345678';
GO
-- Criação de um user na base de dados associado ao login do administrador
CREATE USER Admin1 FOR LOGIN Admin1;
GO
-- Concede permissões para o user administrador
GRANT CONTROL SERVER TO Admin1; -- Permissões de controle sobre o servidor
GRANT ALTER ANY DATABASE TO Admin1; -- Permissões para alterar qualquer base de dados
GO
-- Concede permissões específicas na base de dados
GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA :: dbo TO Admin1; -- Permissões de manipulação de dados no esquema 'dbo'
GRANT EXECUTE ON SCHEMA :: dbo TO Admin1; -- Permissões para executar procedimentos armazenados no esquema 'dbo'
GO
-- Server para verificar as permissões do user no nível de servidor
SELECT *
FROM sys.server_permissions
WHERE grantee_principal_id = (SELECT principal_id FROM sys.server_principals WHERE name = 'Admin1');