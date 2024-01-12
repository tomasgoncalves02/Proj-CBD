--Identificação: 202100744_202100728
-- Create view VendasPorTerritorioView
CREATE VIEW VendasPorTerritorioView AS
    SELECT 
        ST.SalesTerritoryRegion AS RegiaoDeVendas,
        COUNT(SO.SalesOrderNumber) AS TotalDeVendas
    FROM SalesOrders AS SO
    INNER JOIN SalesTerritory AS ST ON SO.SalesTerritoryKey = ST.SalesTerritoryKey
    INNER JOIN OrderDetails AS OD ON SO.SalesOrderNumber = OD.SalesOrderNumber
    GROUP BY ST.SalesTerritoryRegion;
GO


-- Query da view VendasPorTerritorioView
SELECT * FROM VendasPorTerritorioView;
