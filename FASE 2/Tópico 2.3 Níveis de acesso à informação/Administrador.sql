/*202100728_202100744*/

-- Criação de um login para o administrador (master) 
CREATE LOGIN Admin2 WITH PASSWORD = '12345678';
GO
-- Criação de um user na base de dados associado ao login do administrador (master)
CREATE USER Admin2 FOR LOGIN Admin2;
GO
-- Concede permissões para o user administrador (master)
GRANT CONTROL SERVER TO Admin2; -- Permissões de controle sobre o servidor
GRANT ALTER ANY DATABASE TO Admin2; -- Permissões para alterar qualquer base de dados
GO
-- Concede permissões específicas na base de dados (master)
GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA :: dbo TO Admin2; -- Permissões de manipulação de dados no esquema 'dbo'
GRANT EXECUTE ON SCHEMA :: dbo TO Admin2; -- Permissões para executar procedimentos armazenados no esquema 'dbo'
GO
-- Server para verificar as permissões do user no nível de servidor (master)
SELECT *
FROM sys.server_permissions
WHERE grantee_principal_id = (SELECT principal_id FROM sys.server_principals WHERE name = 'Admin2');