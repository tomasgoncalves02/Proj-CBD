--Identificação: 202100744_202100728
--Create procedimento AdicionarAcesso
CREATE PROCEDURE AdicionarAcesso
    @UserID INT,
    @RecipientEmail NVARCHAR(80),
    @EmailSubject NVARCHAR(255)
AS
BEGIN
    INSERT INTO Acessos (CustomerKey, DataAcesso)
    VALUES (@UserID, CURRENT_TIMESTAMP);

    -- Verificar se a inserção foi bem-sucedida
    IF @@ROWCOUNT > 0
    BEGIN
        PRINT 'Acesso adicionado com sucesso.';

        -- recuperação da senha
        DECLARE @CharacterSet NVARCHAR(255) = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
        DECLARE @NewPassword NVARCHAR(60) = '';
        DECLARE @Counter INT = 1;

        WHILE @Counter <= 12
        BEGIN
            SET @NewPassword = @NewPassword + SUBSTRING(@CharacterSet, CAST(RAND() * LEN(@CharacterSet) + 1 AS INT), 1);
            SET @Counter = @Counter + 1;
        END

        -- Simular o envio do e-mail 
        PRINT 'Simulating email sending to ' + @RecipientEmail;
        PRINT 'Subject: ' + @EmailSubject;
        PRINT 'Body: Your new password is ' + @NewPassword;

        -- Insira os dados na tabela SentEmails
        INSERT INTO SentEmails (Mensage, Timestamp, CustomerKey)
        VALUES ('Your new password is ' + @NewPassword, GETDATE(), @UserID);

        -- Atualiza a senha na tabela Customer
        UPDATE Customer
        SET Password = @NewPassword
        WHERE CustomerKey = @UserID;

        PRINT 'Senha atualizada com sucesso!';
    END
    ELSE
    BEGIN
        PRINT 'Erro ao adicionar o acesso.';
    END
END

EXEC AdicionarAcesso 
    @UserID = 11000,
    @RecipientEmail = 'jon24@adventure-works.com',
    @EmailSubject = 'Password Reset'