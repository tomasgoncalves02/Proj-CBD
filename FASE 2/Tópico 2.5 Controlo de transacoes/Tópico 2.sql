-- User 1 TRANSACTION A
BEGIN TRANSACTION;

-- variaveis
DECLARE @ProductKey1 INT = 210;
DECLARE @NewUnitPrice1 FLOAT = 10.0;

-- Verificar se a condição ainda é válida
IF EXISTS (SELECT 1 FROM Products WHERE ProductKey = @ProductKey1)
BEGIN
    -- Alterar o preço do Produto 1
    UPDATE Products
    SET ListPrice = @NewUnitPrice1
    WHERE ProductKey = @ProductKey1;

    -- Verificar se a alteração está correta
    SELECT * FROM Products WHERE ProductKey = @ProductKey1;

    -- Confirmar a transação do User 1
    COMMIT;
END
ELSE
BEGIN
    -- Se a condição não for mais válida, reverter a transação do User 1
    ROLLBACK;
    PRINT 'Condição inválida para User 1. Transação revertida.';
END

-- User 2 TRANSACTION B
BEGIN TRANSACTION;

-- variaveis
DECLARE @ProductKey2 INT = 210;
DECLARE @NewUnitPrice2 FLOAT = 15.0;

-- Verificar se a condição ainda é válida
IF EXISTS (SELECT 1 FROM Products WHERE ProductKey = @ProductKey2)
BEGIN
    -- Alterar o preço do Produto 2
    UPDATE Products
    SET ListPrice = @NewUnitPrice2
    WHERE ProductKey = @ProductKey2;

    -- Verificar se a alteração está correta
    SELECT * FROM Products WHERE ProductKey = @ProductKey2;

    -- Confirmar a transação do User 2
    COMMIT;
END
ELSE
BEGIN
    -- Se a condição não for mais válida, reverter a transação do User 2
    ROLLBACK;
    PRINT 'Condição inválida para User 2. Transação revertida.';
END
