--Identificação: 202100744_202100728
-- Criação da tabela de Acessos
CREATE TABLE Acessos (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerKey INT, 
    DataAcesso DATETIME,
    FOREIGN KEY (CustomerKey) REFERENCES Customer(CustomerKey)
);

