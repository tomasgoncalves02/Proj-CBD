-- Criar uma stored procedure fict�cia para enviar e-mails
CREATE PROCEDURE sp_SendPasswordResetEmail
  @RecipientEmail NVARCHAR(80),
  @EmailSubject NVARCHAR(255),
  @EmailBody NVARCHAR(MAX),
  @CustomerKey INT,
  @NewPassword NVARCHAR(60)  
AS
BEGIN
  -- Simular o envio do e-mail (este � um exemplo fict�cio)
  PRINT 'Simulating email sending to ' + @RecipientEmail;
  PRINT 'Subject: ' + @EmailSubject;
  PRINT 'Body: ' + @EmailBody;

  -- Insira os dados na tabela SentEmails
  INSERT INTO SentEmails (Mensage, Timestamp, CustomerKey)
  VALUES (@EmailBody, GETDATE(), @CustomerKey);

  -- Verifica se a simula��o foi bem-sucedida antes de atualizar a password
  IF @@ROWCOUNT > 0
  BEGIN
    -- Simular uma atualiza��o de senha na tabela Customer
    UPDATE Customer
    SET Password = @NewPassword
    WHERE CustomerKey = @CustomerKey;
  END
END

--Executar o procedimento com um @RecipientEmail, @EmailSubject, @EmailBody, @CustomerKey, @NewPassword
exec sp_SendPasswordResetEmail 'jon24@adventure-works.com', 'Recupera��o de password', 'Nova Password: 1234567890', 11000, '1234567890'
