-- Adicionando colunas para armazenar hash e salt na tabela Customer, apenas se não existirem
IF NOT EXISTS (
    SELECT * FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'Customer' AND 
    (COLUMN_NAME = 'PasswordHash' OR COLUMN_NAME = 'PasswordSalt')
)
BEGIN
    ALTER TABLE Customer
    ADD PasswordHash VARBINARY(256),
        PasswordSalt VARBINARY(128);
END;
GO
-- Atualizando senhas existentes na tabela Customer
UPDATE Customer
SET PasswordHash = HASHBYTES('SHA2_512', CONCAT(Password, NEWID())),
    PasswordSalt = NEWID(),
    Password = NULL;
GO
-- Removendo a coluna de senha original
ALTER TABLE Customer
DROP COLUMN Password;
GO
-- Criar a chave mestra se ainda não existir
IF NOT EXISTS (SELECT * FROM sys.symmetric_keys WHERE name = '##MS_DatabaseMasterKey##')
BEGIN
    CREATE MASTER KEY ENCRYPTION BY PASSWORD = '123'; 
END;
GO
-- Abrir a chave mestra na sessão atual
OPEN MASTER KEY DECRYPTION BY PASSWORD = '123'; 
GO
-- Criar a chave simétrica se não existir
IF NOT EXISTS (SELECT * FROM sys.symmetric_keys WHERE name = 'MySymmetricKey')
BEGIN
    CREATE SYMMETRIC KEY MySymmetricKey
    WITH ALGORITHM = AES_256
    ENCRYPTION BY PASSWORD = '123';
END
ELSE
BEGIN
    -- Se já existir, abra a chave simétrica
    OPEN SYMMETRIC KEY MySymmetricKey
    DECRYPTION BY PASSWORD = '123'; 
END;
GO
-- Criar o certificado se não existir
IF NOT EXISTS (SELECT * FROM sys.certificates WHERE name = 'MyCertificate')
BEGIN
    CREATE CERTIFICATE MyCertificate
    WITH SUBJECT = 'Certificado';
END;
GO
-- Adicionando coluna EncryptedAnswer na tabela Response, apenas se não existir
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Response' AND COLUMN_NAME = 'EncryptedAnswer')
BEGIN
    ALTER TABLE Response
    ADD EncryptedAnswer VARBINARY(MAX);
END;
GO
-- Inserindo dados criptografados na tabela Response
OPEN SYMMETRIC KEY MySymmetricKey DECRYPTION BY PASSWORD = '123';
UPDATE Response
SET EncryptedAnswer = ENCRYPTBYKEY(KEY_GUID('MySymmetricKey'), Response);
GO
-- Remover a coluna original
ALTER TABLE Response
DROP COLUMN Response;
GO
-- Adicionando coluna EncryptedQuestion na tabela Questions, apenas se não existir
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Questions' AND COLUMN_NAME = 'EncryptedQuestion')
BEGIN
    ALTER TABLE Questions
    ADD EncryptedQuestion VARBINARY(MAX);
END;
GO
-- Inserindo dados criptografados na tabela Questions
OPEN SYMMETRIC KEY MySymmetricKey DECRYPTION BY PASSWORD = '123';
UPDATE Questions
SET EncryptedQuestion = ENCRYPTBYKEY(KEY_GUID('MySymmetricKey'), Question);

-- Remover a coluna original
ALTER TABLE Questions
DROP COLUMN Question;

-- Fechar a chave mestra
CLOSE MASTER KEY;

-- Visualizar os dados
SELECT * FROM Customer;
SELECT * FROM Questions;
SELECT * FROM Response;
