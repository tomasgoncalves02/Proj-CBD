

-- Criar procedimento AdicionarAcesso
CREATE PROCEDURE AdicionarAcesso
    @UserID INT
AS
BEGIN
    INSERT INTO Acessos (CustomerKey, DataAcesso)
    VALUES (@UserID, CURRENT_TIMESTAMP);

    -- Verificar se a inserção foi bem-sucedida
    IF @@ROWCOUNT > 0
    BEGIN
        PRINT 'Acesso adicionado com sucesso.';
    END
    ELSE
    BEGIN
        PRINT 'Erro ao adicionar o acesso.';
    END
END

-- Executar o procedimento com um id especifico
EXEC AdicionarAcesso 11001;
