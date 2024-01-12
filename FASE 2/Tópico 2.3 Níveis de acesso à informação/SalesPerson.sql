-- Criar conta SalesPerson
CREATE LOGIN SalesPersonLogin WITH PASSWORD = '12345678';
CREATE USER SalesPersonUser FOR LOGIN SalesPersonLogin;
GO
-- Revogar acesso a todas as tabelas
DENY SELECT, INSERT, UPDATE, DELETE ON DATABASE::AdventureWorks TO SalesPersonUser;
GO
-- Conceder acesso apenas à tabela de suporte às vendas
GRANT SELECT ON SalesOrders TO SalesPersonUser;
GO

SELECT 
    princ.type_desc AS [Type],
    perm.permission_name,
    perm.state_desc AS [Permission State],
    obj.type_desc AS [Object Type],
    obj.name AS [Object Name]
FROM sys.database_permissions perm
LEFT JOIN sys.database_principals princ ON perm.grantee_principal_id = princ.principal_id
LEFT JOIN sys.objects obj ON perm.major_id = obj.object_id
WHERE princ.name = 'SalesPersonUser';