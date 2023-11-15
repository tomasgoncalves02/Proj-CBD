-- Criar uma stored procedure fictícia para enviar e-mails
CREATE PROCEDURE sp_SendPasswordResetEmail
  @RecipientEmail NVARCHAR(80),
  @EmailSubject NVARCHAR(255),
  @EmailBody NVARCHAR(MAX),
  @CustomerKey INT,
  @NewPassword NVARCHAR(60),
  @SecurityQuestion NVARCHAR(255),
  @SecurityAnswer NVARCHAR(255)
AS
BEGIN
  -- Simular o envio do e-mail (este é um exemplo fictício)
  PRINT 'Simulating email sending to ' + @RecipientEmail;
  PRINT 'Subject: ' + @EmailSubject;
  PRINT 'Body: ' + @EmailBody;

  -- Insira os dados na tabela SentEmails
  INSERT INTO SentEmails (Mensage, Timestamp, CustomerKey)
  VALUES (@EmailBody, GETDATE(), @CustomerKey);

  -- Verifica se a simulação foi bem-sucedida antes de atualizar a senha
  IF @@ROWCOUNT > 0
  BEGIN
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
    PRINT 'Falha ao enviar o e-mail. A senha não foi alterada.';
  END
END

-- Executar o procedimento com um @RecipientEmail, @EmailSubject, @EmailBody, @CustomerKey, @NewPassword, @SecurityQuestion e @SecurityAnswer
EXEC sp_SendPasswordResetEmail 'jon24@adventure-works.com', 'Recuperação de senha', 'Nova Senha: 1234567890', 11000, '1234567890', 'Qual é o nome do teu cão?', 'Billy';
