-- Criar a view para o território Australia
CREATE VIEW PacificSales AS
SELECT * FROM SalesTerritory WHERE SalesTerritoryCountry = 'Australia';
GO
-- Criar conta SalesTerritory
CREATE LOGIN SalesTerritoryLogin WITH PASSWORD = '12345678';
CREATE USER SalesTerritoryUser FOR LOGIN SalesTerritoryLogin;
GO
-- Conceder acesso à view específica
GRANT SELECT ON PacificSales TO SalesTerritoryUser;
GO
-- Selecionar os dados da view 'PacificSales'
SELECT * FROM PacificSales;
GO
-- Para um login específico
EXEC sp_helplogins 'SalesTerritoryLogin';
GO
-- Para um user específico
EXEC sp_helpuser 'SalesTerritoryUser';