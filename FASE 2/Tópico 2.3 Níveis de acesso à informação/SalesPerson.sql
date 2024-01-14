-- Criar conta SalesPerson
CREATE LOGIN SalesPersonLogin WITH PASSWORD = '12345678';
CREATE USER SalesPersonUser FOR LOGIN SalesPersonLogin;
GO

-- Conceder acesso total às tabelas de suporte às vendas
GRANT SELECT, INSERT, UPDATE, DELETE ON SalesOrders TO SalesPersonUser;
GRANT SELECT, INSERT, UPDATE, DELETE ON SalesOrderCosts TO SalesPersonUser;
GRANT SELECT, INSERT, UPDATE, DELETE ON OrderDetails TO SalesPersonUser;

-- Conceder apenas acesso em modo de consulta às demais tabelas
GRANT SELECT ON Acessos TO SalesPersonUser;
GRANT SELECT ON CategoryList TO SalesPersonUser;
GRANT SELECT ON Color TO SalesPersonUser;
GRANT SELECT ON Currency TO SalesPersonUser;
GRANT SELECT ON Customer TO SalesPersonUser;
GRANT SELECT ON ErrorLog TO SalesPersonUser;
GRANT SELECT ON Model TO SalesPersonUser;
GRANT SELECT ON ProductCategory TO SalesPersonUser;
GRANT SELECT ON Products TO SalesPersonUser;
GRANT SELECT ON ProductSubCategory TO SalesPersonUser;
GRANT SELECT ON Questions TO SalesPersonUser;
GRANT SELECT ON Response TO SalesPersonUser;
GRANT SELECT ON SentEmails TO SalesPersonUser;
GO

-- negar acesso a todas as tabelas
DENY SELECT, INSERT, UPDATE, DELETE ON DATABASE::AdventureWorks TO SalesPersonUser;
GO

-- Verificar as permissões concedidas ao user SalesPersonUser
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
