--Identificação: 202100744_202100728
-- Criar um procedimento RemoverAcesso
CREATE PROCEDURE RemoverAcesso
    @UserID INT
AS
BEGIN
    DELETE FROM Acessos
    WHERE CustomerKey = @UserID;

    -- Verificar se a exclus�o foi bem-sucedida
    IF @@ROWCOUNT > 0
    BEGIN
        PRINT 'Acesso removido com sucesso.';
    END
    ELSE
    BEGIN
        PRINT 'Erro ao remover o acesso. Utilizador n�o encontrado.';
    END
END

--Executar o procedimento com um id especifico
exec RemoverAcesso 11001