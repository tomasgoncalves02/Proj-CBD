--Identificação: 202100744_202100728
-- Criar uma view CustomerDetailsView
CREATE VIEW CustomerDetailsView AS
    SELECT *
    FROM Customer;


-- Query para a view CustomerDetailsView
SELECT *
FROM CustomerDetailsView
WHERE CustomerKey = 11000;
