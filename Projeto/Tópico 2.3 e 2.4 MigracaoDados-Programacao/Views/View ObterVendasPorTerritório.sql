

-- Create view VendasPorTerritorioView
CREATE VIEW VendasPorTerritorioView AS
    SELECT 
        ST.SalesTerritoryRegion AS RegiaoDeVendas,
        COUNT(S2.SalesOrderNumber) AS TotalDeVendas
    FROM Sales2 AS S2
    INNER JOIN SalesTerritory AS ST ON S2.SalesTerritoryKey = ST.SalesTerritoryKey
    GROUP BY ST.SalesTerritoryRegion;


-- Query da view VendasPorTerritorioView
SELECT * FROM VendasPorTerritorioView;
