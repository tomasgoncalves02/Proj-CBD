-- User 1 TRANSACTION A
BEGIN TRANSACTION;

-- variaveis
DECLARE @ProductKey1 INT = 210;
DECLARE @NewUnitPrice1 FLOAT = 10.0;

-- Verificar se a condi��o ainda � v�lida
IF EXISTS (SELECT 1 FROM Products WHERE ProductKey = @ProductKey1)
BEGIN
    -- Alterar o pre�o do Produto 1
    UPDATE Products
    SET ListPrice = @NewUnitPrice1
    WHERE ProductKey = @ProductKey1;

    -- Verificar se a altera��o est� correta
    SELECT * FROM Products WHERE ProductKey = @ProductKey1;

    -- Confirmar a transa��o do User 1
    COMMIT;
END
ELSE
BEGIN
    -- Se a condi��o n�o for mais v�lida, reverter a transa��o do User 1
    ROLLBACK;
    PRINT 'Condi��o inv�lida para User 1. Transa��o revertida.';
END

-- User 2 TRANSACTION B
BEGIN TRANSACTION;

-- variaveis
DECLARE @ProductKey2 INT = 210;
DECLARE @NewUnitPrice2 FLOAT = 15.0;

-- Verificar se a condi��o ainda � v�lida
IF EXISTS (SELECT 1 FROM Products WHERE ProductKey = @ProductKey2)
BEGIN
    -- Alterar o pre�o do Produto 2
    UPDATE Products
    SET ListPrice = @NewUnitPrice2
    WHERE ProductKey = @ProductKey2;

    -- Verificar se a altera��o est� correta
    SELECT * FROM Products WHERE ProductKey = @ProductKey2;

    -- Confirmar a transa��o do User 2
    COMMIT;
END
ELSE
BEGIN
    -- Se a condi��o n�o for mais v�lida, reverter a transa��o do User 2
    ROLLBACK;
    PRINT 'Condi��o inv�lida para User 2. Transa��o revertida.';
END
