
-- Criar procedimento para EditarAcessos
CREATE PROCEDURE EditarAcessos
    @UserID INT
AS
BEGIN
    UPDATE Acessos
    SET DataAcesso = CURRENT_TIMESTAMP
    WHERE CustomerKey = @UserID;

    -- Verificar se a atualiza��o foi bem-sucedida
    IF @@ROWCOUNT > 0
    BEGIN
        PRINT 'Acesso atualizado com sucesso.';
    END
    ELSE
    BEGIN
        PRINT 'Utilizador n�o encontrado ou acesso n�o atualizado.';
    END
END

--Executar o procedimento com um id especifico
exec EditarAcessos 11000