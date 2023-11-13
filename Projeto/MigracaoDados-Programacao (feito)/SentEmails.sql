
-- Criacao da tabela SentEmails
CREATE TABLE SentEmails
(
  SentEmailID INT IDENTITY(1,1) NOT NULL,
  Mensage NVARCHAR(MAX),
  Timestamp DATETIME,
  CustomerKey INT NOT NULL,
  PRIMARY KEY (SentEmailID),
  FOREIGN KEY (CustomerKey) REFERENCES Customer(CustomerKey)
);

