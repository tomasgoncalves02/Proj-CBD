-- Parâmetro de data para o início da transação
DECLARE @inicio_transacao DATETIME = GETDATE();

-- Declarar variáveis para armazenar os totais de vendas
DECLARE @total_vendas_user1 MONEY;
DECLARE @total_vendas_user2 MONEY;

-- Iniciar a transação para User 1
BEGIN TRANSACTION;

-- Calcular o total das vendas até o início da transação para User 1
SELECT @total_vendas_user1 = SUM(p.ListPrice)
FROM [AdventureWorks].[dbo].[SalesOrders] so
JOIN [AdventureWorks].[dbo].[OrderDetails] od ON so.SalesOrderNumber = od.SalesOrderNumber
JOIN [AdventureWorks].[dbo].[Products] p ON od.ProductKey = p.ProductKey
WHERE so.OrderDate <= @inicio_transacao
  AND so.CustomerKey = 11000; 

-- Confirmar a transação para User 1
COMMIT;

-- Iniciar a transação para User 2
BEGIN TRANSACTION;

-- Calcular o total das vendas até o início da transação para User 2 
SELECT @total_vendas_user2 = SUM(p.ListPrice)
FROM [AdventureWorks].[dbo].[SalesOrders] so
JOIN [AdventureWorks].[dbo].[OrderDetails] od ON so.SalesOrderNumber = od.SalesOrderNumber
JOIN [AdventureWorks].[dbo].[Products] p ON od.ProductKey = p.ProductKey
WHERE so.OrderDate <= @inicio_transacao
  AND so.CustomerKey = 11001; -- Supondo que CustomerKey 2 seja associado ao User 2

-- Confirmar a transação para User 2
COMMIT;

-- Exibir os resultados formatados
SELECT 'User 1 Total Vendas' AS user_label, CONVERT(VARCHAR, @total_vendas_user1, 1) AS total_vendas_user11000;
SELECT 'User 2 Total Vendas' AS user_label, CONVERT(VARCHAR, @total_vendas_user2, 1) AS total_vendas_user11001;
