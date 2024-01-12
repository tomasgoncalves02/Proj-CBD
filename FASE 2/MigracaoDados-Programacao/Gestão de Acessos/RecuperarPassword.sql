--Identificação: 202100744_202100728
-- Criação da procedure sp_SendPasswordResetEmail
CREATE PROCEDURE sp_SendPasswordResetEmail
  @RecipientEmail NVARCHAR(80),
  @EmailSubject NVARCHAR(255),
  @CustomerKey INT,
  @SecurityQuestion NVARCHAR(255),
  @SecurityAnswer NVARCHAR(255)
AS
BEGIN
  -- Verificar se o email e o CustomerKey correspondem
  IF EXISTS (
    SELECT 1
    FROM Customer
    WHERE EmailAddress = @RecipientEmail
      AND CustomerKey = @CustomerKey
  )
  BEGIN
    -- Gera uma senha aleatória
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
    VALUES ('Your new password is ' + @NewPassword, GETDATE(), @CustomerKey);

    -- Verifica a resposta à pergunta de segurança usando a tabela Response
    IF EXISTS (
      SELECT 1
      FROM Response AS r
      JOIN Questions AS q ON r.QuestionID = q.QuestionID
      WHERE r.Response = @SecurityAnswer
        AND q.Question = @SecurityQuestion
    )
    BEGIN
      -- Simular uma atualização de senha na tabela Customer
      UPDATE Customer
      SET Password = @NewPassword
      WHERE CustomerKey = @CustomerKey;

      PRINT 'Senha atualizada com sucesso!';
    END
    ELSE
    BEGIN
      PRINT 'Resposta à pergunta de segurança incorreta. A senha não foi alterada.';
    END
  END
  ELSE
  BEGIN
    PRINT 'O email fornecido não corresponde ao ID do cliente.';
    -- Não prosseguir com a redefinição de senha
  END
END;
GO

EXEC sp_SendPasswordResetEmail 
  @RecipientEmail = 'jon24@adventure-works.com',
  @EmailSubject = 'Password Reset',
  @CustomerKey = 11000, 
  @SecurityQuestion = 'Qual é o nome do teu cão?',
  @SecurityAnswer = 'Billy';
