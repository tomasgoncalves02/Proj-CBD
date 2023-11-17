
-- Criar uma view CustomerDetailsView
CREATE VIEW CustomerDetailsView AS
    SELECT *
    FROM Customer;


-- Query para a view CustomerDetailsView
SELECT *
FROM CustomerDetailsView
WHERE CustomerKey = 11000;
